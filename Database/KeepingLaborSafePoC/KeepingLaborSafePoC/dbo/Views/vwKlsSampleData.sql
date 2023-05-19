CREATE VIEW dbo.vwKlsSampleData
AS
WITH Ord AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY CaseID, SampleDate, MetricKey ORDER BY CaseID) AS Ordinal
FROM dbo.tKlsSampleData)
SELECT * FROM Ord WHERE Ordinal = 1