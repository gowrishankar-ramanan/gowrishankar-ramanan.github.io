---
title: "Data Cleaning Project"
date: 2018-08-07
categories: portfolio
mathjax: true
---

# Project Objective

This is data cleaning project. I used OpenRefine, python to clean and refine 'US Farmers Market dataset'.



## **1. Dataset overview and Initial assessment**

### **1.1 Dataset**

US Farmers Market dataset is lists of markets that sell agricultural products directly to customers at a common, recurrent physical location. It is originally designed to provide customers information about farmers market such as market locations, directions, operating times, media sources, products sell, and more.

The dataset contains 8687 market information with 59 different attributes.

 

FMID: (integer) Identifier of each farmers market

MarketName: (string) Name of each market

Website: (string) Website address of each market

Facebook: (string) Facebook address of each market

Twitter: (string)Twitter address of each market

Youtube: (string) Youtube address of each market

OtherMedia: (string) Any other media address except those mentioned above

street: (string) Specific position that market is located in.

city: (string)city that market is located in

County: (string)County of the market

State: (string)State of the market

zip: (integer) zip code of the market

Season1Date: (date)

Season1Time: (time)

x: (numeric) longitude of the market

y: (numeric) latitude of market

Location: (string) description of the market location that the market is actually located in, such as private parking lot, specific buildings

Credit~WildHarvested: (binary) Whether some of products or payment methods are available

updateTime: (date) the date of information updated



### **1.2 Quality Issue**

Dataset contains lots of null data. Mostly, it lacks media attributes such as website, facebook and others. Although some location data like zip, street, city are missing, it can be replaced by using x, y data which are assumed to be longitude and latitude of the market. 

Too much season date and time are missing. Almost 95% of Season2 to Season4 date and time data are missing, which seem to be hard to find use case for those data. Also, information about what kind food are available in the market are missing largely.

Season date are not in the same format. They mostly follow DD/MM/YYYY format, but some are in Month DD, YYYY format.

Attribute county contains both lowercase and uppercase.

 

### **1.3 Use Case**

**1.3.1 Is data clean enough for use cases?**

Although there are some missing values, and inconsistent in format, most part of data are well organized. Without any processing data, it can be used for below cases:

- How much of each payments methods such as credit, WIC and others in overall market places are available.
- List of products available in each market.
- Analyzing the number of farmers markets in each city or states
- The number of farmers markets per 10,000 people in each city or states

 

**1.3.2 Hypothetical use case**

After going through some cleaning process, this dataset can be used for:

- A map that give exact locations of each Farmers market with some of information can be made, when some of the locations data should be reformatted or replaced with the use of latitude and longitude data. 
- In what period of time the farmers market season1 open most or least. To do so, season1 date should be reformatted in same format such as DD/MM/YYYY.
- Showing the number of farmers markets per 10,000 people in each county is available after, county data needs to be clustered into same values.

 

## **2. Data Cleaning with OpenRefine**

With OpenRefine, data will be clustered if they are in similar text, or reformatted to keep consistency of data. Firstly, all column data should be trimmed and collapsed if they have consecutive white spaces. Next, county, city, States names are inconsistent. Some of them are in uppercase while others are not. They need to be converted into same format by clustering function. Some of SeasonDate columns contain various formats which should be fixed with the use of regular expression.

 

 

### **2.1 MarketName**

\- Trim leading and trailing white space.

\- Collapse consecutive white spaces.

\- Use text facet and cluster by using key collision method and fingerprint keying function.

\- Use text facet and cluster again by using key collision method and ngram-fingerprint, except those have distinct different names such as Arkansas Home Grown Market II and Arkansas Home Grown Market III.

<p align='center'>
    <img src = 'img/clustering.jpg' width='80%'>
    <br/>
    <sub>Figure 1 Clustering "MarketName"</sub>
</p>



### **2.2 Website**

\- Trim leading and trailing white space.

 

### **2.3 Facebook**

\- Trim leading and trailing white space.

\- Collapse consecutive white spaces.

\- By using GREL, change ‘n/a’ or ‘none’ values to blank.

\- Reformat data that starts with ‘@data’ or ‘#data’ to https://facebook.com/data for better access and consistency by using python/jython.

<p align='center'>
    <img src = 'img/na_values.jpg' width='80%'>
    <br/>
    <sub>Figure 2 Cleaning 'NA' and 'none' values in "Facebook"</sub>
</p>



### **2.4 Twitter**

\- Trim leading and trailing white space.

\- Eliminate ‘N/A’ or ‘none’ string values by using clustering function.

\- Reformat data that starts with ‘@data’ or ‘#data’ to https://twitter.com/data for better access and consistency by using python/jython.

<p align='center'>
    <img src = 'img/reformat.jpg' width='80%'>
    <br/>
    <sub>Figure 3 Reformatting "Twitter"</sub>
</p>



### **2.5 Youtube**

\- Trim leading and trailing white space.

\- Eliminate ‘N/A’ or ‘none’ string values by using clustering function.

 

### **2.6 OtherMedia**

\- Trim leading and trailing white space.

\- Collapse consecutive white spaces.

 

 

### **2.7 street**

\- Trim leading and trailing white space.

\- Collapse consecutive white spaces.

 

### **2.8 city**

\- Trim leading and trailing white space.

\- Collapse consecutive white spaces.

\- Use text facet and cluster by using key collision method and fingerprint keying function.

\- Use text facet and cluster again by using key collision method and ngram-fingerprint, except those have distinct different names.

<p align='center'>
    <img src = 'img/cluster_city.jpg' width='80%'>
    <br/>
    <sub>Figure 4 Clustering "city"</sub>
</p>



### **2.9 zip**

\- Convert any string values to blank using GREL.

\- United States zip code follows NNNNN or NNNNN-NNNN format, check if the format is right with GREL.

<p align='center'>
    <img src = 'img/format_zip.jpg' width='80%'>
    <br/>
    <sub>Figure 5 Format Check in "zip"</sub>
</p>



### **2.10 Season1Date**

\- Trim leading and trailing white space.

\- Collapse consecutive white spaces.

\- For better use and clear view, split into two columns: one is start date “Season1StartDate”, and the another is end date “Season1EndDate”.

<p align='center'>
    <img src = 'img/split_season1date.jpg' width='80%'>
    <br/>
    <sub>Figure 6 Split "Season1Date" into two different columns</sub>
</p>



### **2.11 Season1StartDate**

\- Clean separator ‘to’ to blank

\- Change the date type to date, and its format becomes YYYY.MM.DD.

 

### **2.12 Season1EndDate**

\- Change the date type to date, and its format becomes YYYY.MM.DD.

 

### **2.13 Season2,3,4Date and Season2,3,4Time**

\- Considering that about 95% of these columns are blank, drop the columns for decreasing sparsity of data.

 

### **2.14 x**

\- Trim leading and trailing white space.

 

### **2.15 y**

\- Trim leading and trailing white space.

 

### **2.16 Organic**

\- Replace “-“ string to blank with use of GREL.

 

 

### **2.17 updatedTime**

\- Convert ‘Month DD YYYY time’ format to ‘MM/DD/YYYY time’ format for data consistency by using python/jython.

<p align='center'>
    <img src = 'img/format_updatetime.jpg' width='80%'>
    <br/>
    <sub>Figure 7 "updateTime" Format Change</sub>
</p>

The processed data is saved as ‘farmersmarkets-or.csv’.

 

## **3. Applying more suitable solutions(Python)**

Albeit OpenRefine is a great tool for cleaning data, there are some limitations. For Farmers Market data, the tool cannot help filling some of missing zip code. And by using ‘uszipcode‘ package in python along with latitude, and longitude variables (which are ‘x’, ’y’), zip code can be filled.(“fill_zipcode.ipynb” python file includes the script)

Based on closest match from given latitude, and longitude, when city name of searched zip code and city name of the data matches, the data zip code is assigned with matched zip code. In case there are no matches for city names, zip code is given according to the closest distance.

<p align='center'>
    <img src = 'img/sample_uszipcode.jpg' width='80%'>
    <br/>
    <sub>Figure 8 Sample of "uszipcode" package</sub>
</p>



Out of 961 missing zip code, 934 cases are filled. Remain 27 data is also missing x, y values, which makes it hard to find zip code. After that ‘farmersmarkets-py.csv’ file is created.



## **4. Develop Relational Database Schema**

First, the ER diagram is developed for uploading csv file to database.

### **4.1 Schema**

Below figure is the ER diagram of farmers market dataset. As it has only one table, it does not contain any foreign keys. “1_create_schema.sql” file creates schema and imports csv file to that table.

| farmersmarkets   |         |
| ---------------- | ------- |
| FMID             | INTEGER |
| MarketName       | TEXT    |
| Website          | TEXT    |
| Facebook         | TEXT    |
| Twitter          | TEXT    |
| Youtube          | TEXT    |
| OtherMedia       | TEXT    |
| street           | TEXT    |
| City             | TEXT    |
| County           | TEXT    |
| State            | TEXT    |
| zip              | INTEGER |
| Season1StartDate | NUMERIC |
| Season1EndDate   | NUMERIC |
| Season1Time      | NUMERIC |
| x                | REAL    |
| y                | REAL    |
| Location         | INTEGER |
| Credit           | INTEGER |
| WIC              | INTEGER |
| WICcash          | INTEGER |
| SFMNP            | INTEGER |
| SNAP             | INTEGER |
| Organic          | INTEGER |
| Bakedgoods       | INTEGER |
| Cheese           | INTEGER |
| Crafts           | INTEGER |
| Flowers          | INTEGER |
| Eggs             | INTEGER |
| Seafood          | INTEGER |
| Herbs            | INTEGER |
| Vegetables       | INTEGER |
| Honey            | INTEGER |
| Jams             | INTEGER |
| Maple            | INTEGER |
| Meat             | INTEGER |
| Nursery          | INTEGER |
| Nuts             | INTEGER |
| Plants           | INTEGER |
| Poultry          | INTEGER |
| Prepared         | INTEGER |
| Soap             | INTEGER |
| Trees            | INTEGER |
| Wine             | INTEGER |
| Coffee           | INTEGER |
| Beans            | INTEGER |
| Fruits           | INTEGER |
| Grains           | INTEGER |
| Juices           | INTEGER |
| Mushrooms        | INTEGER |
| PetFood          | INTEGER |
| Tofu             | INTEGER |
| WildHarvested    | INTEGER |
| updateTime       | INTEGER |
| Indexes          |         |
| PRIMARY          |         |
| FMID             |         |

 

### **4.2 Integrity Conatraints**

For integrity of data table, there are several things to be checked.

 

**4.2.1 FMID**

\- As FMID is primary key, there should not be the same FMID or empty FMID. “2_fmid_check.sql” file conducts corresponding integrity.

------

**SELECT** count(FMID) 

**FROM** market 

**WHERE** FMID is NULL;

0

**SELECT** **COUNT**(distinct FMID)-**COUNT**(FMID) **FROM** market;

0

------

\- First query checks null FMID, and second query counts the difference between distinct FMID values and the number of whole dataset, which is zero.

 <br/>

**4.2.2 Website, Facebook, Youtube, Twitter, OtherMedia**

\- Website, Facebook, Twitter Youtube data should not be same as OtherMedia or each other. “3_othermedia_check.sql” checks the number of same values compared to website, facebook, youtube, or twitter.

----------------------------------------------------------------------------------------------------------------------------------------

**SELECT** "Facebook == Othermida cases: ", count(Facebook) 

**FROM** market 

**WHERE** OtherMedia = Facebook **AND** Othermedia != "";

"Facebook == Othermida cases: ",4

------

\- As we can see from the above constraint check, there are several cases where OtherMedia column has same data as Facebook(Website, Youtube, Twitter were also checked).

\- Using sqlite, OtherMedia column data are set to blank for preventing redundancy. (“4_othermedia_clean.sql”)

<br/>

----------------------------------------------------------------------------------------------------------------------------------------

**UPDATE** market 

**SET** OtherMedia ="" 

**WHERE** FMID **IN** 

(**SELECT** FMID 

**FROM** market 

**WHERE** OtherMedia = Facebook **AND** Othermedia != "");

------

 

<b4/>

**4.2.3 zip**

\- By using python, missing zip values were filled based on its x, y values. Therefore, there should not be empty zip values if x and y data are present. Check whether there are empty zip data where x, y are present throughout “5_zip_check.sql” codes.

------

**SELECT** zip, x, y 

**FROM** market 

**WHERE** (x != "" **AND** y!="") 

**AND** zip ="";

------

As nothing shows, there are no data which violates this integrity constraint.

 <br/>

**4.2.4 Season1StartDate, Season1EndDate**

\- Season end date should not be earlier than season start date where date is not empty, and excludes cases like “April”, “May” and so on.(“6_seasondate_check.sql”)

------

**SELECT** FMID, Season1StartDate, Season1EndDate 

**FROM** market 

**WHERE** Season1StartDate> Season1EndDate 

**AND** Season1EndDate != ""

**AND** printf("%d", Season1StartDate)!= "0";

1011959,2016-10-01T00:00:00Z,2016-05-07T00:00:00Z

------

\- There is one case which obviously end date is earlier than start date. Switch Season1StartDate and Season1EndDate data for that row.(“7_seasondate_clean.sql”)

<br/>

------

**UPDATE** market 

**SET** Season1StartDate = Season1Enddate, Season1EndDate = Season1StartDate

**WHERE** FMID = 

(**SELECT** FMID 

**FROM** market 

**WHERE** Season1StartDate> Season1EndDate 

**AND** Season1EndDate != ""

**AND** printf("%d", Season1StartDate)!= "0");

------

\- After conducting above cleaning query, the start date and end date are switched properly for corresponding row.

<br/>

------

**SELECT** FMID, Season1StartDate, Season1EndDate 

**FROM** market 

**WHERE** FMID = 1011959;

1011959,2016-05-07T00:00:00Z,2016-10-01T00:00:00Z

------

\- The processed data is stored as “farmersmarkets-sql.csv” throughout queries on “8_export_csv.sql”.

 

## **5. Workflow Model**

YesWorkFlow is used to create workflow model of overall process and OpenRefine process.

 

### **5.1 Overall Workflow**

Overall workflow shows the whole process taken throughout openrefine, python, and sqlite.

<p align='center'>
    <img src = 'img/overall_workflow.jpg' width='80%'>
    <br/>
    <sub>Figure 9 Overall Workflow</sub>
</p>



### **5.2 OpenRefine Workflow**

Openrefine workflow covers each steps taken in ‘CleanWithOpenRefine’ from the overall workflow.

<p align='center'>
    <img src = 'img/openrefine_workflow.jpg' width='80%'>
    <br/>
    <sub>Figure 10 OpenRefine Workflow</sub>
</p>





 

## **6. Conclusion**

Although many parts of data have been cleaned and reformatted for better data consistency and integrity, there is a problem left unsolved due to the incomplete dataset. Date type data such as “updateTime”, and “Season1StartDate”, contain either “Month” or “DD/MM/YYYY” format. This is because data with “Month” format does not have year information. Due to this issue, the usability of whole dataset is quite constrained. 

Overall, data were cleaned appropriately for the hypothetical use cases. With zip code data filled, it could be used for comparison between the number of farmers markets in each city or states. Also, with reformatted season1 data, we can find out in what period of time farmers market open most or least.