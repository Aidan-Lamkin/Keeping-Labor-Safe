
/* DEPRECATED (from Phase 1) */

/* Truncate staging table (called from DataFactory pipeline) */

CREATE PROCEDURE [dep].[uspTruncateSampleDataStgTable]
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRAN;
		TRUNCATE TABLE stg.tKlsInput; 
	COMMIT;
END