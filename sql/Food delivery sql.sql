SELECT * FROM food_delivery
LIMIT 10;

1. Top-Spending Customers
SELECT
    "Customer_ID",
    SUM("Final_Amount") AS "Total_Spending"
FROM food_delivery
WHERE "Final_Amount" IS NOT NULL
GROUP BY "Customer_ID"
ORDER BY "Total_Spending" DESC
LIMIT 10;

2. Age Group vs Order Value
SELECT
    "Age_Group",
    COUNT(*) AS "Total_Orders",
    ROUND(AVG("Order_Value")::NUMERIC, 2) AS "Average_Order_Value"
FROM food_delivery
WHERE "Order_Value" IS NOT NULL
GROUP BY "Age_Group"
ORDER BY "Average_Order_Value" DESC;

3. Weekend vs weekday order patterns
SELECT
     "Order_Day_Type",
	 COUNT(*) AS "Total_orders",
	 ROUND(AVG("Order_Value")::NUMERIC, 2) AS Average_orders
FROM food_delivery
GROUP BY "Order_Day_Type"
ORDER BY "Total_orders" DESC;

4. Monthly Revenue Trends
SELECT
    EXTRACT(YEAR FROM "Order_Date") AS "Order_Year",
    EXTRACT(MONTH FROM "Order_Date") AS "Order_Month",
    ROUND(SUM("Final_Amount")::numeric, 2) AS "Monthly_Revenue"
FROM food_delivery
WHERE "Order_Date" IS NOT NULL
  AND "Final_Amount" IS NOT NULL
GROUP BY
    EXTRACT(YEAR FROM "Order_Date"),
    EXTRACT(MONTH FROM "Order_Date")
ORDER BY
    "Order_Year",
    "Order_Month";

5.Impact of Discounts on Profit
SELECT
      "Discount_Applied",
	  COUNT (*) AS "Total_orders",
	  ROUND(AVG("Profit_Margin")::NUMERIC, 2) AS Average_Profit
FROM food_delivery
WHERE  "Discount_Applied" IS NOT NULL
AND "Profit_Margin" IS NOT NULL
GROUP BY "Discount_Applied"
ORDER BY "Discount_Applied";

6.A High-Revenue Cities
SELECT 
     "City",
	 COUNT(*) AS "Total_orders",
	 ROUND(SUM("Final_Amount")::numeric, 2) AS "Total_Revenue"
FROM food_delivery
WHERE "City" IS NOT NULL
  AND "Final_Amount" IS NOT NULL
  AND "City" <> 'Unknown'
GROUP BY "City"
ORDER BY "Total_Revenue" DESC;

6.B. High-Revenue Cuisines
SELECT 
     "Cuisine_Type",
	 COUNT(*) AS "Total_orders",
	 ROUND(SUM("Final_Amount")::numeric, 2) AS "Total_Revenue"
FROM food_delivery
WHERE "Cuisine_Type" IS NOT NULL
  AND "Cuisine_Type" <> 'Unknown'
  AND "Final_Amount" IS NOT NULL
GROUP BY "Cuisine_Type"
ORDER BY "Total_Revenue" DESC;

7. Average Delivery Time by City.
SELECT 
     "City",
	 COUNT("Delivery_Time_Min") AS "Total_Deliveries",
    ROUND(AVG("Delivery_Time_Min")::numeric, 2) AS "Average_Delivery_Time"
FROM food_delivery
WHERE "City" IS NOT NULL
  AND "City" <> 'Unknown'
  AND "Delivery_Time_Min" IS NOT NULL
GROUP BY "City"
ORDER BY "Average_Delivery_Time" ASC;

8.Distance vs Delivery Delay
SELECT
    CASE
        WHEN "Distance_km" < 5 THEN 'Short'
        WHEN "Distance_km" BETWEEN 5 AND 15 THEN 'Medium'
        ELSE 'Long'
    END AS "Distance_Category",

    COUNT(*) AS "Total_Orders",
    ROUND(AVG("Distance_km")::numeric, 2) AS "Average_Distance",
    ROUND(AVG("Delivery_Time_Min")::numeric, 2) AS "Average_Delivery_Time"
FROM food_delivery
WHERE "Distance_km" IS NOT NULL
  AND "Delivery_Time_Min" IS NOT NULL
GROUP BY
    CASE
        WHEN "Distance_km" < 5 THEN 'Short'
        WHEN "Distance_km" BETWEEN 5 AND 15 THEN 'Medium'
        ELSE 'Long'
    END
ORDER BY "Average_Distance";

9. Delivery Rating vs Delivery Time
SELECT
    "Delivery_Performance",
    COUNT(*) AS "Total_Orders",
    ROUND(AVG("Delivery_Time_Min")::numeric, 2) AS "Average_Delivery_Time",
    ROUND(AVG("Delivery_Rating")::numeric, 2) AS "Average_Delivery_Rating"
FROM food_delivery
WHERE "Delivery_Performance" IS NOT NULL
  AND "Delivery_Time_Min" IS NOT NULL
  AND "Delivery_Rating" IS NOT NULL
GROUP BY "Delivery_Performance"
ORDER BY "Average_Delivery_Time";

10.Top-Rated Restaurants
SELECT
     "Restaurant_Name",
	 COUNT(*) AS "Total_Orders",
	 ROUND(AVG("Restaurant_Rating")::numeric, 2) AS "Average_Restaurant_Rating"
FROM food_delivery
WHERE "Restaurant_Rating" IS NOT NULL
  AND "Restaurant_Name" IS NOT NULL
GROUP BY "Restaurant_Name"
HAVING COUNT(*) >= 10
ORDER BY "Average_Restaurant_Rating" DESC
LIMIT 10;

11. Cancellation Rate by Restaurant
SELECT
    "Restaurant_Name",
    COUNT(*) AS "Total_Orders",
    COUNT(*) FILTER (
        WHERE "Order_Status" = 'Cancelled') AS "Cancelled_Orders",
    ROUND(
        (
    COUNT(*) FILTER (
                WHERE "Order_Status" = 'Cancelled'
            )::numeric
            / COUNT(*)
        ) * 100,
        2
    ) AS "Cancellation_Rate_Percent"
FROM food_delivery
WHERE "Restaurant_Name" IS NOT NULL
  AND "Restaurant_Name" <> 'Unknown'
GROUP BY "Restaurant_Name"
HAVING COUNT(*) >= 10
ORDER BY "Cancellation_Rate_Percent" DESC
LIMIT 10;

12. Cuisine-wise Performance
SELECT
      "Cuisine_Type",
	  COUNT(*) AS "Total_Orders",
	  ROUND(AVG("Final_Amount")::NUMERIC, 2) AS "Total_Revenue",
	  ROUND(AVG("Restaurant_Rating")::numeric, 2) AS "Average_Restaurant_Rating"
FROM food_delivery
WHERE "Cuisine_Type" IS NOT NULL
  AND "Cuisine_Type" <> 'Unknown'
  AND "Final_Amount" IS NOT NULL
GROUP BY "Cuisine_Type" 
ORDER BY "Total_Revenue" DESC;

13. Peak Hour Demand Analysis
SELECT
    "Peak_Hour",
    COUNT(*) AS "Total_Orders",
    ROUND(SUM("Final_Amount")::numeric, 2) AS "Total_Revenue"
FROM food_delivery
WHERE "Peak_Hour" IS NOT NULL
  AND "Final_Amount" IS NOT NULL
GROUP BY "Peak_Hour"
ORDER BY "Total_Orders" DESC;

14. Payment Mode Preferences
SELECT
     "Payment_Mode",
	 COUNT(*) AS "Total_Orders"
FROM food_delivery
WHERE "Payment_Mode" IS NOT NULL
  AND "Payment_Mode" <> 'Unknown'
GROUP BY "Payment_Mode"
ORDER BY "Total_Orders" DESC;

15. Cancellation Reason Analysis
SELECT  
     "Cancellation_Reason",
	 COUNT(*) AS "Cancelled_orders"
FROM food_delivery
WHERE "Order_Status" = 'Cancelled'
  AND "Cancellation_Reason" IS NOT NULL
  AND "Cancellation_Reason" <> 'Unknown'
GROUP BY "Cancellation_Reason"
ORDER BY "Cancelled_orders" DESC;