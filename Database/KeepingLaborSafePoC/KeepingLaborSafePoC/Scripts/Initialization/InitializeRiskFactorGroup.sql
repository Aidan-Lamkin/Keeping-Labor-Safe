PRINT 'Starting risk factor group reference table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tRiskFactorGroup)
BEGIN


	INSERT INTO ref.tRiskFactorGroup (RiskFactorGroupKey, RiskFactorGroupName, RiskFactorGroupDescription, IsActive, m_ExecutionDt) 
	VALUES ('Maternal', 'Maternal Risk Factors', 'Maternal Risk Factors', 1, getdate()),
		   ('Obstetrical', 'Obstetrical Risk Factors', 'Obstetrical Risk Factors', 1, getdate()),
		   ('Fetal', 'Fetal Risk Factors', 'Fetal Risk Factors', 1, getdate());

END

PRINT 'Finished risk factor group reference table initialization.'
