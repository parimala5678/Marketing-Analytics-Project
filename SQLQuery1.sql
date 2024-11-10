-- cleaning data with sql


-- for company to understand which price category is working the best.
select * from dbo.products;

select productid, productname, price,
case when price < 50 then 'Low'
when price between 50 and 200 then 'Medium'
else 'High' 
end as PriceCategory
from dbo.products;


select * from dbo.customers;
select * from dbo.geography;

-- sql statement to join customers with geogrpahy to enrich customer data with geographic information
select CustomerID, CustomerName, Email, gender, age, g.country,g.City
from dbo.customers c
join dbo.geography g
on g.GeographyID = c.GeographyID;


select * from dbo.customer_reviews;

-- the col 'ReviewText' needs to be cleaned as there are white spaces between the words
select reviewid, customerid, productid, reviewdate, rating, 
replace(reviewtext, '  ',' ') as ReviewText
from dbo.customer_reviews;

select * from dbo.engagement_data;

-- contenttype, engagementdate, viewsclicks cols need to be cleaned

select engagementId,contentid, CampaignID, ProductID,
lower(replace(contenttype, 'Socialmedia', 'social media')) as contentType,
left(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) -1 ) as views,
right(viewsclickscombined, len(viewsclickscombined) - CHARINDEX('-', ViewsClicksCombined)) as clicks,
likes,
FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate
from dbo.engagement_data
where ContentType!= 'newsletter' ;-- we do not want to include newsletter contenttype as it is not relevant to our analysis


select * from dbo.customer_journey;



select journeyid, customerid, ProductID, VisitDate,stage,
action, coalesce(duration, avg_duration) as duration
from
( SELECT 
            JourneyID,  
            CustomerID,  
            ProductID, 
            VisitDate,  
            UPPER(Stage) AS Stage,  
            Action,  
            Duration,  
            AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,
            ROW_NUMBER() OVER (
                PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  -- Groups by these columns to identify duplicate records
                ORDER BY JourneyID  -- Orders by JourneyID to keep the first occurrence of each duplicate
            ) AS row_num  -- Assigns a row number to each row within the partition to identify duplicates
        FROM 
            dbo.customer_journey 
    ) AS subquery  
WHERE 
    row_num = 1
	order by JourneyID
	;
