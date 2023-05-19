
CREATE procedure [ana].[uspCalculateFRIAllCases] @StartCaseID INT, @EndCaseID INT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Msg varchar(500) = 'Starting FRI Calculation for cases ' + CAST(@StartCaseID AS VARCHAR(128)) + ' to ' + CAST(@EndCaseID AS VARCHAR(128)) + '...'
	RAISERROR(@Msg, 0, 1) WITH NOWAIT
	DECLARE @CurrentCaseID INT;
	DECLARE Curs1 CURSOR FOR SELECT DISTINCT CaseID FROM dbo.tKlsCase WHERE CaseID BETWEEN @StartCaseID AND @EndCaseID AND m_IsEnabled = 1
	OPEN Curs1
	FETCH NEXT FROM Curs1 INTO @CurrentCaseID
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @Msg = 'Calculating FRI frames for case ' + CAST(@CurrentCaseID AS VARCHAR(128)) + '...'
		RAISERROR(@Msg, 0, 1) WITH NOWAIT
		EXEC ana.uspCalculateFRIFramesByCaseID @CurrentCaseID
		FETCH NEXT FROM Curs1 INTO @CurrentCaseID
	END
	CLOSE Curs1
	DEALLOCATE Curs1
	SET @Msg = 'Finished FRI Calculation for cases ' + CAST(@StartCaseID AS VARCHAR(128)) + ' to ' + CAST(@EndCaseID AS VARCHAR(128)) + '...'
	RAISERROR(@Msg, 0, 1) WITH NOWAIT
END