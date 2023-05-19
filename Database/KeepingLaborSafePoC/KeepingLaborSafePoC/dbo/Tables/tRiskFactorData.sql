CREATE TABLE [dbo].[tRiskFactorData] (
    [ID]                                 INT            IDENTITY (1, 1) NOT NULL,
    [INPATIENT_DATA_ID]                  NVARCHAR (255) NULL,
    [DEPARTMENT_NAME]                    NVARCHAR (255) NULL,
    [Mother_Admit_Time]                  DATETIME2 (0)  NULL,
    [Number_Of_Babies]                   FLOAT (53)     NULL,
    [Mother_Delivery_Method]             NVARCHAR (255) NULL,
    [MATERNAL_RF_AGE]                    FLOAT (53)     NULL,
    [MATERNAL_RF_AGE_D]                  DATETIME2 (0)  NULL,
    [MATERNAL_DELIVERY_TIME]             DATETIME2 (0)  NULL,
    [MATERNAL_RF_GRAVIDA]                FLOAT (53)     NULL,
    [MATERNAL_RF_PARITY]                 FLOAT (53)     NULL,
    [MATERNAL_RF_GEST_AGE]               FLOAT (53)     NULL,
    [MATERNAL_RF_GEST_AGE_DT]            DATETIME2 (0)  NULL,
    [MATERNAL_RF_EST_DELIVERY_DT]        DATETIME2 (0)  NULL,
    [MATERNAL_RF_EPIDURAL]               FLOAT (53)     NULL,
    [OBSTETRICAL_RF_AROM]                FLOAT (53)     NULL,
    [OBSTETRICAL_RF_AROM_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_PROM]                FLOAT (53)     NULL,
    [OBSTETRICAL_RF_PROM_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_SROM]                FLOAT (53)     NULL,
    [OBSTETRICAL_RF_SROM_DT]             DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_PREV_C_SECTION]      FLOAT (53)     NULL,
    [FETAL_RF_PREMIE]                    NVARCHAR (255) NULL,
    [FETAL_RF_SECOND_STAGE]              NVARCHAR (255) NULL,
    [FETAL_RF_SECOND_STAGE_DT]           DATETIME2 (0)  NULL,
    [FETAL_OUTCOME_APGAR_1]              FLOAT (53)     NULL,
    [FETAL_OUTCOME_APGAR_5]              FLOAT (53)     NULL,
    [FETAL_OUTCOME_APGAR_10]             FLOAT (53)     NULL,
    [FETAL_OUTCOME_WEIGHT]               FLOAT (53)     NULL,
    [DELIVERY_C_SECTION]                 FLOAT (53)     NULL,
    [DELIVERY_NSVD]                      FLOAT (53)     NULL,
    [DELIVERY_FORCEPS]                   FLOAT (53)     NULL,
    [DELIVERY_VACUUM]                    FLOAT (53)     NULL,
    [DELIVERY_EMERGENCY]                 FLOAT (53)     NULL,
    [MATERNAL_RF_SHORT_STATURE]          FLOAT (53)     NULL,
    [MATERNAL_RF_OBESITY]                FLOAT (53)     NULL,
    [MATERNAL_RF_OBESITY_DT]             DATETIME2 (0)  NULL,
    [FETAL_RF_MECONIUM]                  FLOAT (53)     NULL,
    [FETAL_RF_MECONIUM_DT]               DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS]    FLOAT (53)     NULL,
    [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT] DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_POLY_HYDRAMNIOS]     FLOAT (53)     NULL,
    [OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT]  DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_PROTRACTION]         FLOAT (53)     NULL,
    [OBSTETRICAL_RF_PROTRACTION_DT]      DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_MAL_PRESENTATION]    NVARCHAR (255) NULL,
    [SSMA_TimeStamp]                     ROWVERSION     NOT NULL,
    CONSTRAINT [Patients$ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);




GO
CREATE NONCLUSTERED INDEX [Patients$Number_Of_Babies]
    ON [dbo].[tRiskFactorData]([Number_Of_Babies] ASC);


GO
CREATE NONCLUSTERED INDEX [Patients$INPATIENT_DATA_ID]
    ON [dbo].[tRiskFactorData]([INPATIENT_DATA_ID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'CONSTRAINT', @level2name = N'Patients$ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[Number_Of_Babies]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'INDEX', @level2name = N'Patients$Number_Of_Babies';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[INPATIENT_DATA_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'INDEX', @level2name = N'Patients$INPATIENT_DATA_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_SROM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_SROM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_SROM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_SROM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_PROTRACTION_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROTRACTION_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_PROTRACTION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROTRACTION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_PROM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_PROM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PROM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_PREV_C_SECTION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_PREV_C_SECTION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_POLY_HYDRAMNIOS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_POLY_HYDRAMNIOS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_OLI_GOHYDRAMNIOS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_OLI_GOHYDRAMNIOS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_MAL_PRESENTATION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_MAL_PRESENTATION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_AROM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_AROM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[OBSTETRICAL_RF_AROM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_AROM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[Number_Of_Babies]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'Number_Of_Babies';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[Mother_Delivery_Method]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'Mother_Delivery_Method';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[Mother_Admit_Time]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'Mother_Admit_Time';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_SHORT_STATURE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_SHORT_STATURE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_PARITY]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_PARITY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_OBESITY_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_OBESITY_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_OBESITY]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_OBESITY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_GRAVIDA]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_GRAVIDA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_GEST_AGE_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_GEST_AGE_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_GEST_AGE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_GEST_AGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_EST_DELIVERY_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_EST_DELIVERY_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_EPIDURAL]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_EPIDURAL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_AGE_D]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_AGE_D';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_RF_AGE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_AGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[MATERNAL_DELIVERY_TIME]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'MATERNAL_DELIVERY_TIME';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[INPATIENT_DATA_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'INPATIENT_DATA_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_RF_SECOND_STAGE_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_RF_SECOND_STAGE_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_RF_SECOND_STAGE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_RF_SECOND_STAGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_RF_PREMIE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_RF_PREMIE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_RF_MECONIUM_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_RF_MECONIUM_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_RF_MECONIUM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_RF_MECONIUM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_OUTCOME_WEIGHT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_OUTCOME_WEIGHT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_OUTCOME_APGAR_5]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_OUTCOME_APGAR_5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_OUTCOME_APGAR_10]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_OUTCOME_APGAR_10';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[FETAL_OUTCOME_APGAR_1]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'FETAL_OUTCOME_APGAR_1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[DEPARTMENT_NAME]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'DEPARTMENT_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[DELIVERY_VACUUM]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'DELIVERY_VACUUM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[DELIVERY_NSVD]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'DELIVERY_NSVD';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[DELIVERY_FORCEPS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'DELIVERY_FORCEPS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[DELIVERY_EMERGENCY]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'DELIVERY_EMERGENCY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Patients].[DELIVERY_C_SECTION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tRiskFactorData', @level2type = N'COLUMN', @level2name = N'DELIVERY_C_SECTION';

