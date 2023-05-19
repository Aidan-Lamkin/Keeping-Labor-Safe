
CREATE PROCEDURE [ana].[uspCalculateDataQualityByCaseID] 
	@CaseID INT, 
	@QualityPercent DECIMAL(6,3),
	@MaxSampleCount INT
AS
BEGIN
	/* Set parameters for quality calculations */ 
	
	DECLARE @MinValidThreshold INT = @MaxSampleCount * @QualityPercent
	DECLARE @MaxInvalidThreshold INT = @MaxSampleCount * (1-@QualityPercent)

	DROP TABLE IF EXISTS #CaseData

	SELECT frm.CaseID, frm.CaseFrameSeqID, frm.FrameStartDateTime, frm.FrameEndDateTime, piv.SeqID, piv.SampleDateTime, piv.UA, piv.HR, piv.HR2, piv.MHR, piv.m_ExecutionDt
	INTO #CaseData 
	FROM ana.tKlsFrame10Min frm
		INNER JOIN app.tKlsSample_Pivot piv
			ON frm.CaseID = piv.CaseID
		AND piv.SampleDateTime BETWEEN frm.FrameStartDateTime AND frm.FrameEndDateTime
	WHERE frm.CaseID = @CaseID

	;WITH src AS (
	SELECT 
		   CaseID
		 , CaseFrameSeqID
		 , FrameStartDateTime
		 , SUM(CASE WHEN UA = 0 AND (HR2 = 0 OR HR2 IS NULL) THEN 1 ELSE 0 END) AS UAInvalidCount
		 , SUM(CASE WHEN HR2 = 0 OR HR2 IS NULL THEN 1 ELSE 0 END) AS HRInvalidCount
		 , COUNT(DISTINCT SampleDateTime) AS SampleCount
		 , SUM(CASE WHEN UA IS NULL OR HR2 IS NULL OR SampleDateTime IS NULL THEN 1 ELSE 0 END) AS NullCount
	FROM #CaseData
	GROUP BY CaseID, CaseFrameSeqID, FrameStartDateTime )
	UPDATE frm
		SET IsQuality = CASE WHEN UAInvalidCount >= @MaxInvalidThreshold OR HRInvalidCount >= @MaxInvalidThreshold OR SampleCount <= @MinValidThreshold OR NullCount > 0 THEN 0 ELSE 1 END
		  , m_ExecutionDt = GETUTCDATE()
	FROM src s
		INNER JOIN ana.tKlsFrame10Min frm
			ON s.CaseFrameSeqID = frm.CaseFrameSeqID
				AND s.CaseID = frm.CaseID
	WHERE CASE WHEN UAInvalidCount >= @MaxInvalidThreshold OR HRInvalidCount >= @MaxInvalidThreshold OR SampleCount <= @MinValidThreshold OR NullCount > 0 THEN 0 ELSE 1 END <> IsQuality

END