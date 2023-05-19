﻿CREATE VIEW stg.vwPatientMapping 
AS 

WITH dup AS (
	SELECT MRN FROM (
		SELECT MRN, INPATIENT_DATA_ID
		FROM stg.tPatientMapping
		GROUP BY MRN, INPATIENT_DATA_ID
		HAVING COUNT(*) > 1) AS T)
SELECT *
FROM stg.tPatientMapping
WHERE MRN NOT IN (SELECT MRN FROM dup)