﻿PRINT 'Starting risk factor reference table initialization...'

IF NOT EXISTS (SELECT TOP 1 1 FROM ref.tRiskFactor)
BEGIN


    
    
    SET IDENTITY_INSERT [ref].[tRiskFactor] ON 
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (1, 4, 1, N'MATERNAL_RF_AGE', N'Maternal Age', N'Age of mother', N'DECIMAL', N'41.000', N'999.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'BETWEEN 41.000 AND 999.000', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (2, 4, 1, N'MATERNAL_RF_GRAVIDA', N'Gravidity', N'Number of past pregnancies', N'DECIMAL', N'0.000', N'999.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'BETWEEN 0.000 AND 999.000', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (3, 4, 1, N'MATERNAL_RF_PARITY', N'Parity', N'Number of past deliveries', N'DECIMAL', N'5.000', N'999.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'BETWEEN 5.000 AND 999.000', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (4, 4, 1, N'MATERNAL_RF_GEST_AGE', N'Gestational Age', N'Gestational Age', N'DECIMAL', N'36.010', N'39.990', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'<= 36.0 AND MATERNAL_RF_GEST_AGE >= 40.0', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (5, 1, 1, N'MATERNAL_RF_HTN_PRE_E', N'Pre-existing hypertension', N'Hypertension (Chronic and Pregnancy induced)', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (6, 1, 1, N'MATERNAL_RF_DIABETES', N'Pre-existing diabetes', N'Pre-existing diabetes', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (7, 1, 1, N'MATERNAL_RF_EPIDURAL', N'Epidural', N'Epidural anesthesia was administered', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (8, 1, 1, N'MATERNAL_RF_CARDIAC1', N'Cardiac Disease', N'Cardiac Disease with risk of decreased cardiac output in pregnancy', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (9, 1, 1, N'SLE', N'Systemic Lupus Erythematosus', N'Systemic Lupus Erythematosus', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (10, 1, 1, N'Anemia', N'Anemia', N'Anemia', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (11, 1, 1, N'MATERNAL_RF_PULMONARY1', N'Pulmonary Disorder', N'Pulminary Disorder (e.g. Asthma)', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (12, 4, 1, N'MATERNAL_RF_SHORT_STATURE', N'Short Stature', N'Short Stature (<= 62" (156 cm))', N'DECIMAL', N'0.000', N'62.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'BETWEEN 0.000 AND 62.000', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (13, 4, 1, N'MATERNAL_RF_OBESITY', N'Obesity', N'Obesity (BMI >= 35)', N'DECIMAL', N'35.000', N'999.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'BETWEEN 35.000 AND 999.000', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (14, 1, 1, N'DrugAbuse', N'Drug abuse/addiction', N'Drug abuse/addiction', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (15, 1, 1, N'Smoking', N'Smoking', N'Smoking', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (16, 1, 1, N'Malabsorption', N'Malabsorption', N'Malabsorption/ poor weight gain', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (17, 3, 2, N'OBSTETRICAL_RF_AROM_DT', N'Artifical Rupture Of Membranes', N'Artifical Rupture Of Membranes', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (18, 3, 2, N'OBSTETRICAL_RF_PROM_DT', N'Premature Rupture Of Membranes', N'Premature Rupture Of Membranes', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (19, 3, 2, N'OBSTETRICAL_RF_SROM_DT', N'Spontaneous Rupture Of Membranes', N'Spontaneous Rupture Of Membranes', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (20, 1, 2, N'OBSTETRICAL_RF_OLI_GOHYDRAMNIOS', N'Oligohydramnios', N'Oligohydramnios', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (21, 1, 2, N'OBSTETRICAL_RF_POLY_HYDRAMNIOS', N'Polyhydramnios', N'Polyhydramnios', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (22, 1, 2, N'OBSTETRICAL_RF_MACROSOMIA_LGA', N'Macrosomia', N'Macrosomia', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (23, 3, 2, N'OBSTETRICAL_RF_PROTRACTION_DT', N'Protraction', N'Protraction', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (24, 3, 2, N'OBSTETRICAL_RF_ARREST_DT', N'Arrest', N'Arrest of Labor', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (25, 3, 2, N'OBSTETRICAL_RF_MAL_PRESENTATION', N'Malpresentation', N'Malpresentation', N'VARCHAR(128)', N''' Breech'','' Face'','' Transverse Lie'',''Unable to assess''', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IN ('' Breech'','' Face'','' Transverse Lie'',''Unable to assess'') ', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (26, 4, 2, N'OBSTETRICAL_RF_PREV_C_SECTION', N'Previous C/Section', N'Previous C/Section', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (27, 3, 2, N'OBSTETRICAL_RF_BLEEDING', N'Bleeding', N'Bleeding', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (28, 3, 2, N'Abruption', N'Abruption', N'Abruption', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (29, 1, 3, N'AbnBPP', N'Abnormal BPP', N'Abnormal BPP', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (30, 1, 3, N'AbnDopplers', N'Abnormal Dopplers', N'Abnormal Dopplers', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (31, 1, 3, N'Anomaly', N'Fetal Anomaly', N'Fetal Anomaly', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (32, 1, 3, N'FETAL_RF_PREMIE', N'Premature', N'Premature', N'VARCHAR(128)', N'''Late-term'',''Pre-term''', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IN (''Late-term'',''Pre-term'')', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (33, 3, 3, N'FETAL_RF_MECONIUM_DT', N'Meconium', N'Meconium Passage', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (34, 3, 3, N'FETAL_RF_INTRAUTERINE_RESUSCITATION_DT', N'Intrauterine Resuscitation', N'Intrauterine Resuscitation', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (35, 3, 3, N'FETAL_RF_TERMINAL_BRADYCARDIA_DT', N'Bradycardia', N'Terminal Bradycardia', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (36, 3, 3, N'FETAL_RF_SECOND_STAGE_DT', N'Second Stage', N'Second Stage of Labor', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (37, 1, 3, N'FETAL_RF_ARRYTHMIA', N'Arrhythmia', N'Fetal Arrhythmia', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (38, 1, 2, N'FETAL_RF_IUGR', N'Intrauterine Growth Restriction', N'Intrauterine Growth Restriction', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-21T23:11:18.1700000' AS DateTime2), N' = 1', 0, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (39, 1, 3, N'DecreasedFetalMovement', N'Decreased Fetal Movement', N'Decreased Fetal Movement', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (40, 1, 3, N'Chorioamnionitis', N'Chorioamnionitis', N'Chorioamnionitis', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (41, 3, 2, N'OBSTETRICAL_RF_AROM', N'Artifical Rupture Of Membranes', N'Artifical Rupture Of Membranes', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (42, 3, 2, N'OBSTETRICAL_RF_PROM', N'Premature Rupture Of Membranes', N'Premature Rupture Of Membranes', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (43, 3, 2, N'OBSTETRICAL_RF_SROM', N'Spontaneous Rupture Of Membranes', N'Spontaneous Rupture Of Membranes', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (44, 3, 3, N'FETAL_RF_MECONIUM', N'Meconium', N'Meconium Passage', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (45, 3, 2, N'OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT', N'Oligohydramnios', N'Oligohydramnios', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (46, 3, 2, N'OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT', N'Polyhydramnios', N'Polyhydramnios', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N'IS NOT NULL', 1, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (47, 3, 2, N'OBSTETRICAL_RF_PROTRACTION', N'Protraction', N'Protraction', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (48, 3, 2, N'OBSTETRICAL_RF_ARREST', N'Arrest', N'Arrest', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (49, 3, 3, N'FETAL_RF_TERMINAL_BRADYCARDIA', N'Bradycardia', N'Terminal Bradycardia', N'BIT', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N' = 1', 1, 2)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (50, 3, 3, N'FETAL_RF_ARRYTHMIA_DT', N'Arrythmia', N'Arrythmia', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N'IS NOT NULL', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (51, 3, 3, N'FETAL_RF_IUGR_DT', N'Intrauterine Growth Restriction', N'Intrauterine Growth Restriction', N'DATETIME2(0)', N'1.000', N'1.000', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-11-22T00:00:00.0000000' AS DateTime2), N'IS NOT NULL', 0, 1)
    GO
    INSERT [ref].[tRiskFactor] ([RiskFactorID], [RiskFactorTypeID], [RiskFactorGroupID], [RiskFactorKey], [RiskFactorName], [RiskFactorDescription], [DataType], [ThresholdMin], [ThresholdMax], [RiskFactorWeight], [m_ExecutionDt], [RangeFilter], [m_IsEnabled], [Rnk]) VALUES (52, 3, 3, N'FETAL_RF_INTRAUTERINE_RESUSCITATION', N'Intrauterine Resuscitation', N'Intrauterine Resuscitation', N'BIT', N'1', N'1', CAST(1.000 AS Decimal(6, 3)), CAST(N'2019-12-05T00:00:00.0000000' AS DateTime2), N'= 1', 1, 2)
    GO
    SET IDENTITY_INSERT [ref].[tRiskFactor] OFF

PRINT 'Finished risk factor reference table initialization.'