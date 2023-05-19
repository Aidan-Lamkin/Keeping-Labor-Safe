


CREATE procedure [ana].[uspCalculateDataQualityAllCases]
	@IsRedigestion BIT,
	@QualityPercentage DECIMAL(6,3),
	@MaxSampleCount INT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @CurrentCaseID INT;
	DECLARE Curs1 CURSOR FOR SELECT DISTINCT CaseID FROM dbo.tKlsCase WHERE m_IsEnabled = 1 OR @IsRedigestion = 1
	OPEN Curs1
	FETCH NEXT FROM Curs1 INTO @CurrentCaseID
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @Msg VARCHAR(2500) = 'Calculating data quality for case ' + CAST(@CurrentCaseID AS VARCHAR(128)) + '...'
		RAISERROR(@Msg, 0, 1) WITH NOWAIT
		EXEC ana.uspCalculateDataQualityByCaseID @CurrentCaseID, @QualityPercentage, @MaxSampleCount
		FETCH NEXT FROM Curs1 INTO @CurrentCaseID
	END
	CLOSE Curs1
	DEALLOCATE Curs1
END