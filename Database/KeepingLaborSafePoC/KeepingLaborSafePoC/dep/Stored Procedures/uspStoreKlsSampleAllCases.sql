

/* DEPRECATED */ 
/* No longer need both app.tKlsSample - only app.tKlsSample_Pivot for scoring */

/* Wrapper proc that iterates through each Case and calls an inner proc to store all sample data for a case */

CREATE PROC [dep].[uspStoreKlsSampleAllCases] @IsRedigestion INT
AS
BEGIN
	
	SET NOCOUNT ON; 

	SELECT DISTINCT CaseId
	INTO #SampleCaseIds
	FROM dbo.tKlsCase 
	WHERE --(
			--CaseID > (SELECT MAX(CaseID) 
			--		FROM app.tKlsSample) 
			--AND 
			m_IsEnabled = 1
			--)
		OR @IsRedigestion = 1

	DECLARE @CurrentCase int;
	DECLARE Curs CURSOR FOR (SELECT CaseID FROM #SampleCaseIds)
	OPEN Curs
	FETCH NEXT FROM Curs INTO @CurrentCase
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXEC dbo.uspStoreKlsSampleByCase @CurrentCase
		FETCH NEXT FROM Curs INTO @CurrentCase
	END
	CLOSE curs
	DEALLOCATE curs

	DROP TABLE #SampleCaseIds
END