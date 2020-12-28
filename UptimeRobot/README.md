**UptimeRobot Directions**

This directory includes the source code and the compiled .mez file for use with Power BI.

**Source Code**

To view the source code, navigate to the [UptimeRobotSolution](https://github.com/macfound/Power-BI-Data-Connectors/tree/main/UptimeRobot/UptimeRobotSolution folder.
The sln file can be opened in Visual Studio, edited, and re-compiled.

**Compiled Data Connector**

To use the UptimeRobot data connector as is, follow these steps:
1. Download the UptimeRobot.mez file
2. Copy the file to the Custom Connectors folder for Power BI (e.g. "C:\Users\UserName\Documents\Power BI Desktop\Custom Connectors")
3. Open Power BI.
4. Navigate to File -> Options & Settings
5. Select Options
6. Choose "Security" under the Global grouping
7. Under "Data Extensions" be sure that "(Not Recommended) Allow any extension to load without validation or warning"

After completing these steps, you should now be able to find the data connector in the list of connectors when using "Get Data"
1. Select "Get Data"
2. Seach for UptimeRobot or navigate to "Online Services" and choose "UptimeRobot (Beta)"
3. Enter the API Key when prompted
4. The Navigator will provide you with 6 tables of data that can be downloaded.
