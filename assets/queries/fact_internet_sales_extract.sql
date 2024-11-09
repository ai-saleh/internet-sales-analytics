-- Extract internet sales transactions for analysis
-- Purpose: Create a clean fact table of internet sales with key metrics and dimensions
-- Tables: FactInternetSales (transaction data)
/* Note: Data filtered for last 24 months of sales activity to support
  current analysis requirements and align with business reporting needs.
  Includes key relationships to customer, product, and date dimensions. */

USE [AdventureWorksDW2019]

SELECT
   [ProductKey],                    /* Links to product dimension */
   [OrderDateKey],                  /* Links to date dimension */
   [DueDateKey],                    /* For delivery performance analysis */
   [ShipDateKey],                   /* For shipping performance analysis */
   [CustomerKey],                   /* Links to customer dimension */
   [SalesOrderNumber],              /* Unique transaction identifier */
   [SalesAmount]                    /* Primary sales metric */
FROM
   [dbo].[FactInternetSales]
WHERE
   LEFT([OrderDateKey], 4) >= YEAR(GETDATE()) - 2    /* Rolling 24-month analysis window */
ORDER BY
   [OrderDateKey] ASC                                 /* Chronological order */