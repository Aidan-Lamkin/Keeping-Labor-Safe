PRINT 'Starting risk factor type reference table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tRiskFactorGroup)
BEGIN


	INSERT INTO ref.tRiskFactorType (RiskFactorTypeKey, RiskFactorTypeName, RiskFactorTypeDescription, m_ExecutionDt)
	VALUES ('Chronic', 'Chronic Risk Factor - Condition', 'Risk factor will not change during the labor process (chronic condition)', getdate()),
		   ('Dynamic', 'Dynamic Risk Factor', 'Risk factor may change during the labor process', getdate()),
		   ('Unidirectional', 'Unidirectional Risk Factor - Event', 'Risk factor may change during labor but will not reverse value', getdate()),
		   ('Quantitative', 'Quantitative Risk Factor - Measurement', 'Risk factor is a quantitative value (i.e., measured at admission and will not change during labor)', getdate())

END

PRINT 'Finished risk factor type reference table initialization.'
