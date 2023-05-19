PRINT 'Starting config FRI variable table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM cfg.tFRIVariable)
BEGIN
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (1, N'NumContractions', 4, CAST(0.000 AS Decimal(8, 3)), CAST(4.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Number of contractions should be in this range per 10-minute frame')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (2, N'FHRBaselineBPM', 1, CAST(110.000 AS Decimal(8, 3)), CAST(159.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Baseline FHR should be in this range')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (3, N'FHRVariabilityBPM', 1, CAST(3.000 AS Decimal(8, 3)), CAST(15.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Variability should be in this range for a FRI component score of 1')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (4, N'NumFHRAccelerations', 1, CAST(1.000 AS Decimal(8, 3)), CAST(999.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Accelerations should be present and in this range')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (5, N'NumFHRLateRecovery', 5, CAST(0.000 AS Decimal(8, 3)), CAST(0.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Late recovery should not be present')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (6, N'bMaternalRiskFactor', 5, CAST(1.000 AS Decimal(8, 3)), CAST(1.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Maternal risk factor(s) should not be present')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (7, N'bFetalRiskFactor', 5, CAST(1.000 AS Decimal(8, 3)), CAST(1.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Fetal risk factor(s) should not be present')
    GO
    INSERT [cfg].[tFRIVariable] ([VariableID], [VariableKey], [MetricUnitID], [ThresholdMin], [ThresholdMax], [ComponentScoreWeight], [VariableDescription]) VALUES (8, N'bObstetricalRiskFactor', 5, CAST(1.000 AS Decimal(8, 3)), CAST(1.000 AS Decimal(8, 3)), CAST(0.125 AS Decimal(8, 3)), N'Obstetrical risk factor(s) should not be present')
    GO
END

PRINT 'Finished config FRI variable table initialization.'