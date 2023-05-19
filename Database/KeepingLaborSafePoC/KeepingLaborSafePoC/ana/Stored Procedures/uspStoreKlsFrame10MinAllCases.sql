
CREATE PROCEDURE [ana].[uspStoreKlsFrame10MinAllCases] @IsRedigestion INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT DISTINCT CaseId
	INTO #CaseIds
	FROM dbo.tKlsCase 
	WHERE m_IsEnabled = 1
		--AND (CaseID > (SELECT MAX(CaseID) FROM ana.tKlsFrame10Min)
		OR @IsRedigestion = 1
		--)


	DECLARE @CurrentCase INT;
	DECLARE Curs CURSOR FOR (SELECT CaseID FROM #CaseIds)
	OPEN Curs
	FETCH NEXT FROM Curs INTO @CurrentCase
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @Message varchar(200) = 'Storing KLS 10-min frame data for case '  + CAST(@CurrentCase as varchar) + ':' + CAST(GETDATE() AS VARCHAR(128)) + '...'
		RAISERROR(@Message, 0, 1) WITH NOWAIT
		EXEC ana.uspStoreKlsFrame10MinByCaseID @CurrentCase
		FETCH NEXT FROM Curs INTO @CurrentCase
	END
	CLOSE curs
	DEALLOCATE curs

	DROP TABLE #CaseIds 
END