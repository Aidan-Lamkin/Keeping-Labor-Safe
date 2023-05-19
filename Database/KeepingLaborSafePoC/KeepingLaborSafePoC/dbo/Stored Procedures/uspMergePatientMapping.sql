CREATE PROCEDURE dbo.uspMergePatientMapping 
AS
BEGIN
	MERGE dbo.tPatientMapping AS t
	USING stg.vwPatientMapping AS s
		ON t.MRN = s.MRN
			AND t.INPATIENT_DATA_ID = s.INPATIENT_DATA_ID
	WHEN MATCHED AND s.m_ExecutionDt > t.m_ExecutionDt THEN UPDATE SET 
		[File] = s.[File]
	  , Mother_Admit_Tm = s.Mother_Admit_Tm
	  , DELIVERY_TIME = s.DELIVERY_TIME
	  , [GUID] = s.[GUID]
	  , INPATIENT_DATA_ID = s.INPATIENT_DATA_ID
	  , [filename] = s.[filename]
	  , m_ExecutionDt = GETUTCDATE()
	WHEN NOT MATCHED THEN INSERT 
	(
		MRN
	  , [File]
	  , Mother_Admit_Tm
	  , DELIVERY_TIME
	  , [GUID]
	  , INPATIENT_DATA_ID
	  , [filename]
	  , m_ExecutionDt 
	)
	VALUES 
	(
		s.MRN
	  , s.[File]
	  , s.Mother_Admit_Tm
	  , s.DELIVERY_TIME
	  , s.[GUID]
	  , s.INPATIENT_DATA_ID
	  , s.[filename]
	  , GETUTCDATE()
	);
END