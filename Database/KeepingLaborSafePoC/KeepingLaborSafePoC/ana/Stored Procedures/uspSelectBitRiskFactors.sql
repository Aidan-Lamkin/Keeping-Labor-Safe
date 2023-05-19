CREATE PROCEDURE ana.uspSelectBitRiskFactors
AS 

	DECLARE @Query VARCHAR(MAX) = 'SELECT CaseID, MAX(CASE '
	SELECT @Query += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal non-datetime Risk Factors
		AND DataType <> 'DATETIME2(0)'
	SELECT @Query += ' ELSE 0 END) AS MaternalRF, MAX(CASE '
	SELECT @Query += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical non-datetime Risk Factors
		AND DataType <> 'DATETIME2(0)'
	SELECT @Query += ' ELSE 0 END) AS ObstetricalRF, MAX(CASE '
	SELECT @Query += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal BIT non-datetime Factors
		AND DataType <> 'DATETIME2(0)'
	SELECT @Query += ' ELSE 0 END) AS FetalRF FROM dbo.vwAllRiskFactors GROUP BY CaseID'

	PRINT @Query

	EXEC(@Query)