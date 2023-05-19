

/* Truncate staging table (called from DataFactory pipeline) */

CREATE PROCEDURE [stg].[uspTruncateSampleDataStgTableDataflow]
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRAN;
		TRUNCATE TABLE stg.tKlsInputDataflow; 
	COMMIT;
END