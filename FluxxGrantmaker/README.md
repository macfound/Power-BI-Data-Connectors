# Fluxx Grantmaker Directions #

This directory includes the source code and the compiled .mez file for use with Power BI.

Based on Fluxx API documentation located [Here](https://fluxxlabs.app.box.com/s/ea7iyp7ai8ksf1rbgu68vxfu95itc00x).

## Source Code ##

To view the source code, navigate to the [FluxxSolution](https://github.com/macfound/Power-BI-Data-Connectors/tree/main/FluxxGrantmaker/FluxxSolution) folder.
The sln file can be opened in Visual Studio, edited, and re-compiled.

## Compiled Data Connector ##

To use the Fluxx data connector as is, follow these steps:
1. Download the [Fluxx.mez](https://github.com/macfound/Power-BI-Data-Connectors/blob/main/FluxxGrantmaker/Fluxx.mez) file
2. Copy the file to the Custom Connectors folder for Power BI (e.g. "C:\Users\UserName\Documents\Power BI Desktop\Custom Connectors")
3. Open Power BI.
4. Navigate to File -> Options & Settings
5. Select Options
6. Choose "Security" under the Global grouping
7. Under "Data Extensions" be sure that "(Not Recommended) Allow any extension to load without validation or warning"

After completing these steps, you should now be able to find the data connector in the list of connectors when using "Get Data"
1. Select "Get Data"
2. Seach for Fluxx or navigate to "Online Services" and choose "Fluxx (Beta)"
![GetData](https://user-images.githubusercontent.com/9000285/129103075-df709908-561a-4d33-8440-d9a06f1754d3.PNG)

3. Enter the API Key and Secret when prompted
![EnterCredentials](https://user-images.githubusercontent.com/9000285/129103138-34fbcc6d-2890-49af-9891-1573e78fbadc.PNG)

4. Enter the url of your tenant (e.g. testing.fluxx.io)
![EnterDomain](https://user-images.githubusercontent.com/9000285/129103196-387c7ace-2ad6-43c7-adc5-45047fa3683f.PNG)

5. The Navigator will provide you with a list of all core tables of data that can be downloaded.
![ShowTables](https://user-images.githubusercontent.com/9000285/129103216-6ef864f7-2cd8-407c-9407-4de1a715a42b.PNG)

## Defining Columns and Filters ##

By default, the connector pulls all columns back and applies no filters. The data connector has the ability to take parameters and apply column selections and filters. The following sections will show how to put together the parameters for each of these input fields.

### Table Column List ###

This custom data connector derives the list of columns to be shown for a model based on the first record returned from the API. For some models, this is perfectly fine. However, models like grant_request may have some fields left intentionally blank for some records. If you retrieve a set of grant_request records, any columns on the first record returned missing values will exclude the column from derived table. Don't worry! You can explicitly define columns you want returned if Power BI is not implicitly doing a good job.

Parameters for this custom data connector need to use M Query syntax. We will create a record with the models for which we want to define columns and assign those models the list of columns to be retrieved. You can define the columns to be returned for one or more models.

The structure for this parameter is as follows: [model_name="{""col1"",""col2""}"]

Please note that the column names actually have two quotation marks. This is because they are surronded by curly brackes with one quotation mark. It is key to make sure the correct number of quotation marks are used.

Within the brackets, you can add additonal models by simply using a comma. The examples below will show how to select columns for a single model and how to select columns for multiple models.

**EXAMPLE 1**

If we only wanted the ID, Name, annd Country Code for organizations, the parameter would look like this:
```
[organization="{""id"",""name"",""country_code""}"]
```

**EXAMPLE 2**

We want the same columns for organizations, but we also only want the ID and grant_agreement_att fields for the grant_request model. The parameter would look like this:
```
[organization="{""id"",""name"",""country_code""}",grant_request="{""id"",""grant_agreement_at""}"]
```

### API Parameter List ###

As mentioned previously, the data connector retrieves all records by default. Similar to columns, parameters can be passed for one or more models. The syntax is largely the same. As such, the examples below will show how to pass API parameters for a single model and multiple models.

**EXAMPLE 1**

In this example, we want to just get a list of organizations within Australia.
```
[organization="filter={""group_type"":""and"",""conditions"":[[""country_code"",""eq"",""AU""]]}"]
```

**EXAMPLE 2**

We want the same organizaitons from Australia, but we also want any grant_request records with a grant_agreement_date wihin the past two quarters.
```
[organization="filter={""group_type"":""and"",""conditions"":[[""country_code"",""eq"",""AU""]]}",grant_request="filter={""group_type"":""and"",""conditions"":[[""grant_agreement_date"",""last-n-quarters"",""2""]]}"]
```
