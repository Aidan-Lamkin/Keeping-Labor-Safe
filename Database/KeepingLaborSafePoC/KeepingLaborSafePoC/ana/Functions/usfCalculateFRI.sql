
/* DEPRECATED - Removed because the custom table type was not flexible enough and required too much extra manipulation and row-by-row execution */
/* Function created to calculate FRI based on an Input custom table type containing FRI Variables and input values */

CREATE FUNCTION ana.usfCalculateFRI
(
	@InputTable ana.TypeFRIVariableTable READONLY
)
RETURNS DECIMAL(6,3)
AS
BEGIN

	/* Check to make sure the number of distinct required variables exists in the input table */ 
	/* This step may need to be changed or removed, because it can result in a false positive even if no new FRI scores are stored */
	DECLARE @NumValidVariables INT = (SELECT COUNT(DISTINCT vbl.VariableKey)
				  FROM cfg.tFRIVariable vbl
					  LEFT JOIN @InputTable ipt
						  ON ipt.VariableKey = vbl.VariableKey
				  WHERE ipt.VariableKey IS NOT NULL)

	DECLARE @FRIScore DECIMAL(6,3) = -1.00;

	IF (@NumValidVariables = 8)  -- require all 8 component variables to continue - otherwise return -1
	BEGIN
		SET @FRIScore = 
		(SELECT SUM(CASE WHEN ipt.VariableValue BETWEEN vbl.ThresholdMin AND vbl.ThresholdMax THEN 1 ELSE 0 END * vbl.ComponentScoreWeight) / 8.0
		FROM @InputTable ipt
			LEFT JOIN cfg.tFRIVariable vbl
				ON ipt.VariableKey = vbl.VariableKey)
	END

	/* ELSE Throw Exception? Log error somewhere? */

	RETURN @FRIScore;
END