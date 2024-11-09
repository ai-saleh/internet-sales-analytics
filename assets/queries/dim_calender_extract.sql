-- Prepare date dimension lookup table with standardized calendar attributes
-- Purpose: Create a clean date dimension with standardized naming conventions
-- Tables: DimDate (calendar dimension table)
/* Note: Date attributes formatted for consistency:
   - Day names in English 
   - Month names abbreviated to 3 characters
   - Date ranges filtered dynamically for 24-month retrospective analysis */

USE [AdventureWorksDW2019]

SELECT
    [DateKey],
    [FullDateAlternateKey] AS [Date],
    [EnglishDayNameOfWeek] AS [DayName],
    [WeekNumberOfYear] AS [WeekNum],
    [EnglishMonthName] AS [MonthName],
    LEFT([EnglishMonthName], 3) AS [MonthShort],    /* Abbreviated month names for compact reporting */
    [MonthNumberOfYear] AS [MonthNum],
	[CalendarQuarter] AS [Quarter],
    [CalendarYear] AS [Year]
FROM
    [dbo].[DimDate]
    /* Dynamic filter for rolling 24-month analysis window */
WHERE
    [CalendarYear] >= YEAR(GETDATE()) - 2
ORDER BY
    [DateKey] ASC                                    /* Natural chronological order */