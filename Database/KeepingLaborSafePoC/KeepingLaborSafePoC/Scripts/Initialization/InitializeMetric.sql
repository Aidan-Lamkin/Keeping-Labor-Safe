PRINT 'Starting metric reference table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tMetric)
BEGIN

	INSERT INTO ref.tMetric (MetricKey, MetricName, MetricDescription)
	VALUES ('UA', 'Uterine Activity', 'Uterine Contraction Strength'),
	('HR2', 'Fetal Heart Rate 2', 'Secondary Measurement of Fetal Heart Rate (BPM)'),
	('MHR', 'Maternal Heart Rate', 'Measurement of Maternal Heart Rate (BPM)'),
	('HR1', 'Fetal Heart Rate 1', 'Primary Measurement of Fetal Heart Rate (BPM)')

END

PRINT 'Finished metric reference table initialization.'