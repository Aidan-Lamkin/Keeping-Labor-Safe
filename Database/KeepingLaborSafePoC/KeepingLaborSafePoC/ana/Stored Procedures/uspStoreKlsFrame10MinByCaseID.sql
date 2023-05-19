
CREATE PROCEDURE [ana].[uspStoreKlsFrame10MinByCaseID] @CaseID INT
AS
BEGIN

SET NOCOUNT ON;

	/* Delete existing frames for the specific case */

	DELETE FROM ana.tKlsFrame10Min 
	WHERE CaseID = @CaseID;

	/* Insert new frames */

	;WITH Nums AS
	(
	  SELECT n = ROW_NUMBER() OVER (ORDER BY [object_id]) 
	  FROM sys.all_objects 

	),
	Frames AS (
		SELECT cas.CaseID
			 , ROW_NUMBER() OVER (PARTITION BY CaseID ORDER BY (SELECT 1)) AS CaseFrameSeqID
			 , 10*60*(ROW_NUMBER() OVER (PARTITION BY CaseID ORDER BY (SELECT 1)) - 1) AS Seconds
			 , cas.CaseStartDateTime
			 , cas.CaseEndDateTime
			 , DATEADD(MINUTE, 10*(num.n - 1), cas.CaseStartDateTime) AS FrameStartDateTime
			 , CASE WHEN DATEADD(MILLISECOND, -250, DATEADD(MINUTE, 10*num.n, cas.CaseStartDateTime)) > CaseEndDateTime THEN CaseEndDateTime ELSE DATEADD(MILLISECOND, -250, DATEADD(MINUTE, 10*num.n, cas.CaseStartDateTime)) END AS FrameEndDateTime
		FROM dbo.tKlsCase cas
			CROSS APPLY Nums num
		WHERE cas.CaseID = @CaseID)
	
		INSERT INTO [ana].[tKlsFrame10Min]
			   ([CaseID]
			   ,[CaseFrameSeqID]
			   ,[Duration]
			   ,[FrameStartDateTime]
			   ,[FrameEndDateTime]
			   ,[FHRBaselineBPM]
			   ,[FHRVariabilityBPM]
			   ,[NumFHRAccelerations]
			   ,[FHRThreshold]
			   ,[UABaseline]
			   ,[NumContractions]
			   ,[AvgTimePerContractionSec]
			   ,[TotalTimeContractionSec]
			   ,[TotalTimeRelaxationSec]
			   ,[URRatio]
			   ,[UAThreshold]
			   ,[NumFHRLateRecovery]
			   ,[NumFHROvershoot]
			   ,[bTachycardia]
			   ,[bBradycardia]
			   ,[bMaternalRiskFactor]
			   ,[bFetalRiskFactor]
			   ,[bObstetricalRiskFactor]
			   ,[bTerminalEvent]
			   ,[FRIExcessiveUA]
			   ,[FRIAccelerations]
			   ,[FRIFhrBaseline]
			   ,[FRIFhrVariability]
			   ,[FRILateRecovery]
			   ,[FRIMaternalRiskFactor]
			   ,[FRIObstetricalRiskFactor]
			   ,[FRIFetalRiskFactor]
			   ,[FRI]
			   ,[m_ExecutionDt])
		  SELECT CaseID
			 , CaseFrameSeqID
			 , RIGHT('00' + CAST(FLOOR(Seconds / 86400) AS VARCHAR(10)), 2) +':' + CONVERT(VARCHAR(5), DATEADD(SECOND, Seconds, '19000101'), 8)+':00' AS Duration 
			 , FrameStartDateTime
			 , FrameEndDateTime
			 , 0 -- FHRBaselineBPM
			 , 0 -- FHRVariabilityBPM
			 , 0 -- NumFHRAccelerations
			 , 0 -- FHRThreshold
			 , 0 -- UABaseline
			 , 0 -- NumContractions
			 , 0 -- Average time per contraction
			 , 0 -- ContractionTime
			 , 0 -- RelaxationTime
			 , 0 -- URRatio
			 , 0 -- UAThreshold
			 , 0 -- Late recovery
			 , 0 -- overshoot
			 , 0 -- tachycardia
			 , 0 -- bradycardia
			 , 0 -- maternal risk factor
			 , 0 -- fetal risk factor
			 , 0 -- Obstetrical fisk factor
			 , 0 -- terminal event
			 , 0 -- FHRExcessiveUA
			 , 0 -- FHRaccelerations
			 , 0 -- FHRbaseline
			 , 0 -- FHRvariability
			 , 0 -- FHRLateRecovery
			 , 0 -- FHRMaternalRiskFactor
			 , 0 -- FHRObstetricalRiskFactor
			 , 0 -- FHRFetalRiskFactor
			 , 0.000 -- FRI
			 , GETDATE()
			FROM Frames f
			WHERE FrameEndDateTime <= CaseEndDateTime
			AND FrameStartDateTime < CaseEndDateTime
END