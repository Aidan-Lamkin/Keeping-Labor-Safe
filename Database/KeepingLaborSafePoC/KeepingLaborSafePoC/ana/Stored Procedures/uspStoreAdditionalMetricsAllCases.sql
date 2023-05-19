CREATE PROCEDURE [ana].[uspStoreAdditionalMetricsAllCases] @IsRedigestion BIT
AS 
BEGIN
	SET ANSI_WARNINGS OFF;
	SET NOCOUNT ON;

	DECLARE @Msg VARCHAR(2500) = 'Starting storage of additional metrics for all cases...'
	RAISERROR(@Msg, 0, 1) WITH NOWAIT
	DECLARE @CurrentCaseID INT;
	DECLARE Curs2 CURSOR FOR SELECT DISTINCT CaseID FROM dbo.tKlsCase WHERE m_IsEnabled = 1	OR @IsRedigestion = 1
	OPEN Curs2
	FETCH NEXT FROM Curs2 INTO @CurrentCaseID
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @Msg = 'Storing metrics for CaseID ' + CAST(@CurrentCaseID AS VARCHAR(128)) + '...'
		RAISERROR(@Msg, 0, 1) WITH NOWAIT
		EXEC ana.uspStoreAdditionalMetrics @CurrentCaseID
		FETCH NEXT FROM Curs2 INTO @CurrentCaseID
	END
	CLOSE Curs2
	DEALLOCATE Curs2
END