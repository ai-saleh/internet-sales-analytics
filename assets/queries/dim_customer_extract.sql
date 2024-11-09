-- Extract and standardize customer demographics for sales analysis
-- Purpose: Create a clean customer dimension with geographical data and standardized gender values
-- Tables: DimCustomer (primary), DimGeography (location details)
/* Note: Gender values expanded from M/F to Male/Female to enhance readability 
   in sales analysis reports and dashboards. This makes gender-based sales 
   breakdowns more intuitive for business users. */

USE [AdventureWorksDW2019]

SELECT
    [c].[CustomerKey],
    [c].[FirstName],
    [c].[LastName],
    CONCAT([c].[FirstName], ' ', [c].[LastName]) AS [FullName],
    CASE [c].[Gender]
        WHEN 'M' THEN 'Male'
        WHEN 'F' THEN 'Female'
    END AS [Gender],
    [c].[DateFirstPurchase],
    [g].[City] AS [City]         /* City data included for regional analysis requirements */
FROM
    [dbo].[DimCustomer] AS [c]
    /* Using LEFT JOIN to retain all customers, even those without location data */
    LEFT JOIN [dbo].[DimGeography] AS [g] 
        ON [c].[GeographyKey] = [g].[GeographyKey]
ORDER BY
    [c].[CustomerKey] ASC        /* Default sort by primary key for consistent output */