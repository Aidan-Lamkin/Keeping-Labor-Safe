CREATE PROCEDURE ana.uspSelectAllRiskFactors
AS 

	DECLARE @Query VARCHAR(MAX) = 'SELECT arf.CaseID, FrameStartDateTime, FrameEndDateTime '
	SELECT @Query += ',	MAX(CASE WHEN frm.FrameStartDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') OR frm.FrameEndDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') THEN 1 ELSE 0 END) AS ' + RiskFactorKey
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal datetime Risk Factors
		AND DataType = 'DATETIME2(0)'
	SELECT @Query += ',	MAX(CASE WHEN frm.FrameStartDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') OR frm.FrameEndDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') THEN 1 ELSE 0 END) AS ' + RiskFactorKey
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical datetime Risk Factors
		AND DataType = 'DATETIME2(0)'
	SELECT @Query += ',	MAX(CASE WHEN frm.FrameStartDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') OR frm.FrameEndDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') THEN 1 ELSE 0 END) AS ' + RiskFactorKey
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal datetime Risk Factors
		AND DataType = 'DATETIME2(0)'
	SELECT @Query += ' , MAX(CASE '
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
	SELECT @Query += ' ELSE 0 END) AS FetalRF FROM dbo.vwAllRiskFactors arf LEFT JOIN ana.tKlsFrame10Min frm ON arf.CaseID = frm.CaseID WHERE arf.CaseID IN (SELECT CaseID FROM dbo.tKlsCase WHERE m_IsEnabled = 1) GROUP BY arf.CaseID, FrameStartDateTime, FrameEndDateTime '

	PRINT @Query

	EXEC(@Query)