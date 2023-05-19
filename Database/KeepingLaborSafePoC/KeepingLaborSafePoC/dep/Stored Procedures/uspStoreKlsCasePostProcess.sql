
/* DEPRECATED */ 
/* No longer need to adjust ends of cases or mock milestone data */ 

/* This procedure accomplishes the following: 

	1) Adjusts case end date times to correspond to final sample date time (necessary due to the format of the incoming data with one minute per row). 
    2) Adds mock milestone data for each case to allow for calculation of additional metrics (PoC) 

*/

CREATE PROCEDURE [dep].[uspStoreKlsCasePostProcess]
AS
BEGIN

	SET NOCOUNT ON;

	/* Fix case end date times to correspond to final sample date time */

	UPDATE cas
	SET CaseEndDateTime = piv.MaxSampleDateTime
	FROM dbo.tKlsCase cas
		INNER JOIN (SELECT CaseID, MAX(SampleDateTime) AS MaxSampleDateTime
					FROM app.tKlsSample_Pivot
					GROUP BY CaseID) piv
			ON cas.CaseID = piv.CaseID
	WHERE cas.CaseID = piv.CaseID

	;with Stage2StartDateTimes AS (
		SELECT CaseID, DATEADD(MILLISECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(MILLISECOND, DATEADD(MINUTE, 4*DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 5, CaseStartDateTime), DATEADD(MINUTE, 5*DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 6, CaseStartDateTime))), DATEADD(MINUTE, 4*DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 5, CaseStartDateTime)) AS Stage2StartDateTime
		from dbo.tKlsCase)
		

	/* Insert mock case milestones into milestone table */ 

	INSERT INTO dbo.tKlsCaseMilestone (CaseID, MilestoneID, MilestoneDateTime, m_ExecutionDt)

	SELECT CaseID, MilestoneID, MilestoneDateTime, m_ExecutionDt
	FROM (
		SELECT CaseID, 1 AS MilestoneID, CaseStartDateTime AS MilestoneDateTime, getdate() AS m_ExecutionDt
		FROM dbo.tKlsCase
		UNION
		SELECT CaseID, 2, DATEADD(MILLISECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(MILLISECOND, CaseStartDateTime, DATEADD(MINUTE, DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 2, CaseStartDateTime))), CaseStartDateTime), getdate()
		FROM dbo.tKlsCase
		UNION
		SELECT CaseID, 3, CASE WHEN CaseID % 3 = 1 then DATEADD(MILLISECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(MILLISECOND, CaseStartDateTime, DATEADD(MINUTE, DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 1.5, CaseStartDateTime))), CaseStartDateTime) else null end, getdate()
		FROM dbo.tKlsCase
		UNION 
		SELECT cas.CaseID, 4, sds.Stage2StartDateTime, getdate()
		FROM dbo.tKLsCase cas
			INNER JOIN Stage2StartDateTimes sds
				ON cas.CaseID = sds.CaseID
		UNION
		SELECT cas.CaseID, 5, CASE WHEN DATEADD(HOUR, 4, sds.Stage2StartDateTime) > CaseEndDateTime THEN CaseEndDateTime ELSE DATEADD(HOUR, 5, sds.Stage2StartDateTime) END, getdate()
		FROM dbo.tKLsCase cas
			INNER JOIN Stage2StartDateTimes sds
				ON cas.CaseID = sds.CaseID
		UNION
		SELECT CaseID, 6, CaseEndDateTime, getdate()
		FROM dbo.tKlsCase
		) cas
	WHERE CaseID NOT IN (Select DISTINCT CaseID FROM dbo.tKlsCaseMilestone)


END