


/* Calculates FRI by case frame using the individual unique ID and the custom FRI calculation function */

CREATE PROCEDURE [ana].[uspCalculateFRIByCaseFrame] @Id INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @InputTable ana.TypeFRIVariableTable;
	INSERT INTO @InputTable
	SELECT cast(VariableKey AS VARCHAR(128)) AS VariableKey, VariableValue
	FROM (SELECT Id
			   , CaseID
			   , CaseFrameSeqID
			   , CAST(NumContractions AS DECIMAL(6,3)) AS NumContractions
			   , CAST(FHRBaselineBPM AS DECIMAL(6,3)) AS FHRBaselineBPM
			   , CAST(FHRVariabilityBPM AS DECIMAL(6,3)) as FHRVariabilityBPM
			   , CAST(NumFHRAccelerations AS DECIMAL(6,3))AS NumFHRAccelerations
			   , CAST(NumFHRLateRecovery AS DECIMAL(6,3)) AS NumFHRLateRecovery
			   , CAST(bMaternalRiskFactor AS DECIMAL(6,3)) AS bMaternalRiskFactor
			   , CAST(bFetalRiskFactor AS DECIMAL(6,3)) AS bFetalRiskFactor
			   , CAST(bObstetricalRiskFactor AS DECIMAL(6,3)) AS bObstetricalRiskFactor
		  FROM ana.tKlsFrame10Min
		  WHERE Id = @Id) as cp
	UNPIVOT 
	(
		VariableValue FOR VariableKey IN (NumContractions, FHRBaselineBPM, FHRVariabilityBPM, NumFHRAccelerations, NumFHRLateRecovery, bMaternalRiskFactor, bFetalRiskFactor, bObstetricalRiskFactor)
	) as up 

	DECLARE @NumValidVariables INT = (SELECT COUNT(DISTINCT vbl.VariableKey)
				FROM cfg.tFRIVariable vbl
					LEFT JOIN @InputTable ipt
						ON ipt.VariableKey = vbl.VariableKey
				WHERE ipt.VariableKey IS NOT NULL)

	IF (@NumValidVariables = 8)  -- require all 8 component variables to continue - otherwise return -1
	BEGIN
		DECLARE @OutputTable ana.TypeFRIVariableTable;
		INSERT INTO @OutputTable 
		SELECT ipt.VariableKey
			 , CASE WHEN ipt.VariableValue BETWEEN vbl.ThresholdMin AND vbl.ThresholdMax THEN 1 ELSE 0 END * vbl.ComponentScoreWeight AS VariableValue
		FROM @InputTable ipt
			LEFT JOIN cfg.tFRIVariable vbl
				ON ipt.VariableKey = vbl.VariableKey

		/* SET Quality flag */ 
		DECLARE @IsQuality BIT = (SELECT CASE WHEN VariableValue > 0 THEN 1 ELSE 0 END FROM @InputTable WHERE VariableKey = 'FHRBaselineBPM');

		--UPDATE ana.tKlsFrame10Min SET IsQuality = @IsQuality WHERE Id = @Id;

		--IF (@IsQuality = 1)
		--BEGIN 

			/* Update final components */

			UPDATE ana.tKlsFrame10Min SET FRIExcessiveUA = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'NumContractions') WHERE Id = @Id; -- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRIFhrBaseline = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'FHRBaselineBPM') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRIAccelerations = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'NumFHRAccelerations') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRIFhrVariability = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'FHRVariabilityBPM') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRIMaternalRiskFactor = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'bMaternalRiskFactor') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRIObstetricalRiskFactor = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'bObstetricalRiskFactor') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRILateRecovery = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'NumFHRLateRecovery') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET FRIFetalRiskFactor = (SELECT VariableValue FROM @OutputTable WHERE VariableKey = 'bFetalRiskFactor') WHERE Id = @Id;-- FRI Component score now (reusing variable key)
			UPDATE ana.tKlsFrame10Min SET m_ExecutionDt = GETUTCDATE() WHERE Id = @Id;

			UPDATE ana.tKlsFrame10Min SET FRI = (SELECT SUM(VariableValue) FROM @OutputTable) WHERE Id = @Id;
		--END
	END
	
END