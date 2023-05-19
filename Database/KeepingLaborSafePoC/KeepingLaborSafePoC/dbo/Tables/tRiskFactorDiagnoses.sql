CREATE TABLE [dbo].[tRiskFactorDiagnoses] (
    [ID]                                 INT            IDENTITY (1, 1) NOT NULL,
    [PAT_ID]                             NVARCHAR (255) NULL,
    [INPATIENT_DATA_ID]                  NVARCHAR (255) NULL,
    [dx_id]                              FLOAT (53)     NULL,
    [ICD10_Code]                         NVARCHAR (255) NULL,
    [DX_NAME]                            NVARCHAR (255) NULL,
    [MATERNAL_RF_DIABETES]               NVARCHAR (255) NULL,
    [MATERNAL_RF_DIABETES_DT]            DATETIME2 (0)  NULL,
    [MATERNAL_RF_HTN_PRE_E]              NVARCHAR (255) NULL,
    [MATERNAL_RF_HTN_PRE_E_DT]           DATETIME2 (0)  NULL,
    [MATERNAL_RF_PULMONARY]              NVARCHAR (255) NULL,
    [MATERNAL_RF_PULMONARY_DT]           DATETIME2 (0)  NULL,
    [MATERNAL_RF_CARDIAC]                NVARCHAR (255) NULL,
    [MATERNAL_RF_CARDIAC_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_ARREST]              FLOAT (53)     NULL,
    [OBSTETRICAL_RF_ARREST_DT]           DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_MACROSOMIA_LGA]      FLOAT (53)     NULL,
    [OBSTETRICAL_RF_MACROSOMIA_LGA_DT]   DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS]    FLOAT (53)     NULL,
    [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT] DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_POLY_HYDRAMNIOS]     FLOAT (53)     NULL,
    [OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT]  DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_PREV_C_SECTION]      FLOAT (53)     NULL,
    [OBSTETRICAL_RF_PREV_C_SECTION_DT]   DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_PROTRACTION]         FLOAT (53)     NULL,
    [OBSTETRICAL_RF_PROTRACTION_DT]      DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_PROM]                FLOAT (53)     NULL,
    [OBSTETRICAL_RF_PROM_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_SROM]                FLOAT (53)     NULL,
    [OBSTETRICAL_RF_SROM_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_AROM]                FLOAT (53)     NULL,
    [OBSTETRICAL_RF_AROM_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_BLEEDING]            FLOAT (53)     NULL,
    [FETAL_RF_ARRYTHMIA]                 FLOAT (53)     NULL,
    [FETAL_RF_ARRYTHMIA_DT]              DATETIME2 (0)  NULL,
    [FETAL_RF_TERMINAL_BRADYCARDIA]      FLOAT (53)     NULL,
    [FETAL_RF_TERMINAL_BRADYCARDIA_DT]   DATETIME2 (0)  NULL,
    [FETAL_RF_IUGR]                      FLOAT (53)     NULL,
    [FETAL_RF_IUGR_DT]                   DATETIME2 (0)  NULL,
    [MATERNAL_RF_CARDIAC1]               FLOAT (53)     NULL,
    [MATERNAL_RF_CARDIAC_DT1]            DATETIME2 (0)  NULL,
    [MATERNAL_RF_PULMONARY1]             FLOAT (53)     NULL,
    [MATERNAL_RF_PULMONARY_DT1]          DATETIME2 (0)  NULL,
    [SSMA_TimeStamp]                     ROWVERSION     NOT NULL,
    CONSTRAINT [Diagnoses$ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Diagnoses$PAT_ID]
    ON [dbo].[tRiskFactorDiagnoses]([PAT_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [Diagnoses$INPATIENT_DATA_ID]
    ON [dbo].[tRiskFactorDiagnoses]([INPATIENT_DATA_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [Diagnoses$ICD10_Code]
    ON [dbo].[tRiskFactorDiagnoses]([ICD10_Code] ASC);


GO
CREATE NONCLUSTERED INDEX [Diagnoses$dx_id]
    ON [dbo].[tRiskFactorDiagnoses]([dx_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[PAT_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'INDEX', @level2name = N'Diagnoses$PAT_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[INPATIENT_DATA_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'INDEX', @level2name = N'Diagnoses$INPATIENT_DATA_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[ICD10_Code]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'INDEX', @level2name = N'Diagnoses$ICD10_Code';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[dx_id]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'INDEX', @level2name = N'Diagnoses$dx_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'CONSTRAINT', @level2name = N'Diagnoses$ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_PULMONARY_DT1]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_PULMONARY_DT1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_PULMONARY1]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_PULMONARY1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_CARDIAC_DT1]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_CARDIAC_DT1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_CARDIAC1]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_CARDIAC1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[FETAL_RF_IUGR_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'FETAL_RF_IUGR_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[FETAL_RF_IUGR]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'FETAL_RF_IUGR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[FETAL_RF_TERMINAL_BRADYCARDIA_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'FETAL_RF_TERMINAL_BRADYCARDIA_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[FETAL_RF_TERMINAL_BRADYCARDIA]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'FETAL_RF_TERMINAL_BRADYCARDIA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[FETAL_RF_ARRYTHMIA_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'FETAL_RF_ARRYTHMIA_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[FETAL_RF_ARRYTHMIA]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'FETAL_RF_ARRYTHMIA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_BLEEDING]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_BLEEDING';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_AROM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_AROM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_AROM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_AROM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_SROM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_SROM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_SROM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_SROM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_PROM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_PROM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_PROTRACTION_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROTRACTION_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_PROTRACTION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROTRACTION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_PREV_C_SECTION_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PREV_C_SECTION_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_PREV_C_SECTION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PREV_C_SECTION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_POLY_HYDRAMNIOS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_POLY_HYDRAMNIOS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_OLI_GOHYDRAMNIOS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_OLI_GOHYDRAMNIOS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_MACROSOMIA_LGA_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_MACROSOMIA_LGA_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_MACROSOMIA_LGA]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_MACROSOMIA_LGA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_ARREST_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_ARREST_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[OBSTETRICAL_RF_ARREST]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_ARREST';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_CARDIAC_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_CARDIAC_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_CARDIAC]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_CARDIAC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_PULMONARY_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_PULMONARY_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_PULMONARY]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_PULMONARY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_HTN_PRE_E_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_HTN_PRE_E_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_HTN_PRE_E]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_HTN_PRE_E';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_DIABETES_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_DIABETES_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[MATERNAL_RF_DIABETES]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_DIABETES';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[DX_NAME]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'DX_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[ICD10_Code]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'ICD10_Code';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[dx_id]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'dx_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[INPATIENT_DATA_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'INPATIENT_DATA_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[PAT_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'PAT_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Diagnoses]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorDiagnoses';

