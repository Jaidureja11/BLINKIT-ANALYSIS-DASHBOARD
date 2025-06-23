create database BLINKIT_ANALYSIS ;
select * from blinkit_data;
update blinkit_data
Set Item_Fat_Content =
CASE 
WHEN Item_Fat_Content In ( 'LF', 'low fat') THEN 'Low Fat'
When  Item_Fat_Content = 'reg' Then 'Regular'
Else Item_Fat_Content
END 
SELECT DISTINCT (Item_Fat_Content) FROM blinkit_data;
select CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2))  AS TOTAL_SALES_IN_MILLIONS
FROM blinkit_data

select CAST(avg(Total_Sales)AS DECIMAL (10,1))as Avg_Sale from blinkit_data;
select count(*) as No_Of_Items from blinkit_data
where Outlet_Establishment_Year = 2022 

Select CAST(avg (Rating_) AS DECIMAL (10,2)) as Avg_Rating From blinkit_data ;

select Item_Fat_Content, 
CONCAT(ROUND(SUM(Total_Sales)/1000, 2), 'K') as SALES_IN_THOUSANDS,
CAST(avg(Total_Sales) AS DECIMAL (10,2))as AVG_SALES_ ,
 COUNT(*) as No_Of_Items ,
 CAST(avg (Rating_) AS DECIMAL (10,2)) as Avg_Rating
 from blinkit_data

group by Item_Fat_Content 
ORDER BY SALES_IN_THOUSANDS DESC;

select distinct Item_Type from blinkit_data

select Item_Type , 
 CAST(SUM(Total_Sales) AS DECIMAL(10,2)) as SALES,
CAST(avg(Total_Sales) AS DECIMAL (10,2))as AVG_SALES_ ,
 COUNT(*) as No_Of_Items ,
 CAST(avg (Rating_) AS DECIMAL (10,2)) as Avg_Rating
 from blinkit_data

group by Item_Type
ORDER BY SALES DESC
LIMIT 5 ;

SELECT Outlet_Location_Type, Item_Fat_Content,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) as SALES,
CAST(avg(Total_Sales) AS DECIMAL (10,2))as AVG_SALES_ ,
 COUNT(*) as No_Of_Items ,
 CAST(avg (Rating_) AS DECIMAL (10,2)) as Avg_Rating
 from blinkit_data

group by  Outlet_Location_Type, Item_Fat_Content
ORDER BY SALES DESC

#need low fat , regular in the column format 
/* pivot doesnt work for mysql 
SELECT Outlet_Location_Type,
	ISNULL([Low Fat], 0)  AS Low_Fat, 
    ISNULL([Regular], 0)  AS Regular 
From 
(
	Select 
		Outlet_Location_Type, 
		Item_Fat_Content,
		SUM(Total_Sales)  as Total_Sales
	from 
		blinkit_data
	group by  
		Outlet_Location_Type, 
		Item_Fat_Content
) as SourceTable
PIVOT
(
	Sum(Total_Sales)
    For Item_Fat_Content In ([Low Fat], [Regular])
) As PivotTable
order by Outlet_Location_Type;
*/

SELECT Outlet_Location_Type,
    ROUND(SUM(CASE 
        WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales 
        ELSE 0 
    END), 2) AS Low_Fat,

    ROUND(SUM(CASE 
        WHEN Item_Fat_Content = 'Regular' THEN Total_Sales 
        ELSE 0 
    END), 2) AS Regular
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

SELECT Outlet_Establishment_Year,
CONCAT(ROUND(SUM(Total_Sales)/1000, 2), 'K') as SALES_IN_THOUSANDS,
CAST(avg(Total_Sales) AS DECIMAL (10,2))as Avg_Sales,
 COUNT(*) as No_Of_Items ,
 CAST(avg (Rating_) AS DECIMAL (10,2)) as Avg_Rating

FROM blinkit_data
group by Outlet_Establishment_Year
order by Avg_Sales Desc ;

select Outlet_size,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) as Total_Sales,
cast((sum(Total_Sales)*100.0 / SUM(SUM(Total_Sales))Over()) AS DECIMAL(10,2)) AS Sales_Percentage
from blinkit_data
Group by Outlet_Size
order by Total_Sales DESC ; 

select Outlet_Location_Type,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) as Total_Sales,
cast((sum(Total_Sales)*100.0 / SUM(SUM(Total_Sales))Over()) AS DECIMAL(10,2)) AS Sales_Percentage
from blinkit_data
Group by Outlet_Location_Type
order by Total_Sales DESC ;

select Outlet_Type,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) as Total_Sales,
cast((sum(Total_Sales)*100.0 / SUM(SUM(Total_Sales))Over()) AS DECIMAL(10,2)) AS Sales_Percentage
from blinkit_data
Group by Outlet_Type
order by Total_Sales DESC ;
SELECT distinct (OUTLET_TYPE) FROM blinkit_data











