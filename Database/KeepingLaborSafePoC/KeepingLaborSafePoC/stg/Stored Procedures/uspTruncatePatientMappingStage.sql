CREATE PROCEDURE stg.uspTruncatePatientMappingStage
AS
BEGIN
	TRUNCATE TABLE stg.tPatientMapping;
END