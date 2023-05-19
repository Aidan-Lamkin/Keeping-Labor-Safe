PRINT 'Starting metric unit reference table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tMetricUnit)
BEGIN

	INSERT INTO ref.tMetricUnit (MetricUnitKey, MetricUnitName, MetricUnitDescription)
	VALUES ('BPM', 'Beats Per Minute', 'Beats Per Minute (Heart Rate)'),
	('MMHG', 'Millimeter of Mercury', 'Amount of pressure it takes to raise a column of mercury one millimeter'),
	('MVU', 'Montevideo Unit', 'Sum of the intensity of each contraction in a 10 minute period (in mmHG)')

END

PRINT 'Finished metric unit reference table initialization.'