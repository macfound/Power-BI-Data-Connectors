// This file contains your Data Connector logic
section UptimeRobot;

// Global Variables
DefaultRequestHeaders = [#"Cache-Control"="no-cache",#"Content-type"="application/x-www-form-urlencoded"];
RootUri = "https://api.uptimerobot.com/v2/";

[DataSource.Kind="UptimeRobot", Publish="UptimeRobot.Publish"]
shared UptimeRobot.Contents = Value.ReplaceType(UptimeRobotNavTable, type function () as any);

// Navigation Table Creation
shared UptimeRobotNavTable = () as table =>
    let
        source = #table({"Name", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
            { "Account Details", UptimeRobot.AccountDetails(), "Table", "AccountDetails", true },
            { "Alert Contacts", UptimeRobot.AlertContacts(), "Table", "AlertContacts", true },
            { "Logs", UptimeRobot.MonitorLogs(), "Table", "Logs", true },
            { "Maintenance Windows", UptimeRobot.MaintenanceWindows(), "Table", "MaintenanceWindows", true },
            { "Monitors", UptimeRobot.Monitors(), "Table", "Monitors", true },
            { "Public Status Pages", UptimeRobot.PublicStatusPages(), "Table", "PublicStatusPages", true }
        }),
        navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
        [
            NavigationTable.NameColumn = nameColumn, 
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn, 
            Preview.DelayColumn = itemNameColumn, 
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;

// Data Connector Data Sets
shared UptimeRobot.AccountDetails = () =>
    let
        json = getPage("getAccountDetails",""),
        output = json[account],
        #"AccountDetails" = Record.ToTable(output)
    in
        #"AccountDetails";

shared UptimeRobot.AlertContacts = () =>
    let
        json = getPages("getAlertContacts",""),
	    output = json[alert_contacts],
        #"Contacts" = Table.FromList(output, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"ContactsList" = Table.ExpandListColumn(#"Contacts", "Column1"),
        #"ExpandedContacts" = Table.ExpandRecordColumn(#"ContactsList", "Column1", Record.FieldNames(Table.Column(#"ContactsList", "Column1"){0}))
    in
        #"ExpandedContacts";

shared UptimeRobot.MaintenanceWindows = () =>
    let
        json = getPages("getMWindows",""),
	    output = json[mwindows],
        #"Windows" = Table.FromList(output, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"WindowsList" = Table.ExpandListColumn(#"Windows", "Column1"),
        #"ExpandedWindows" = Table.ExpandRecordColumn(#"WindowsList", "Column1", Record.FieldNames(Table.Column(#"WindowsList", "Column1"){0}))
    in
        #"ExpandedWindows";

shared UptimeRobot.Monitors = () =>
    let
        json = getPages("getMonitors","custom_uptime_ratios=30"),
	    output = json[monitors],
        #"Monitors" = Table.FromList(output, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"MonitorList" = Table.ExpandListColumn(#"Monitors", "Column1"),
        #"ExpandedMonitors" = Table.ExpandRecordColumn(#"MonitorList", "Column1", Record.FieldNames(Table.Column(#"MonitorList", "Column1"){0}))
    in
        #"ExpandedMonitors";

shared UptimeRobot.MonitorLogs = () =>
    let
        json = getPages("getMonitors","custom_uptime_ratios=30&logs=1"),
	    output = json[monitors],
        #"Monitors" = Table.FromList(output, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"MonitorList" = Table.ExpandListColumn(#"Monitors", "Column1"),
        #"ExpandedMonitors" = Table.ExpandRecordColumn(#"MonitorList", "Column1", Record.FieldNames(Table.Column(#"MonitorList", "Column1"){0})),
        #"LogList" = Table.ExpandListColumn(#"ExpandedMonitors", "logs"),
        #"ExpandedLogs" = Table.ExpandRecordColumn(#"LogList", "logs", {"type", "datetime", "duration", "reason"}, {"logs.type", "logs.datetime", "logs.duration", "logs.reason"}),
        #"ExpandedReason" = Table.ExpandRecordColumn(#"ExpandedLogs", "logs.reason", {"code", "detail"}, {"logs.reason.code", "logs.reason.detail"})
    in
        #"ExpandedReason";

shared UptimeRobot.PublicStatusPages = () =>
    let
        json = getPages("getPSPs",""),
	    output = json[psps],
        #"StatusPages" = Table.FromList(output, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"StatusPagesList" = Table.ExpandListColumn(#"StatusPages", "Column1"),
        #"ExpandedStatusPages" = Table.ExpandRecordColumn(#"StatusPagesList", "Column1", Record.FieldNames(Table.Column(#"StatusPagesList", "Column1"){0}))
    in
        #"ExpandedStatusPages";

// Shared Functions
getPage = (call, vals) =>
    let
        url = RootUri & call,
        data = "api_key=" & Extension.CurrentCredential()[Key] & "&format=json&" & vals,
        body = Text.ToBinary(data),
        options = [Headers=DefaultRequestHeaders, Content=body],
        source = Web.Contents(url, options),
        json = Json.Document(source)
    in
        json;

getPages = (call, vals) =>
    let
        firstPage = getPage(call,"limit=1"),
        totalNumber = try firstPage[pagination][total] otherwise firstPage[total],
        apiCalls = Number.RoundUp(totalNumber / 50),
        pages = List.Select(List.Generate(
                        ()=>[i=-1], 
                            each [i] < apiCalls,
                                each [i=[i]+1,data="offset=" & Number.ToText(Value.Multiply(i,50)) & "&" & vals],
                                    each try getPage(call,[data]) otherwise null
            ), each _ <> null),
        #"ResultsTableRaw" = Table.FromList(pages, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"ResultsTableExpanded" = try Table.ExpandRecordColumn(#"ResultsTableRaw", "Column1", Record.FieldNames(Table.Column(#"ResultsTableRaw", "Column1"){0})) otherwise #"ResultsTableRaw",
        #"ResultsTableRemoveStat" = try Table.RemoveColumns(#"ResultsTableExpanded",{"stat"},MissingField.Ignore) otherwise #"ResultsTableExpanded",
        #"ResultsTableRemovePag" = try Table.RemoveColumns(#"ResultsTableRemoveStat",{"pagination"},MissingField.Ignore) otherwise #"ResultsTableRemoveStat"
    in
        #"ResultsTableRemovePag";


// Data Source Kind description
UptimeRobot = [
    Authentication = [
        Key = [ Label = "UptimeRobot API", KeyLabel = "UptimeRobot API Key" ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
UptimeRobot.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = UptimeRobot.Icons,
    SourceTypeImage = UptimeRobot.Icons
];

UptimeRobot.Icons = [
    Icon16 = { Extension.Contents("UptimeRobot16.png"), Extension.Contents("UptimeRobot20.png"), Extension.Contents("UptimeRobot24.png"), Extension.Contents("UptimeRobot32.png") },
    Icon32 = { Extension.Contents("UptimeRobot32.png"), Extension.Contents("UptimeRobot40.png"), Extension.Contents("UptimeRobot48.png"), Extension.Contents("UptimeRobot64.png") }
];
