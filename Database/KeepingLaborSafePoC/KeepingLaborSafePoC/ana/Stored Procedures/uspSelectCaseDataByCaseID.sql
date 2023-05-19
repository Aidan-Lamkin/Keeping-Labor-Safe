/* Select procedure to bring FRI scores by 10-minute increments as well as additional metrics */

CREATE PROCEDURE [ana].[uspSelectCaseDataByCaseID] @CaseID INT 
AS
BEGIN
	SET NOCOUNT ON;

	EXEC ana.uspSelectAdditionalMetrics @CaseID

	SELECT *
	FROM ana.tKlsFrame10Min 
	WHERE CaseID = @CaseID
	ORDER BY CaseFrameSeqID

	SELECT mil.CaseID, ms.MilestoneName, mil.MilestoneDateTime
	FROM dbo.tKlsCaseMilestone mil
		INNER JOIN ref.tMilestone ms
			ON mil.MilestoneID = ms.MilestoneID
	WHERE mil.CaseID = @CaseID
	ORDER BY mil.MilestoneDateTime
END