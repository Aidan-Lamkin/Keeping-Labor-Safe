CREATE PROCEDURE ana.uspStoreCaseMilestones
AS
BEGIN

	MERGE dbo.tKlsCaseMilestone AS trg
	USING (
		SELECT cm.CaseID
			, mst.MilestoneID
			, CAST(cm.MilestoneValue AS DATETIME2(2)) AS MilestoneDateTime
		FROM dbo.vwCaseMilestones cm
		INNER JOIN ref.tMilestone mst
			ON cm.MilestoneKey = mst.MilestoneKey) AS src
		ON trg.CaseID = src.CaseID
			AND trg.MilestoneID = src.MilestoneID
	WHEN MATCHED AND src.MilestoneDateTime <> trg.MilestoneDateTime THEN UPDATE SET 
		trg.MilestoneDateTime = src.MilestoneDateTime
	  , trg.m_ExecutionDt = GETUTCDATE() 
	WHEN NOT MATCHED THEN INSERT (
		CaseID
	  , MilestoneID
	  , MilestoneDateTime
	  , m_ExecutionDt)
	VALUES 
	(
		src.CaseID
	  , src.MilestoneID
	  , src.MilestoneDateTime
	  , GETUTCDATE());

END