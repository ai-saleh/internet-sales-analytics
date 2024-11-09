-- Extract and standardize product dimension for sales analysis
-- Purpose: Create a comprehensive product lookup table with category classifications
-- Tables: DimProduct (primary), DimProductSubcategory, DimProductCategory
/* Note: Selected columns support various analytical scenarios:
  - Product categorization (Category -> Subcategory -> Product)
  - Product attributes (Color, Size, Line, Model)
  - Product status with default handling for NULL values
  This selection enables multi-level product performance analysis and segmentation. */

USE [AdventureWorksDW2019]

SELECT
   [pd].[ProductKey],
   [pd].[ProductAlternateKey] AS [ItemCode],
   [pd].[EnglishProductName] AS [ProductName],
   [ps].[EnglishProductSubcategoryName] AS [Subcategory],    /* For subcategory-level analysis */
   [pc].[EnglishProductCategoryName] AS [Category],          /* For category-level analysis */
   [pd].[Color],                                             /* Product attributes for segmentation */
   [pd].[Size],
   [pd].[ProductLine],
   [pd].[ModelName],
   [pd].[EnglishDescription] AS [Description],
   ISNULL([pd].[Status], 'Outdated') AS [Status]            /* Default 'Outdated' for NULL status */
FROM
   [dbo].[DimProduct] AS [pd]
   /* Maintain all products even without subcategory assignments */
   LEFT JOIN [dbo].[DimProductSubcategory] AS [ps] 
       ON [pd].[ProductSubcategoryKey] = [ps].[ProductSubcategoryKey]
   /* Maintain all products even without category assignments */
   LEFT JOIN [dbo].[DimProductCategory] AS [pc] 
       ON [ps].[ProductCategoryKey] = [pc].[ProductCategoryKey]
ORDER BY
   [pd].[ProductKey] ASC                                     /* Default sort by primary key */