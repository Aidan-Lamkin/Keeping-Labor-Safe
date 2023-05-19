	/* Query to start aggregating metrics over labor time periods */

	DECLARE @CaseID INT = 5;

	IF OBJECT_ID('tempdb..#InputFrames') IS NOT NULL 
		DROP TABLE #InputFrames
	
	CREATE TABLE #InputFrames (CaseID INT, FrameStartDateTime DATETIME2(2), FrameEndDateTime DATETIME2(2), VariableKey VARCHAR(128), VariableValue DECIMAL(6,3), FRI DECIMAL(6,3))
	INSERT INTO #InputFrames
	SELECT CaseID, FrameStartDateTime, FrameEndDateTime, cast(VariableKey AS VARCHAR(128)) AS VariableKey, VariableValue, FRI
	FROM (SELECT Id
			   , CaseID
			   , CaseFrameSeqID
			   , FrameStartDateTime
			   , FrameEndDateTime
			   , CAST(NumContractions AS DECIMAL(6,3)) AS NumContractions
			   , CAST(FHRBaselineBPM AS DECIMAL(6,3)) AS FHRBaselineBPM
			   , CAST(FHRVariabilityBPM AS DECIMAL(6,3)) as FHRVariabilityBPM
			   , CAST(NumFHRAccelerations AS DECIMAL(6,3))AS NumFHRAccelerations
			   , CAST(NumFHRLateRecovery AS DECIMAL(6,3)) AS NumFHRLateRecovery
			   , CAST(bMaternalRiskFactor AS DECIMAL(6,3)) AS bMaternalRiskFactor
			   , CAST(bFetalRiskFactor AS DECIMAL(6,3)) AS bFetalRiskFactor
			   , CAST(bObstetricRiskFactor AS DECIMAL(6,3)) AS bObstetricRiskFactor
			   , FRI
		  FROM ana.tKlsFrame10Min) as cp
	UNPIVOT 
	(
		VariableValue FOR VariableKey IN (NumContractions, FHRBaselineBPM, FHRVariabilityBPM, NumFHRAccelerations, NumFHRLateRecovery, bMaternalRiskFactor, bFetalRiskFactor, bObstetricRiskFactor)
	) as up 


	IF OBJECT_ID('tempdb..#TimePeriods') IS NOT NULL 
		DROP TABLE #TimePeriods

	CREATE TABLE #TimePeriods (TimePeriodKey VARCHAR(128), TimePeriodStartDateTime DATETIME2(2), TimePeriodEndDateTime DATETIME2(2))
	INSERT INTO #TimePeriods
	SELECT 'TotalAbnormalHours', CaseStartDateTime, CaseEndDateTime
	FROM dbo.tKlsCase
	UNION
	SELECT 'EpiduralToDelivery', EpiduralDateTime, CaseEndDateTime
	FROM dbo.tKlsCase
	UNION
	SELECT 'IrToDelivery', IrDateTime, CaseEndDateTime
	FROM dbo.tKlsCase

	SELECT CaseID
		 , TimePeriodKey
		 , CAST(ROUND(MAX(NumContractions), 2) AS DECIMAL(6,2)) AS [EXUA]
		 , CAST(ROUND(MAX(FHRBaselineBPM), 2) AS DECIMAL(6,2)) AS [FHR]
		 , CAST(ROUND(MAX(FHRVariabilityBPM), 2) AS DECIMAL(6,2))  AS [VARIAB]
		 , CAST(ROUND(MAX(NumFHRAccelerations), 2) AS DECIMAL(6,2))  AS [ACCELS]
		 , CAST(ROUND(MAX(NumFHRLateRecovery), 2) AS DECIMAL(6,2))  AS [DECELS]
		 , CAST(ROUND(MAX(YellowHours),2) AS DECIMAL(6,2))  AS [YELLOW]
		 , CAST(ROUND(MAX(RedHours), 2) AS DECIMAL(6,2))  AS [RED]
	FROM (
	SELECT CaseID, TimePeriodKey, NumContractions, FHRBaselineBPM, FHRVariabilityBPM, NumFHRAccelerations, NumFHRLateRecovery, YellowHours, RedHours
	FROM 
	(
	select frm.CaseID, vrb.VariableKey, tp.TimePeriodKey
		 , DATEDIFF(SECOND, MIN(FrameStartDateTime), MAX(FrameEndDateTime)) / 3600.0 AS LaborHours
		 , CASE WHEN vrb.VariableKey IN ('NumContractions', 'NumFHRAccelerations', 'NumFHRLateRecovery') THEN SUM(frm.VariableValue) ELSE AVG(frm.VariableValue) END AS AggregatedValue
		 , SUM(CASE WHEN frm.VariableValue BETWEEN vrb.ThresholdMin AND vrb.ThresholdMax THEN 0 ELSE DATEDIFF(MILLISECOND, FrameStartDateTime, DATEADD(MILLISECOND, 250, FrameEndDateTime)) / 3600000.0 END) AS AbnormalTimeHours
		 , SUM(CASE WHEN frm.FRI > 0.5 THEN 0 WHEN frm.FRI > 0.25 THEN DATEDIFF(MILLISECOND, FrameStartDateTime, DATEADD(MILLISECOND, 250, FrameEndDateTime)) / 3600000.0 ELSE 0 END) AS YellowHours
		 , SUM(CASE WHEN frm.FRI <= 0.25 THEN DATEDIFF(MILLISECOND, FrameStartDateTime, DATEADD(MILLISECOND, 250, FrameEndDateTime)) / 3600000.0 ELSE 0 END) AS RedHours
	from #InputFrames frm
		INNER JOIN dbo.tKlsCase cas
			ON frm.CaseID = cas.CaseID
		INNER JOIN cfg.tFRIVariable vrb
			ON vrb.VariableKey = frm.VariableKey
		LEFT JOIN #TimePeriods tp
			ON frm.FrameStartDateTime BETWEEN tp.TimePeriodStartDateTime AND tp.TimePeriodEndDateTime
	WHERE vrb.VariableKey IN ('NumContractions', 'NumFHRAccelerations', 'NumFHRLateRecovery', 'FHRBaselineBPM', 'FHRVariabilityBPM')
	group by frm.CaseID, vrb.VariableID, vrb.VariableKey, tp.TimePeriodKey
	) t
	PIVOT 
		( MAX([AbnormalTimeHours])
			FOR VariableKey IN ([NumContractions], [NumFHRAccelerations], [NumFHRLateRecovery], [FHRBaselineBPM], [FHRVariabilityBPM])
		) pvt
	) t1
	WHERE CaseID = @CaseID
	GROUP BY CaseID, TimePeriodKey
	ORDER BY CaseID, TimePeriodKey

	--SELECT *, case when [FRI] > 0.5 THEN 'GREEN' WHEN [FRI] > 0.25 THEN 'YELLOW' ELSE 'RED' END AS Color 
	--FROM ana.tKlsFrame10Min frm
	--WHERE CaseID = @CaseID



	--select * from dbo.tKlsCase 
	--WHERE CaseID = @CaseID

	--SELECT CaseID, SampleDateTime ,MAX(UA)  AS UA, MAX(HR) AS HR, MAX(HR2) AS HR2, MAX(MHR) AS MHR, MAX(m_ExecutionDt) as m_ExecutionDt
	--FROM (
	--SELECT pvt.CaseID, SampleDateTime, [UA], [HR], [HR2], [MHR], m_ExecutionDt
	--FROM dbo.vwTransformKlsSampleData
	--PIVOT 
	--	(
	--		MAX([Value])
	--		FOR MetricKey in ([UA], [HR], [HR2], [MHR])

	--	) pvt
	--) as t
	--group by CaseID, SampleDateTime

	--select * from dbo.tKlsCase
	--order by CaseID 

	----	alter table dbo.tKlsCase  add IrDateTime DATETIME2(2), EpiduralDateTime DATETIME2(2)

	update dbo.tKlsCase SET --EpiduralDateTime = DATEADD(MILLISECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(MILLISECOND, CaseStartDateTime, DATEADD(MINUTE, DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 2, CaseStartDateTime))), CaseStartDateTime)
						  --, 
						  IrDateTime = CASE WHEN CaseID % 3 = 0 then DATEADD(MILLISECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(MILLISECOND, CaseStartDateTime, DATEADD(MINUTE, DATEDIFF(MINUTE, CaseStartDateTime, CaseEndDateTime) / 1.5, CaseStartDateTime))), CaseStartDateTime) else null end 



	--select * from dbo.tKlsCase
	--order by CaseID

	--select * from ana.tKlsFrame10Min
	--where CaseID = 12