CREATE PROC [dbo].[uspStoreKlsSamplePivotByCase_Merge] 
	@CaseID INT
AS
BEGIN
	
	SET NOCOUNT ON;
	
	MERGE app.tKlsSample_Pivot AS tar
	USING (SELECT * FROM app.vwSample_Pivot WHERE CaseID = @CaseID) AS src
		ON tar.CaseID = src.CaseID
			AND tar.SeqID = src.SeqID
	WHEN MATCHED THEN UPDATE SET 
		CaseFrameSeqID = src.CaseFrameSeqID
	  , SampleDateTime = src.SampleDateTime
	  , UA = src.UA
	  , HR = src.HR
	  , HR2 = src.HR2
	  , MHR = src.MHR
	  , m_ExecutionDT = GETUTCDATE()
	WHEN NOT MATCHED THEN INSERT 
	(
		CaseID
	  , CaseFrameSeqID
	  , SeqID
	  , SampleDateTime
	  , UA
	  , HR
	  , HR2
	  , MHR
	  , m_ExecutionDt
	)
	VALUES 
	(
		src.CaseID
	  , src.CaseFrameSeqID
	  , src.SeqID
	  , src.SampleDateTime
	  , src.UA
	  , src.HR
	  , src.HR2
	  , src.MHR
	  , GETUTCDATE()
	);

END