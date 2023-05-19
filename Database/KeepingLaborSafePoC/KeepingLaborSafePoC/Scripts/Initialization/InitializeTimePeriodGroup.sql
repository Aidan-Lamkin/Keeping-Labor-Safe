PRINT 'Starting reference time period group table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tTimePeriodGroup)
BEGIN

	INSERT INTO ref.tTimePeriodGroup (TimePeriodGroupKey, TimePeriodGroupName, TimePeriodGroupDescription, m_ExecutionDt)
	VALUES ('AbnormalHours', 'AbnormalHours', 'Used for abnormal hour calculation by case', getdate()),
		   ('FRIStats', 'FRIStats', 'Used for FRI stat calculation by case (Low FRI, Last FRI, Prior Stage 2 FRI)', getdate());
END

PRINT 'Finished reference time period group table initialization.'