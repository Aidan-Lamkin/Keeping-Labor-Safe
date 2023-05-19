/* Uses merge pattern to update/insert additional metric data by case into output tables */

CREATE PROCEDURE [ana].[uspStoreAdditionalMetrics]
	@CaseID INT

AS 
BEGIN

	SET NOCOUNT ON;

	SET ANSI_WARNINGS OFF;

-- I. Time Period based metrics 

	/* Use temporary table to store case frames and variable values */

	IF OBJECT_ID('tempdb..#InputFrames') IS NOT NULL 
		DROP TABLE #InputFrames
	
	CREATE TABLE #InputFrames (CaseID INT, CaseFrameSeqID INT, FrameStartDateTime DATETIME2(2), FrameEndDateTime DATETIME2(2), VariableKey VARCHAR(128), VariableValue DECIMAL(6,3), FRI DECIMAL(6,3))
	INSERT INTO #InputFrames
	SELECT CaseID, CaseFrameSeqID, FrameStartDateTime, FrameEndDateTime, cast(VariableKey AS VARCHAR(128)) AS VariableKey, VariableValue, FRI
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
			   , CAST(bObstetricalRiskFactor AS DECIMAL(6,3)) AS bObstetricalRiskFactor
			   , FRI
		  FROM ana.tKlsFrame10Min) as cp
	UNPIVOT 
	(
		VariableValue FOR VariableKey IN (NumContractions, FHRBaselineBPM, FHRVariabilityBPM, NumFHRAccelerations, NumFHRLateRecovery, bMaternalRiskFactor, bFetalRiskFactor, bObstetricalRiskFactor)
	) as up 

	/* Use an additional teporary table to create a space of active time periods */
	IF OBJECT_ID('tempdb..#TimePeriods') IS NOT NULL 
		DROP TABLE #TimePeriods

	CREATE TABLE #TimePeriods (TimePeriodKey VARCHAR(128), TimePeriodName VARCHAR(128), TimePeriodStartDateTime DATETIME2(2), TimePeriodEndDateTime DATETIME2(2))
	INSERT INTO #TimePeriods
	SELECT TimePeriodKey, TimePeriodName, startms.MilestoneDateTime, endms.MilestoneDateTime
	FROM ref.tTimePeriod tp
		LEFT JOIN dbo.tKlsCaseMilestone startms
			ON startms.MilestoneID = tp.StartMilestoneID
				AND startms.CaseID = @CaseID
		LEFT JOIN dbo.tKlsCaseMilestone endms 
			ON endms.MilestoneID = tp.EndMilestoneID
				AND endms.CaseID = @CaseID
	WHERE tp.IsActive = 1
		AND tp.TimePeriodGroupID = 1


	/* Calculate and merge/update time period-based metrics */

	;WITH AdditionalMetrics AS (
	SELECT CaseID
		 , TimePeriodKey
		 , TimePeriodName
		 , CAST(ROUND(MAX(NumContractions), 2) AS DECIMAL(6,2)) AS [EXUA]
		 , CAST(ROUND(MAX(FHRBaselineBPM), 2) AS DECIMAL(6,2)) AS [FHR]
		 , CAST(ROUND(MAX(FHRVariabilityBPM), 2) AS DECIMAL(6,2))  AS [VARIAB]
		 , CAST(ROUND(MAX(NumFHRAccelerations), 2) AS DECIMAL(6,2))  AS [ACCELS]
		 , CAST(ROUND(MAX(NumFHRLateRecovery), 2) AS DECIMAL(6,2))  AS [DECELS]
		 , CAST(ROUND(MAX(YellowHours),2) AS DECIMAL(6,2))  AS [YELLOW]
		 , CAST(ROUND(MAX(RedHours), 2) AS DECIMAL(6,2))  AS [RED]
	FROM (
	SELECT CaseID, TimePeriodKey, TimePeriodName, NumContractions, FHRBaselineBPM, FHRVariabilityBPM, NumFHRAccelerations, NumFHRLateRecovery, YellowHours, RedHours
	FROM 
	(
	SELECT frm.CaseID, vrb.VariableKey, tp.TimePeriodKey, tp.TimePeriodName
		 , DATEDIFF(SECOND, MIN(FrameStartDateTime), MAX(FrameEndDateTime)) / 3600.0 AS LaborHours
		 , CASE WHEN vrb.VariableKey IN ('NumContractions', 'NumFHRAccelerations', 'NumFHRLateRecovery') THEN SUM(frm.VariableValue) ELSE AVG(frm.VariableValue) END AS AggregatedValue
		 , SUM(CASE WHEN frm.VariableValue BETWEEN vrb.ThresholdMin AND vrb.ThresholdMax THEN 0 ELSE DATEDIFF(MILLISECOND, FrameStartDateTime, DATEADD(MILLISECOND, 250, FrameEndDateTime)) / 3600000.0 END) AS AbnormalTimeHours
		 , SUM(CASE WHEN frm.FRI > 0.5 THEN 0 WHEN frm.FRI > 0.25 THEN DATEDIFF(MILLISECOND, FrameStartDateTime, DATEADD(MILLISECOND, 250, FrameEndDateTime)) / 3600000.0 ELSE 0 END) AS YellowHours
		 , SUM(CASE WHEN frm.FRI <= 0.25 THEN DATEDIFF(MILLISECOND, FrameStartDateTime, DATEADD(MILLISECOND, 250, FrameEndDateTime)) / 3600000.0 ELSE 0 END) AS RedHours
	FROM #InputFrames frm
		INNER JOIN dbo.tKlsCase cas
			ON frm.CaseID = cas.CaseID
		INNER JOIN cfg.tFRIVariable vrb
			ON vrb.VariableKey = frm.VariableKey
		LEFT JOIN #TimePeriods tp
			ON frm.FrameStartDateTime BETWEEN tp.TimePeriodStartDateTime AND tp.TimePeriodEndDateTime
	WHERE vrb.VariableKey IN ('NumContractions', 'NumFHRAccelerations', 'NumFHRLateRecovery', 'FHRBaselineBPM', 'FHRVariabilityBPM')
	GROUP BY frm.CaseID, vrb.VariableID, vrb.VariableKey, tp.TimePeriodKey, tp.TimePeriodName
	) t
	PIVOT 
		( MAX([AbnormalTimeHours])
			FOR VariableKey IN ([NumContractions], [NumFHRAccelerations], [NumFHRLateRecovery], [FHRBaselineBPM], [FHRVariabilityBPM])
		) pvt
	) t1
	WHERE CaseID = @CaseID
	GROUP BY CaseID, TimePeriodKey, TimePeriodName)

	/* Use merge pattern to store time-preiod based metrics */
	MERGE dbo.tKlsCaseAdditionalMetrics AS tar
	USING (SELECT * FROM AdditionalMetrics) AS src
		ON (tar.CaseID = src.CaseID
			AND tar.TimePeriodKey = src.TimePeriodKey)
	WHEN MATCHED THEN UPDATE SET 
	    TimePeriodName = src.TimePeriodName
	  , EXUA = src.EXUA
	  , FHR = src.FHR
	  , VARIAB = src.VARIAB
	  , ACCELS = src.ACCELS
	  , DECELS = src.DECELS
	  , YELLOW = src.YELLOW
	  , RED = src.RED	
	  , m_ExecutionDt = getdate()
	WHEN NOT MATCHED THEN INSERT (CaseID
		                          , TimePeriodKey
								  , TimePeriodName
								  , EXUA
								  , FHR
								  , VARIAB
								  , ACCELS
								  , DECELS
								  , YELLOW
								  , RED
								  , m_ExecutionDt)
		VALUES (src.CaseID
			  , src.TimePeriodKey
			  , src.TimePeriodName
			  , src.EXUA
			  , src.FHR
			  , src.VARIAB
			  , src.ACCELS
			  , src.DECELS
			  , src.YELLOW
			  , src.RED
			  , GETDATE());

-- II. Total Time Metrics

	/* Select total time metrics */

	DECLARE @MaxCaseFrameSeqID INT;
	DECLARE @LowFri DECIMAL(6,3); 
	DECLARE @HrsLowFri DECIMAL(6,3);
	DECLARE @LastFri DECIMAL(6,3);
	DECLARE @HrsLastFri DECIMAL(6,3);
	DECLARE @PriorStage2CaseFrameSeqID INT;
	DECLARE @PriorStage2Fri DECIMAL(6,3);
	DECLARE @HrsStage2 DECIMAL(6,3);
	DECLARE @CurrentCaseFrameSeqID INT; 
	DECLARE @CurrentFrameStartDateTime DATETIME2(2); 
	DECLARE @CurrentFrameEndDateTime DATETIME2(2);
	DECLARE @CurrentFRI DECIMAL(6,3);
	DECLARE @SumLastFriMilliseconds BIGINT = 0;

	/* Grab max case frame seq ID and min FRI by case */

	WITH CaseMinMax AS (
			SELECT MIN([FRI]) AS LowFri
				 , MAX(CaseFrameSeqID) AS MaxCaseFrameSeqID
			FROM ana.tKlsFrame10Min frm
			WHERE CaseID = @CaseID
				AND IsQuality = 1 -- restrict trailing 0 calculations
			)

	/* Calculate Last FRI and Low FRI */
	SELECT @MaxCaseFrameSeqID = mm.MaxCaseFrameSeqID
		 , @LastFRI = [FRI]
		 , @LowFri = mm.LowFri
	FROM ana.tKlsFrame10Min frm
		INNER JOIN CaseMinMax mm
			ON frm.CaseFrameSeqID = mm.MaxCaseFrameSeqID
				AND frm.CaseID = @CaseID

	/* Calculate stage 2 hours and frames */
	;WITH Stage2 AS (
			SELECT MAX(CASE WHEN st2start.MilestoneDateTime BETWEEN FrameStartDateTime AND FrameEndDateTime THEN CaseFrameSeqID ELSE 0 END) - 1 AS PriorStage2CaseFrameSeqID
				 , SUM(CASE WHEN frm.FrameStartDateTime BETWEEN st2start.MilestoneDateTime AND st2end.MilestoneDateTime THEN DATEDIFF(MILLISECOND, frm.FrameStartDateTime, frm.FrameEndDateTime)/3600000.0 ELSE 0 END) AS HrsStage2
			FROM ana.tKlsFrame10Min frm
				INNER JOIN dbo.tKlsCase cas
					ON frm.CaseID = cas.CaseID
				LEFT JOIN dbo.tKlsCaseMilestone st2start
					ON st2start.CaseID = cas.CaseID	
						AND st2start.MilestoneID = 4
				LEFT JOIN dbo.tKlsCaseMilestone st2end
					ON st2end.CaseID = cas.CaseID	
						AND st2end.MilestoneID = 5
			WHERE cas.CaseID = @CaseID
			)

	SELECT 	@PriorStage2CaseFrameSeqID = st2.PriorStage2CaseFrameSeqID
		  , @HrsStage2 = st2.HrsStage2
	FROM Stage2 st2

	/* Calculate Prior Stage 2 FRI */
	SELECT @PriorStage2Fri = [FRI]
	FROM ana.tKlsFrame10Min frm
	WHERE CaseFrameSeqID = @PriorStage2CaseFrameSeqID
		AND CaseID = @CaseID
	
	/* Calculate Hrs Low FRI */
	SELECT @HrsLowFri = CAST(ROUND(SUM(DATEDIFF(MILLISECOND, FrameStartDateTime, FrameEndDateTime) / 3600000.0), 3) AS DECIMAL(6,3))
	FROM ana.tKlsFrame10Min 
	WHERE [FRI] = @LowFri
	AND CaseID = @CaseID

	/* Calculate Hrs Last FRI */
	DECLARE LastFriCurs CURSOR FOR SELECT CaseFrameSeqID, FrameStartDateTime, FrameEndDateTime, [FRI] FROM ana.tKlsFrame10Min WHERE CaseID = @CaseID AND CaseFrameSeqID <= @MaxCaseFrameSeqID ORDER BY CaseFrameSeqID DESC
	OPEN LastFriCurs
	FETCH NEXT FROM LastFriCurs INTO @CurrentCaseFrameSeqID, @CurrentFrameStartDateTime, @CurrentFrameEndDateTime, @CurrentFRI
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		IF @CurrentFRI = @LastFri
		BEGIN
			SET @SumLastFriMilliseconds = @SumLastFriMilliseconds + DATEDIFF(MILLISECOND, @CurrentFrameStartDateTime, @CurrentFrameEndDateTime);
		END
		ELSE
		BEGIN
			BREAK;
		END
		FETCH NEXT FROM LastFriCurs INTO @CurrentCaseFrameSeqID, @CurrentFrameStartDateTime, @CurrentFrameEndDateTime, @CurrentFRI
	END
	CLOSE LastFriCurs
	DEALLOCATE LastFriCurs

	SET @HrsLastFRI = CAST(ROUND(@SumLastFriMilliseconds / 3600000.0, 3) AS DECIMAL(6,3))

	/* Grab final values */ 

	;WITH CaseOutcome AS (SELECT * FROM 
	(SELECT @CaseID AS CaseID) t0
	CROSS JOIN 
	(SELECT 	@LowFri AS [LowFRI] ) t1
	CROSS JOIN
	(SELECT @HrsLowFri AS [HrsLowFRI]) t2
	CROSS JOIN
	(SELECT @LastFri AS [LastFRI]) t3
	CROSS JOIN 
	(SELECT @HrsLastFri AS [HrsLastFRI]) t4
	CROSS JOIN
	(SELECT @PriorStage2Fri AS [FRIPriorStage2]) t5
	CROSS JOIN
	(SELECT @HrsStage2 AS [HrsStage2]) t6 )

	/* Merge case outcome data to output table*/
	MERGE dbo.tKlsCaseOutcome AS tar
	USING (SELECT * FROM CaseOutcome) AS src
		ON (tar.CaseID = src.CaseID)
	WHEN MATCHED THEN UPDATE SET LowFRI = src.LowFRI
							   , HrsLowFRI = src.HrsLowFRI
							   , LastFRI = src.LastFRI
							   , HrsLastFRI = src.HrsLastFRI
							   , FRIPriorStage2 = src.FRIPriorStage2
							   , HrsStage2 = src.HrsStage2
							   , m_ExecutionDt = getdate()
	WHEN NOT MATCHED THEN INSERT (CaseID, LowFRI, HrsLowFRI, LastFRI, HrsLastFRI, FRIPriorStage2, HrsStage2, m_ExecutionDt)
	VALUES (src.CaseID
		 , src.LowFRI
		 , src.HrsLowFRI
		 , src.LastFRI
		 , src.HrsLastFRI
		 , src.FRIPriorStage2
		 , src.HrsStage2
		 , getdate());
		

 
END