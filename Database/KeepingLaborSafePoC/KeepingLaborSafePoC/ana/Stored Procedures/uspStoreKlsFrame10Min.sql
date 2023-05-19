/* Major prodecure that decomposes a case into 10-minute frames for FRI analysis and stores the results in a separate table. It will also retroactively update 
	the case frame IDs in the Pivot table if that table was already populated */

CREATE PROCEDURE [ana].[uspStoreKlsFrame10Min]
AS
BEGIN

SET NOCOUNT ON;

;WITH Nums AS
(
/* Generate IDs for case frames. This could break down depending on the max size of all_Objects. Generally we assume that a case doesn't have more than a couple hundred 10-minute frames */

  SELECT n = ROW_NUMBER() OVER (ORDER BY [object_id]) 
  FROM sys.all_objects 

),
Frames AS (
/* Generate start/end dates for 10-minute frames */
SELECT cas.CaseID
	 , ROW_NUMBER() OVER (PARTITION BY CaseID ORDER BY (SELECT 1)) AS CaseFrameSeqID
	 , cas.CaseStartDateTime
	 , cas.CaseEndDateTime
	 , DATEADD(MINUTE, 10*(num.n - 1), cas.CaseStartDateTime) AS FrameStartDateTime
	 , CASE WHEN DATEADD(MILLISECOND, -250, DATEADD(MINUTE, 10*num.n, cas.CaseStartDateTime)) > CaseEndDateTime THEN CaseEndDateTime ELSE DATEADD(MILLISECOND, -250, DATEADD(MINUTE, 10*num.n, cas.CaseStartDateTime)) END AS FrameEndDateTime
FROM dbo.tKlsCase cas
	CROSS APPLY Nums num )
	
/* Insert data into frame table */
	INSERT INTO [ana].[tKlsFrame10Min]
           ([CaseID]
           ,[CaseFrameSeqID]
           ,[FrameStartDateTime]
           ,[FrameEndDateTime]
		   ,[Duration]
           ,[FHRBaselineBPM]
           ,[FHRVariabilityBPM]
           ,[NumFHRAccelerations]
           ,[UABaseline]
           ,[NumContractions]
           ,[AvgTimePerContractionSec]
           ,[TotalTimeContractionSec]
           ,[TotalTimeRelaxationSec]
           ,[URRatio]
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
           ,[FRI])
	  SELECT CaseID
	     , CaseFrameSeqID
		 , FrameStartDateTime
		 , FrameEndDateTime
		 ,RIGHT('0' + CONVERT(varchar(4),DATEDIFF(minute,[CaseStartDateTime], [FrameEndDateTime])/60),2) + ':' +
			RIGHT('0' + CONVERT(varchar(2),DATEDIFF(minute,[CaseStartDateTime], [FrameEndDateTime])%60),2) + ':' + 
			RIGHT('0' + CONVERT(varchar(2),(DATEDIFF(second,[CaseStartDateTime], [FrameEndDateTime]) + 1)%60), 2)
		 , 0 -- FHRBaselineBPM
		 , 0 -- FHRVariabilityBPM
		 , 0 -- NumFHRAccelerations
		 , 0 -- UABaseline
		 , 0 -- NumContractions
		 , 0 -- Average time per contraction
		 , 0 -- ContractionTime
		 , 0 -- RelaxationTime
		 , 0 -- URRatio
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
		FROM Frames f
		WHERE FrameEndDateTime <= CaseEndDateTime
		AND FrameStartDateTime < CaseEndDateTime


		/* Retroactively update CaseFrameID in Sample_Pivot table */ 
	
		DECLARE @CurrentCaseID INT;
		DECLARE CaseCur CURSOR FOR SELECT DISTINCT CaseID FROM dbo.tKlsCase ORDER BY CaseID 
		OPEN CaseCur;
		FETCH NEXT FROM CaseCur INTO @CurrentCaseID; 
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @FirstCaseFrameSeqID INT = (SELECT TOP 1 CaseFrameSeqID FROM app.tKlsSample_Pivot WHERE CaseID = @CurrentCaseID);
			IF @FirstCaseFrameSeqID = 0 OR @FirstCaseFrameSeqID IS NULL 
				BEGIN
				UPDATE piv 
				SET CaseFrameSeqID = frm.CaseFrameSeqID
				FROM app.tKlsSample_Pivot piv
					INNER JOIN ana.tKlsFrame10Min frm
						ON piv.SampleDateTime BETWEEN frm.FrameStartDateTime AND frm.FrameEndDateTime
				WHERE piv.CaseID = @CurrentCaseID
			END
			FETCH NEXT FROM CaseCur INTO @CurrentCaseID
		END
		CLOSE CaseCur;
		DEALLOCATE CaseCur;
END