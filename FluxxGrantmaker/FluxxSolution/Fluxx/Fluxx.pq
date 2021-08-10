// This file contains your Data Connector logic
section Fluxx;

// Based on Fluxx API Documentation Located Here: https://fluxxlabs.app.box.com/s/ea7iyp7ai8ksf1rbgu68vxfu95itc00x
// GLOBAL VARIABLES
_recsperpage="500";

[DataSource.Kind="Fluxx", Publish="Fluxx.Publish"]
shared Fluxx.Contents = Value.ReplaceType(
    FluxxNavTable,
    type function(
        url as (type text meta [
            Documentation.FieldCaption = "Fluxx Grantmaker Root URI",
            Documentation.FieldDescription = "Enter the root URI of your organization.",
            Documentation.SampleValues = {"myorg.fluxx.io"}
        ]),
        optional columns as (type text meta [
            Documentation.FieldCaption = "Table Column List",
            Documentation.FieldDescription = "Enter the list of columns per model as an array.",
            Documentation.SampleValues = {"[alert={""id"",""name"",""created_at""},loi={""id"",""created_at""}]"}
        ]),
        optional parameters as (type text meta [
            Documentation.FieldCaption = "API Parameter List",
            Documentation.FieldDescription = "Enter the parameters per model as an array.",
            Documentation.SampleValues = {"[alert_email=""filter={""group_type"":""or"",""conditions"":[[""created_by_id"",""eq"",],[""updated_by_id"",""eq"",]]}"""}
        ])
    ) as any
);

// Navigation Table Creation
shared FluxxNavTable = (url as text, optional columns as text, optional filters as text) as table =>
    let
        source = #table({"Name", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
            { "Adhoc Reports", getPages(url, "adhoc_report",columns,filters), "Table", "adhoc_report", true },
            { "Affiliates", getPages(url, "affiliate",columns,filters), "Table", "affiliate", true },
            { "Affiliate Types", getPages(url, "affiliate_type",columns,filters), "Table", "affiliate_type", true },
            { "Aha Requirements Tickets", getPages(url, "aha_requirements_tickets",columns,filters), "Table", "aha_requirements_tickets", true },
            { "Alerts", getPages(url, "alert",columns,filters), "Table", "alert", true },
            { "Alert Emails", getPages(url, "alert_email",columns,filters), "Table", "alert_email", true },
            { "Alert Email Users", getPages(url, "alert_email_user",columns,filters), "Table", "alert_email_user", true },
            { "Alert Model Log", getPages(url, "alert_model_log",columns,filters), "Table", "alert_model_log", true },
            { "Alert Recipients", getPages(url, "alert_recipient",columns,filters), "Table", "alert_recipient", true },
            { "Alert Transition State", getPages(url, "alert_transition_state",columns,filters), "Table", "alert_transition_state", true },
            { "Audit Impersonator Users", getPages(url, "audit_impersonator_user",columns,filters), "Table", "audit_impersonator_user", true },
            { "Bank Accounts", getPages(url, "bank_account",columns,filters), "Table", "bank_account", true },
            { "Budget Requests", getPages(url, "budget_request",columns,filters), "Table", "budget_request", true },
            { "Card Configurations", getPages(url, "card_configuration",columns,filters), "Table", "card_configuration", true },
            { "Census Code Results", getPages(url, "census_code_result",columns,filters), "Table", "census_code_result", true },
            { "Census Configs", getPages(url, "census_config",columns,filters), "Table", "census_config", true },
            { "Clean Calculations", getPages(url, "clean_calculation",columns,filters), "Table", "clean_calculation", true },
            { "Client Configurations", getPages(url, "client_configuration",columns,filters), "Table", "client_configuration", true },
            { "Client Stores", getPages(url, "client_store",columns,filters), "Table", "client_store", true },
            { "Client Store Dashboard Groups", getPages(url, "client_store_dashboard_group",columns,filters), "Table", "client_store_dashboard_group", true },
            { "Clone Ancestry", getPages(url, "clone_ancestry",columns,filters), "Table", "clone_ancestry", true },
            { "COIs", getPages(url, "coi",columns,filters), "Table", "coi", true },
            { "Commit Tickets", getPages(url, "commit_ticket",columns,filters), "Table", "commit_ticket", true },
            { "Compliance Checklist Items", getPages(url, "compliance_checklist_item",columns,filters), "Table", "compliance_checklist_item", true },
            { "Concept Initiatives", getPages(url, "concept_initiative",columns,filters), "Table", "concept_initiative", true },
            { "Config Model Document", getPages(url, "config_model_document",columns,filters), "Table", "config_model_document", true },
            { "CPIs", getPages(url, "cpi",columns,filters), "Table", "cpi", true },
            { "Dashboard Groups", getPages(url, "dashboard_group",columns,filters), "Table", "dashboard_group", true },
            { "Dashboard Templates", getPages(url, "dashboard_template",columns,filters), "Table", "dashboard_template", true },
            { "Dashboard Themes", getPages(url, "dashboard_theme",columns,filters), "Table", "dashboard_theme", true },
            { "Documents", getPages(url, "document",columns,filters), "Table", "document", true },
            { "Docusign Tokens", getPages(url, "docusign_token",columns,filters), "Table", "docusign_token", true },
            { "Email Users", getPages(url, "email_user",columns,filters), "Table", "email_user", true },
            { "ETL Relationships", getPages(url, "etl_relationship",columns,filters), "Table", "etl_relationship", true },
            { "ETL Request Budgets", getPages(url, "etl_request_budget",columns,filters), "Table", "etl_request_budget", true },
            { "ETL Request Transaction Budgets", getPages(url, "etl_request_transaction_budget",columns,filters), "Table", "etl_request_transaction_budget", true },
            { "Exempt Organizations", getPages(url, "exempt_organization",columns,filters), "Table", "exempt_organization", true },
            { "Expirable Tokens", getPages(url, "expirable_token",columns,filters), "Table", "expirable_token", true },
            { "Extract Formats", getPages(url, "extract_format",columns,filters), "Table", "extract_format", true },
            { "Favorites", getPages(url, "favorite",columns,filters), "Table", "favorite", true },
            { "Field Lists", getPages(url, "field_list",columns,filters), "Table", "field_list", true },
            { "Filters", getPages(url, "filter",columns,filters), "Table", "filter", true },
            { "Forms", getPages(url, "form",columns,filters), "Table", "form", true },
            { "Form Elements", getPages(url, "form_element",columns,filters), "Table", "form_element", true },
            { "Funds", getPages(url, "fund",columns,filters), "Table", "fund", true },
            { "Fund Dockets", getPages(url, "fund_docket",columns,filters), "Table", "fund_docket", true },
            { "Fund Line Items", getPages(url, "fund_line_item",columns,filters), "Table", "fund_line_item", true },
            { "Funding Sources", getPages(url, "funding_source",columns,filters), "Table", "funding_source", true },
            { "Funding Source Allocations", getPages(url, "funding_source_allocation",columns,filters), "Table", "funding_source_allocation", true },
            { "Funding Source Allocation Authorities", getPages(url, "funding_source_allocation_authority",columns,filters), "Table", "funding_source_allocation_authority", true },
            { "Funding Source Forecasts", getPages(url, "funding_source_forecast",columns,filters), "Table", "funding_source_forecast", true },
            { "Fx Conversions", getPages(url, "fx_conversion",columns,filters), "Table", "fx_conversion", true },
            { "Fx Types", getPages(url, "fx_type",columns,filters), "Table", "fx_type", true },
            { "Generic Templates", getPages(url, "generic_template",columns,filters), "Table", "generic_template", true },
            { "Geo Cities", getPages(url, "geo_city",columns,filters), "Table", "geo_city", true },
            { "Geo Countries", getPages(url, "geo_country",columns,filters), "Table", "geo_country", true },
            { "Geo Counties", getPages(url, "geo_county",columns,filters), "Table", "geo_county", true },
            { "Geo Places", getPages(url, "geo_place",columns,filters), "Table", "geo_place", true },
            { "Geo Place Relationships", getPages(url, "geo_place_relationship",columns,filters), "Table", "geo_place_relationship", true },
            { "Geo Regions", getPages(url, "geo_region",columns,filters), "Table", "geo_region", true },
            { "Geo States", getPages(url, "geo_state",columns,filters), "Table", "geo_state", true },
            { "Github Commits", getPages(url, "github_commit",columns,filters), "Table", "github_commit", true },
            { "Grant Requests", getPages(url, "grant_request",columns,filters), "Table", "grant_request", true },
            { "Grantee Budgets", getPages(url, "grantee_budget",columns,filters), "Table", "grantee_budget", true },
            { "Grantee Whitelists", getPages(url, "grantee_whitelist",columns,filters), "Table", "grantee_whitelist", true },
            { "Groups", getPages(url, "group",columns,filters), "Table", "group", true },
            { "Group Members", getPages(url, "group_member",columns,filters), "Table", "group_member", true },
            { "GS Streams", getPages(url, "gs_stream",columns,filters), "Table", "gs_stream", true },
            { "GS Stream Documents", getPages(url, "gs_stream_document",columns,filters), "Table", "gs_stream_document", true },
            { "GS Stream GS Tags", getPages(url, "gs_stream_gs_tag",columns,filters), "Table", "gs_stream_gs_tag", true },
            { "GS Stream Requests", getPages(url, "gs_stream_request",columns,filters), "Table", "gs_stream_request", true },
            { "GS Tags", getPages(url, "gs_tag",columns,filters), "Table", "gs_tag", true },
            { "Indicators", getPages(url, "indicator",columns,filters), "Table", "indicator", true },
            { "Initiatives", getPages(url, "initiative",columns,filters), "Table", "initiative", true },
            { "Integration Filters", getPages(url, "integration_filter",columns,filters), "Table", "integration_filter", true },
            { "Integration Logs", getPages(url, "integration_log",columns,filters), "Table", "integration_log", true },
            { "Jobs", getPages(url, "job",columns,filters), "Table", "job", true },
            { "Languages", getPages(url, "language",columns,filters), "Table", "language", true },
            { "Login Attempts", getPages(url, "login_attempt",columns,filters), "Table", "login_attempt", true },
            { "LOIs", getPages(url, "loi",columns,filters), "Table", "loi", true },
            { "Machine Categories", getPages(url, "machine_category",columns,filters), "Table", "machine_category", true },
            { "Machine Events", getPages(url, "machine_event",columns,filters), "Table", "machine_event", true },
            { "Machine Events From State", getPages(url, "machine_event_from_state",columns,filters), "Table", "machine_event_from_state", true },
            { "Machine Event Roles", getPages(url, "machine_event_role",columns,filters), "Table", "machine_event_role", true },
            { "Machine Model Types", getPages(url, "machine_model_type",columns,filters), "Table", "machine_model_type", true },
            { "Machine States", getPages(url, "machine_state",columns,filters), "Table", "machine_state", true },
            { "Machine State Categories", getPages(url, "machine_state_category",columns,filters), "Table", "machine_state_category", true },
            { "Machine State Groups", getPages(url, "machine_state_group",columns,filters), "Table", "machine_state_group", true },
            { "Machine Workflows", getPages(url, "machine_workflow",columns,filters), "Table", "machine_workflow", true },
            { "Machine Workflow Forks", getPages(url, "machine_workflow_fork",columns,filters), "Table", "machine_workflow_fork", true },
            { "Matching Gift Profiles", getPages(url, "matching_gift_profile",columns,filters), "Table", "matching_gift_profile", true },
            { "MEL Results", getPages(url, "mel_result",columns,filters), "Table", "mel_result", true },
            { "MEL Updates", getPages(url, "mel_update",columns,filters), "Table", "mel_update", true },
            { "Mentions", getPages(url, "mention",columns,filters), "Table", "mention", true },
            { "Migrate Rows", getPages(url, "migrate_row",columns,filters), "Table", "migrate_row", true },
            { "Migrations", getPages(url, "migration",columns,filters), "Table", "migration", true },
            { "Migration Configs", getPages(url, "migration_config",columns,filters), "Table", "migration_config", true },
            { "Migration Config Columns", getPages(url, "migration_config_column",columns,filters), "Table", "migration_config_column", true },
            { "Migration Config Models", getPages(url, "migration_config_model",columns,filters), "Table", "migration_config_model", true },
            { "Migration Config Model Links", getPages(url, "migration_config_model_link",columns,filters), "Table", "migration_config_model_link", true },
            { "Migration Files", getPages(url, "migration_file",columns,filters), "Table", "migration_file", true },
            { "Model Attributes", getPages(url, "model_attribute",columns,filters), "Table", "model_attribute", true },
            { "Model Attribute Choices", getPages(url, "model_attribute_choice",columns,filters), "Table", "model_attribute_choice", true },
            { "Model Attribute Values", getPages(url, "model_attribute_value",columns,filters), "Table", "model_attribute_value", true },
            { "Model Clone Configurations", getPages(url, "model_clone_configuration",columns,filters), "Table", "model_clone_configuration", true },
            { "Model Documents", getPages(url, "model_document",columns,filters), "Table", "model_document", true },
            { "Model Document Dynamic Recipients", getPages(url, "model_document_dynamic_recipient",columns,filters), "Table", "model_document_dynamic_recipient", true },
            { "Model Document Masters", getPages(url, "model_document_master",columns,filters), "Table", "model_document_master", true },
            { "Model Document Signs", getPages(url, "model_document_sign",columns,filters), "Table", "model_document_sign", true },
            { "Model Document Sign Envelopes", getPages(url, "model_document_sign_envelope",columns,filters), "Table", "model_document_sign_envelope", true },
            { "Model Document Sub Types", getPages(url, "model_document_sub_type",columns,filters), "Table", "model_document_sub_type", true },
            { "Model Document Templates", getPages(url, "model_document_template",columns,filters), "Table", "model_document_template", true },
            { "Model Document Types", getPages(url, "model_document_type",columns,filters), "Table", "model_document_type", true },
            { "Model Emails", getPages(url, "model_email",columns,filters), "Table", "model_email", true },
            { "Model Methods", getPages(url, "model_method",columns,filters), "Table", "model_method", true },
            { "Model Themes", getPages(url, "model_theme",columns,filters), "Table", "model_theme", true },
            { "Model Validations", getPages(url, "model_validation",columns,filters), "Table", "model_validation", true },
            { "Model Validation Fields", getPages(url, "model_validation_field",columns,filters), "Table", "model_validation_field", true },
            { "Multi Element Choices", getPages(url, "multi_element_choice",columns,filters), "Table", "multi_element_choice", true },
            { "Multi Element Groups", getPages(url, "multi_element_group",columns,filters), "Table", "multi_element_group", true },
            { "Multi Element Values", getPages(url, "multi_element_value",columns,filters), "Table", "multi_element_value", true },
            { "Notes", getPages(url, "note",columns,filters), "Table", "note", true },
            { "OFAC Persons", getPages(url, "ofac_person",columns,filters), "Table", "ofac_person", true },
            { "Organizations", getPages(url, "organization",columns,filters), "Table", "organization", true },
            { "Organization Connection Requests", getPages(url, "organization_connection_request",columns,filters), "Table", "organization_connection_request", true },
            { "Outcomes", getPages(url, "outcome",columns,filters), "Table", "outcome", true },
            { "Periodic Syncs", getPages(url, "periodic_sync",columns,filters), "Table", "periodic_sync", true },
            { "Permission Delegators", getPages(url, "permission_delegator",columns,filters), "Table", "permission_delegator", true },
            { "Personas", getPages(url, "persona",columns,filters), "Table", "persona", true },
            { "Population Estimates", getPages(url, "population_estimate",columns,filters), "Table", "population_estimate", true },
            { "Population Estimate Years", getPages(url, "population_estimate_year",columns,filters), "Table", "population_estimate_year", true },
            { "Posts", getPages(url, "post",columns,filters), "Table", "post", true },
            { "Post Relationships", getPages(url, "post_relationship",columns,filters), "Table", "post_relationship", true },
            { "Post Views", getPages(url, "post_view",columns,filters), "Table", "post_view", true },
            { "Primary Contact Tenures", getPages(url, "primary_contact_tenure",columns,filters), "Table", "primary_contact_tenure", true },
            { "Programs", getPages(url, "program",columns,filters), "Table", "program", true },
            { "Program Budgets", getPages(url, "program_budget",columns,filters), "Table", "program_budget", true },
            { "Projects", getPages(url, "project",columns,filters), "Table", "project", true },
            { "Project Lists", getPages(url, "project_list",columns,filters), "Table", "project_list", true },
            { "Project List Items", getPages(url, "project_list_item",columns,filters), "Table", "project_list_item", true },
            { "Project Organizations", getPages(url, "project_organization",columns,filters), "Table", "project_organization", true },
            { "Project Requests", getPages(url, "project_request",columns,filters), "Table", "project_request", true },
            { "Project Users", getPages(url, "project_user",columns,filters), "Table", "project_user", true },
            { "Real Me Invitations", getPages(url, "real_me_invitation",columns,filters), "Table", "real_me_invitation", true },
            { "Realtime Updates", getPages(url, "realtime_update",columns,filters), "Table", "realtime_update", true },
            { "Recommendation Emails", getPages(url, "recommendation_email",columns,filters), "Table", "recommendation_email", true },
            { "Reduce Indexing Records", getPages(url, "reduce_indexing_record",columns,filters), "Table", "reduce_indexing_record", true },
            { "Relationships", getPages(url, "relationship",columns,filters), "Table", "relationship", true },
            { "Relationship Schema Mappings", getPages(url, "relationship_schema_mapping",columns,filters), "Table", "relationship_schema_mapping", true },
            { "Request Amendments", getPages(url, "request_amendment",columns,filters), "Table", "request_amendment", true },
            { "Request Amendment Model Themes", getPages(url, "request_amendment_model_themes",columns,filters), "Table", "request_amendment_model_themes", true },
            { "Request Evaluation Metrics", getPages(url, "request_evaluation_metric",columns,filters), "Table", "request_evaluation_metric", true },
            { "Request Funding Sources", getPages(url, "request_funding_source",columns,filters), "Table", "request_funding_source", true },
            { "Request Geo States", getPages(url, "request_geo_state",columns,filters), "Table", "request_geo_state", true },
            { "Request Organizations", getPages(url, "request_organization",columns,filters), "Table", "request_organization", true },
            { "Request Outcomes", getPages(url, "request_outcome",columns,filters), "Table", "request_outcome", true },
            { "Request Programs", getPages(url, "request_program",columns,filters), "Table", "request_program", true },
            { "Request Recommendations", getPages(url, "request_recommendation",columns,filters), "Table", "request_recommendation", true },
            { "Request Recommenders", getPages(url, "request_recommender",columns,filters), "Table", "request_recommender", true },
            { "Request Regrants", getPages(url, "request_regrant",columns,filters), "Table", "request_regrant", true },
            { "Request Reports", getPages(url, "request_report",columns,filters), "Table", "request_report", true },
            { "Request Reviews", getPages(url, "request_review",columns,filters), "Table", "request_review", true },
            { "Request Review Sets", getPages(url, "request_review_set",columns,filters), "Table", "request_review_set", true },
            { "Request Reviewer Assignments", getPages(url, "request_reviewer_assignment",columns,filters), "Table", "request_reviewer_assignment", true },
            { "Request Transactions", getPages(url, "request_transaction",columns,filters), "Table", "request_transaction", true },
            { "Request Transaction Funding Sources", getPages(url, "request_transaction_funding_source",columns,filters), "Table", "request_transaction_funding_source", true },
            { "Request Users", getPages(url, "request_user",columns,filters), "Table", "request_user", true },
            { "Roles", getPages(url, "role",columns,filters), "Table", "role", true },
            { "Role Users", getPages(url, "role_user",columns,filters), "Table", "role_user", true },
            { "Salesforce Authentications", getPages(url, "salesforce_authentication",columns,filters), "Table", "salesforce_authentication", true },
            { "Sections", getPages(url, "section",columns,filters), "Table", "section", true },
            { "Segments", getPages(url, "segment",columns,filters), "Table", "segment", true },
            { "Segment Tags", getPages(url, "segment_tag",columns,filters), "Table", "segment_tag", true },
            { "Shared Cards", getPages(url, "shared_card",columns,filters), "Table", "shared_card", true },
            { "SMS Logs", getPages(url, "sms_log",columns,filters), "Table", "sms_log", true },
            { "Spending Forecasts", getPages(url, "spending_forecast",columns,filters), "Table", "spending_forecast", true },
            { "Sphinx Checks", getPages(url, "sphinx_check",columns,filters), "Table", "sphinx_check", true },
            { "Stencils", getPages(url, "stencil",columns,filters), "Table", "stencil", true },
            { "Stencil Books", getPages(url, "stencil_book",columns,filters), "Table", "stencil_book", true },
            { "Stencil Book Pages", getPages(url, "stencil_book_page",columns,filters), "Table", "stencil_book_page", true },
            { "Stencil Forms", getPages(url, "stencil_form",columns,filters), "Table", "stencil_form", true },
            { "Sub Initiatives", getPages(url, "sub_initiative",columns,filters), "Table", "sub_initiative", true },
            { "Sub Models", getPages(url, "sub_model",columns,filters), "Table", "sub_model", true },
            { "Sub Programs", getPages(url, "sub_program",columns,filters), "Table", "sub_program", true },
            { "Table Views", getPages(url, "table_view",columns,filters), "Table", "table_view", true },
            { "Table View Favorites", getPages(url, "table_view_favorite",columns,filters), "Table", "table_view_favorite", true },
            { "Tags", getPages(url, "tag",columns,filters), "Table", "tag", true },
            { "Tagging", getPages(url, "tagging",columns,filters), "Table", "tagging", true },
            { "Transaction Report Dependencies", getPages(url, "transaction_report_dependency",columns,filters), "Table", "transaction_report_dependency", true },
            { "Translator Assignments", getPages(url, "translator_assignment",columns,filters), "Table", "translator_assignment", true },
            { "Translator Languages", getPages(url, "translator_language",columns,filters), "Table", "translator_language", true },
            { "UI Versions", getPages(url, "ui_version",columns,filters), "Table", "ui_version", true },
            { "Users", getPages(url, "user",columns,filters), "Table", "user", true },
            { "User Emails", getPages(url, "user_email",columns,filters), "Table", "user_email", true },
            { "User Organizations", getPages(url, "user_organization",columns,filters), "Table", "user_organization", true },
            { "User Permissions", getPages(url, "user_permission",columns,filters), "Table", "user_permission", true },
            { "User Profiles", getPages(url, "user_profile",columns,filters), "Table", "user_profile", true },
            { "User Profile Rules", getPages(url, "user_profile_rule",columns,filters), "Table", "user_profile_rule", true },
            { "User Segment Tags", getPages(url, "user_segment_tag",columns,filters), "Table", "user_segment_tag", true },
            { "Wiki Documents", getPages(url, "wiki_document",columns,filters), "Table", "wiki_document", true },
            { "Wiki Document Templates", getPages(url, "wiki_document_template",columns,filters), "Table", "wiki_document_template", true },
            { "Work Tasks", getPages(url, "work_task",columns,filters), "Table", "work_task", true },
            { "Workflow Events", getPages(url, "workflow_event",columns,filters), "Table", "workflow_event", true }
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
RetrieveAuthenticationToken = (url as text) =>
    let
        tokenresponse = GenerateAuthenticationToken(url),
        token = tokenresponse[access_token]
    in
        token;

GenerateAuthenticationToken = (url as text) =>
    let
        clientID = Record.Field(Extension.CurrentCredential(), "Username"),
        clientSecret = Record.Field(Extension.CurrentCredential(), "Password"),
        credentials = Text.Combine({"grant_type=client_credentials&client_id=", clientID , "&client_secret=" , clientSecret}),
        credentialPost = Json.Document(Web.Contents("https://" & url & "/oauth/token",[Content=Text.ToBinary(credentials)])),
        DefaultRequestHeaders =  [Headers =[#"Authorization"=Text.Combine({"Bearer " , credentialPost[access_token]})]],
        CreadentialExpiration = "",
        value = credentialPost
    in
        value;

getPage = (url, model, page, optional token, optional filters) =>
    let
        _token = if (token <> null) then token else RetrieveAuthenticationToken(url),
        _bearer = "Bearer " & _token,
        filter = if (filters <> null) then filters else "",
        headers = [Headers =[#"Authorization"=_bearer]],
        call = "https://" & url & "/api/rest/v2/" & model & "?all_core=1&all_dynamic=1&page=" & page & "&per_page=" & _recsperpage & "&" & filter,
        source = Web.Contents(call, headers),
        json = Json.Document(source)
    in
        json;

getPages = (url, model, optional columns, optional filters) =>
    let
        auth = GenerateAuthenticationToken(url),
        token = auth[access_token],
        current = DateTime.LocalNow(),
        expires = current + #duration(0,0,0,auth[expires_in]),
        _columns = try Expression.Evaluate(columns) otherwise null,
        _filters = try Expression.Evaluate(filters) otherwise null,
        columnList = try Expression.Evaluate(evalParameters(model, _columns)) otherwise null,
        filterList = evalParameters(model, _filters),
        firstPage = getPage(url,model,"1",token,filterList),
        totalNumber = firstPage[total_entries],
        apiCalls = firstPage[total_pages],
        pages = List.Select(List.Generate(
                        ()=>[i=0],   
                            each [i] <= apiCalls,
                                each [  i=[i]+1,
                                        cpage=Number.ToText(i)
                                     ],
                                    each try Throttle(url,model,[cpage],token, 180, filterList)[records] otherwise null
            ), each _ <> null),
        #"ResultsTableRaw" = Table.FromList(pages, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"ResultsTableExpanded" = try Table.ExpandRecordColumn(#"ResultsTableRaw", "Column1", Record.FieldNames(Table.Column(#"ResultsTableRaw", "Column1"){0})) otherwise #"ResultsTableRaw",
        #"ExpandedTable" = try Table.ExpandListColumn(#"ResultsTableExpanded", model) otherwise #"ResultsTableExpanded",
        cols = if(columnList <> null) then columnList else Record.FieldNames(Table.Column(#"ExpandedTable", model){0}),
        #"ExpandedColumn" = try Table.ExpandRecordColumn(#"ExpandedTable", model, cols) otherwise #table({"No Records Found"},{})
    in
        #"ExpandedColumn";

evalParameters = (model, optional parameters) =>
    let
        input = try Table.SingleRow(Table.SelectRows(Record.ToTable(parameters), each [Name] = model))[Value] otherwise null
    in
        input;

Throttle = (url, model, page, token, limit as nullable number, optional filters) =>
    let
        WaitTime = if limit = null then null else Value.Divide(60, limit, 0),
        Result = if WaitTime = null then try getPage(url) otherwise null else 
        Value.WaitFor(
            (iteration) =>
                let
                    response = try getPage(url, model, page, token, filters) otherwise null
                in
                    response,
            (iteration) => #duration(0,0,0,WaitTime)
        )
    in
        Result;

Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
    let
        list = List.Generate(
            () => {0, null},
            (state) => state{0} <> null and (count = null or state{0} < count),
            (state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},
            (state) => state{1})
    in
        List.Last(list);

// Data Source Kind description
Fluxx = [
    Authentication = [
        UsernamePassword = [
            UsernameLabel="Enter your Fluxx Grantmaker API Client ID: ",
            PasswordLabel="Enter your Fluxx Grantmaker API Secret: "
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
Fluxx.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = Fluxx.Icons,
    SourceTypeImage = Fluxx.Icons
];

Fluxx.Icons = [
    Icon16 = { Extension.Contents("Fluxx16.png"), Extension.Contents("Fluxx20.png"), Extension.Contents("Fluxx24.png"), Extension.Contents("Fluxx32.png") },
    Icon32 = { Extension.Contents("Fluxx32.png"), Extension.Contents("Fluxx40.png"), Extension.Contents("Fluxx48.png"), Extension.Contents("Fluxx64.png") }
];
