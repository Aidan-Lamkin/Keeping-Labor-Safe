PRINT 'Starting reference time period table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tTimePeriod)
BEGIN

	INSERT INTO ref.tTimePeriod (TimePeriodKey, TimePeriodName, TimePeriodGroupID, StartMilestoneID, EndMilestoneID, IsActive)
	VALUES ('AbnormalHours', 'Abnormal Hours', 1, 1, 6, 1),
		   ('EpiduralToDelivery', 'Epidural To Delivery', 1, 2, 6, 1),
		   ('IrToDelivery', 'IR to Delivery', 1, 3, 6, 1),
		   ('Stage2', 'Second Stage of Labor', 2, 4, 5, 1);
END

PRINT 'Finished reference time period table initialization.'