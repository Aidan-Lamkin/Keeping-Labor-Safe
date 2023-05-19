PRINT 'Starting metric source reference table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tMetricSource)
BEGIN

INSERT INTO ref.tMetricSource (MetricSourceKey, MetricSourceName, MetricSourceDescription)
VALUES ('No-Trans', 'No measurement transmitted', 'No measurements transmitted'),
('FECG', 'Fetal Electrocardiogram', 'Measurements obtained from fetal electrocardiogram'),
('external', 'External Source', 'Measurements obtained from an external source'),
('INOP', 'Inoperative', 'Measurements obtained from inoperative source (not trustworthy)'),
('TOCO', 'Tocodynamometer', 'Measurements obtained from tocodynamometer'),
('IUP', 'Intrauterine Pressure Catheter', 'Measurements obtained from intrauterine pressure catheter');

END

PRINT 'Finished metric source reference table initialization.'