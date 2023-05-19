
/* Wrapper proc that calls an inner proc to store pivoted sample data by case */

CREATE PROC [dbo].[uspStoreKlsSamplePivotAllCases] @IsRedigestion INT
AS
BEGIN
	
	SET NOCOUNT ON; 

	SELECT DISTINCT CaseId
	INTO #SamplePivotCaseIds
	FROM dbo.tKlsCase 
	WHERE --(
			--CaseID > (SELECT MAX(CaseID) 
					--FROM app.tKlsSample_Pivot) 
			--AND 
			m_IsEnabled = 1
			--)
		OR @IsRedigestion = 1

	DECLARE @CurrentCase int;
	DECLARE Curs CURSOR FOR (SELECT CaseID FROM #SamplePivotCaseIds)
	OPEN Curs
	FETCH NEXT FROM Curs INTO @CurrentCase
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXEC dbo.uspStoreKlsSamplePivotByCase @CurrentCase
		FETCH NEXT FROM Curs INTO @CurrentCase
	END
	CLOSE curs
	DEALLOCATE curs

	DROP TABLE #SamplePivotCaseIds
END