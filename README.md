# Marketing Analytics for E-Commerce Growth
## Overview
This project involves a comprehensive marketing analytics study conducted for ShopEasy, an online retail business experiencing declining customer engagement and conversion rates despite increased marketing efforts. The objective was to analyze various data sources to identify key factors affecting performance and provide actionable recommendations to enhance their marketing strategies.  
## Project Objectives
The primary goals of this project are: 

**1) Increase Conversion Rates**: Identify factors contributing to low conversion rates and provide insights to optimize the conversion funnel.  

**2) Enhance Customer Engagement**: Determine which types of marketing content drive the highest engagement.  

**3) Improve Customer Feedback Scores**: Understand common themes in customer reviews to guide product and service improvements.  
## Technologies Used
**SQL:** For data extraction and manipulation from databases.  

**Python:** For data analysis and trend identification using libraries like Pandas, NumPy, Matplotlib, and NLTK for sentiment analysis.  

**Power BI:** For creating interactive data visualizations and dashboards.  

**Jupyter Notebooks:** For documenting the analysis process and code execution.  
## About Data loading and Data:
Download the .bak file from the folder [data](https://github.com/parimala5678/Marketing-Analytics-Project/tree/main/data). Now, add this backup file to the backup folder of the MS SQL Server Management Studio. Path will be something similar to this -> C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup.  

After adding the database to the MSSQL Server, you can see the multiple tables(as shown below) that are available. 
![image](https://github.com/user-attachments/assets/6bf6d2be-a6c3-4ed2-87e6-d7e7440ff405)  
## Data Tables Description
### **Customer Table**  

Provides demographic and contact information for each customer.  

**Columns:**  
```custid```: Unique identifier for each customer.  

```cust name```: Name of the customer.  

```email```: Contact email of the customer.  

```gender```: Gender of the customer.  

```age```: Age of the customer.  

```geography id```: References the customer’s geographic location.  

### **Customer Journey Table**

Contains data on customer interactions across different stages of their journey with the platform.  

**Columns:**  
```journeyid```: Unique identifier for each customer journey record.  

```customer id```: References the customer involved in the journey.  

```product id```: References the product associated with the interaction. 

```visit date```: Date of the customer’s visit or interaction.  

```stage```: Stage of the customer journey (e.g., awareness, consideration, decision).  

```action```: Specific action taken by the customer (e.g., viewed, clicked, purchased).  

```duration```: Duration of the interaction in seconds.  

### **Customer Reviews Table**  

Holds information on customer reviews for various products.  

**Columns:**  

```review id```: Unique identifier for each review.  

```customer id```: References the customer who provided the review.  

```product id```: References the reviewed product.  

```review date```: Date the review was submitted.  

```rating```: Customer rating for the product (e.g., on a scale of 1 to 5).  

```review text```: Textual feedback provided by the customer.  

### **Engagement Data Table**  

Contains records of customer engagement with various content types on the platform.  

**Columns:**

```engagement id```: Unique identifier for each engagement record.  

```content id```: Identifier for the specific content engaged with.  

```content type```: Type of content (e.g., blog, video, social media post).  

```likes```: Number of likes received for the content.  

```engagement date```: Date of the engagement.  

```campaign id```: References the marketing campaign associated with the content.  

```product id```: Product associated with the content.  

```viewsclickscombined```: Combined count of views and clicks on the content.  

### **Geography Table**

Maps geographic locations for customer demographics.  

**Columns:**  

```geography id```: Unique identifier for each geographic location.  

```country```: Country of the customer’s location.  

```city```: City of the customer’s location.  

### **Products Table**

Provides details on the products available on the platform.

**Columns:**  

```product id```: Unique identifier for each product.  

```product name```: Name of the product.  

```category```: Product category (e.g., electronics, apparel).  

```price```: Price of the product.  

## Methodology
### 1) Database Loading and Data Cleaning:

Loaded data into MySQL and performed cleaning to ensure consistency. Steps included handling missing values, removing duplicates with SQL window functions, standardizing dates and whitespace, and splitting viewsclickscombined into separate views and clicks columns.  

### 2) Sentiment Analysis:

Set up Python libraries and used **VADER** for sentiment analysis. Extracted customer reviews from SQL, calculated sentiment scores, and categorized them based on sentiment and rating. Created sentiment buckets for focused insights. Saved the processed data, including sentiment scores and categories, to a CSV file. 
This file will be used in **Power BI** to visualize customer sentiment trends and support actionable insights for ShopEasy’s marketing strategies.  

### 3) POWER BI:

**Data Loading and Transformation in Power BI:**  

After importing tables from SQL to Power BI, initial transformations were required. Using **Power Query**, I replicated the data cleaning and transformation steps originally performed in MSSQL, including handling missing values and formatting inconsistencies.  

**Data Model Setup:**  

Established relationships between fact and dimension tables using Power BI’s data model feature to enable accurate analysis. Created a new table in the model view called Calendar, using the following **DAX code** to generate a comprehensive date table:
``` Calendar = 
ADDCOLUMNS (
    CALENDAR ( DATE ( 2023, 1, 1 ), DATE ( 2025, 12, 31 ) ),
    "DateAsInteger", FORMAT ( [Date], "YYYYMMDD" ),
    "Year", YEAR ( [Date] ),
    "Monthnumber", FORMAT ( [Date], "MM" ),
    "YearMonthnumber", FORMAT ( [Date], "YYYY/MM" ),
    "YearMonthShort", FORMAT ( [Date], "YYYY/mmm" ),
    "MonthNameShort", FORMAT ( [Date], "mmm" ),
    "MonthNameLong", FORMAT ( [Date], "mmmm" ),
    "DayOfWeekNumber", WEEKDAY ( [Date] ),
    "DayOfWeek", FORMAT ( [Date], "dddd" ),
    "DayOfWeekShort", FORMAT ( [Date], "ddd" ),
    "Quarter", "Q" & FORMAT ( [Date], "Q" ),
    "YearQuarter", FORMAT ( [Date], "YYYY" ) & "/Q" & FORMAT ( [Date], "Q" )
)
```
**Creating DAX Measures for Visualization:**  

Leveraged DAX functions such as SUM, COUNT, VAR, and conditional IF statements to calculate key metrics, enhancing the analytical depth of the dashboard visuals.  

**Dashboard Visualization:**  

Built interactive visualizations based on DAX calculations, providing insights into customer engagement, conversion rates, and review sentiments.

## Key Findings
**Conversion Rate Trends**  

Significant fluctuations in conversion rates throughout the year, with a peak in January (18.5%) driven by seasonal demand.  

The lowest conversion rate occurred in May (4.3%), indicating a potential need for strategy adjustments during this period.  

High-performing products like Ski Boots showed remarkable conversion rates, suggesting opportunities to leverage these categories.  

**Customer Engagement Analysis**

Notable decline in social media views and engagement from August onwards.  

Clicks and likes were consistently low relative to views, though the click-through rate was 15.37%, indicating effective engagement from interested users.  

Blog content generated the most views, particularly in April and July.  

**Customer Feedback Insights**

Average customer rating was 3.7, stable but below the target of 4.0.  

Positive sentiments dominated customer reviews, but negative and mixed feedback highlighted areas needing improvement.  

Products with ratings below 3.5 require attention to enhance customer satisfaction.

## Recommendations  
**Increase Conversion Rates**  

Target High-Performing Products: Focus marketing efforts on products with high conversion rates (e.g., Ski Boots, Kayaks).  

Seasonal Promotions: Implement targeted campaigns during peak months to capitalize on seasonal demand.  

Optimize Underperforming Periods: Reevaluate marketing strategies for low-performing months like May.  

**Enhance Customer Engagement**

Revitalize Content Strategy: Introduce more engaging content formats such as interactive videos or user-generated content.  

Strengthen Calls-to-Action: Optimize placement and wording of calls-to-action in marketing materials to boost interactions.  

Content Diversification: Balance content types across blogs, social media, and videos to maintain consistent engagement.  

**Improve Customer Feedback Scores**

Address Negative Reviews: Analyze negative and mixed feedback to identify common issues and implement corrective actions.  

Customer Follow-Up: Engage with dissatisfied customers to resolve issues and encourage updated reviews.  

Product and Service Enhancements: Use feedback insights to guide improvements in product offerings and customer service.  

## Contributing  

Contributions are welcome! If you have suggestions or improvements, please open an issue or submit a pull request.

## Acknowledgements  

Ali Ahmad: For curating this portfolio project and providing valuable guidance in marketing analytics. [Click here](https://www.youtube.com/playlist?list=PLMfXakCUhXsHxNShtz2ucsR69RCJqMnnd) for this project playlist!



