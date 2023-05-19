/* Wrapper proc intended to allow for recalculation of FRI scores for a specific Case ID */
CREATE PROCEDURE [ana].[uspCalculateFRIFramesByCaseID] @CaseID INT 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CurrentID INT;

	DECLARE Curs CURSOR FOR SELECT Id FROM ana.tKlsFrame10Min WHERE CaseID = @CaseID ORDER BY Id; 
	OPEN CURS
	FETCH NEXT FROM Curs INTO @CurrentId
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXEC ana.uspCalculateFRIByCaseFrame @CurrentId
		FETCH NEXT FROM Curs INTO @CurrentId
	END
	CLOSE CURS;
	DEALLOCATE CURS;

END