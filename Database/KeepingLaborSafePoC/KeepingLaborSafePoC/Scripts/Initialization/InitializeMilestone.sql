PRINT 'Starting reference milestone table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tMilestone)
BEGIN

	INSERT INTO ref.tMilestone(MilestoneKey, MilestoneName, RiskFactorID, IsActive, m_ExecutionDt)
	VALUES 
		   ('LaborStart', 'Beginning of Labor', NULL, 1, getdate()),
		   ('Epidural', 'Epidural', NULL, 1, getdate()),
		   ('IR', 'Intrauterine Resuscitation', 34, 1, getdate()),
		   ('Stage2Start', 'Beginning of Stage 2 Labor', 36, 1, getdate()),
		   ('Stage2End', 'End of Stage 2 Labor', NULL, 1, getdate()),
		   ('Delivery', 'Delivery', NULL, 1, getdate())

END

PRINT 'Finished reference milestone table initialization.'