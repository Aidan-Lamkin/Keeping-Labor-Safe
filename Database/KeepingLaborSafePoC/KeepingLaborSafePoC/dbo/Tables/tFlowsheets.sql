CREATE TABLE [dbo].[tFlowsheets] (
    [ID]                                       INT            IDENTITY (1, 1) NOT NULL,
    [INPATIENT_DATA_ID]                        NVARCHAR (255) NULL,
    [flo_meas_id]                              NVARCHAR (255) NULL,
    [meas_value]                               NVARCHAR (255) NULL,
    [First_Recorded_Time]                      DATETIME2 (0)  NULL,
    [MATERNAL_RF_EPIDURAL_Name]                NVARCHAR (255) NULL,
    [MATERNAL_RF_EPIDURAL]                     FLOAT (53)     NULL,
    [MATERNAL_RF_EPIDURAL_DT]                  DATETIME2 (0)  NULL,
    [OBSTETRICAL_RF_MAL_PRESENTATION_Name]     NVARCHAR (255) NULL,
    [OBSTETRICAL_RF_MAL_PRESENTATION]          FLOAT (53)     NULL,
    [OBSTETRICAL_RF_MAL_PRESENTATION_DT]       DATETIME2 (0)  NULL,
    [FETAL_RF_INTRAUTERINE_RESUSCITATION_Name] NVARCHAR (255) NULL,
    [FETAL_RF_INTRAUTERINE_RESUSCITATION]      FLOAT (53)     NULL,
    [FETAL_RF_INTRAUTERINE_RESUSCITATION_DT]   DATETIME2 (0)  NULL,
    [CERVIX_DILATION_Name]                     NVARCHAR (255) NULL,
    [CERVIX_DILATION]                          FLOAT (53)     NULL,
    [CERVIX_EFFACEMENT_Name]                   NVARCHAR (255) NULL,
    [CERVIX_EFFACEMENT]                        FLOAT (53)     NULL,
    [CERVIX_STATION_Name]                      NVARCHAR (255) NULL,
    [CERVIX_STATION]                           FLOAT (53)     NULL,
    [PITOCIN_MU_MIN_Name]                      NVARCHAR (255) NULL,
    [PITOCIN_MU_MIN]                           FLOAT (53)     NULL,
    [FHR_BPM_RATE_Name]                        NVARCHAR (255) NULL,
    [FHR_BPM_RATE]                             FLOAT (53)     NULL,
    [FHR_VARIABILITY_Name]                     NVARCHAR (255) NULL,
    [FHR_VARIABILITY]                          FLOAT (53)     NULL,
    [FHR_ACCELERATIONS_Name]                   NVARCHAR (255) NULL,
    [FHR_ACCELERATIONS]                        FLOAT (53)     NULL,
    [FHR_ACCELERATIONS1]                       FLOAT (53)     NULL,
    [CONTRACTIONS_RATE_PER_20_MINS_Name]       NVARCHAR (255) NULL,
    [CONTRACTIONS_RATE_PER_20_MINS]            FLOAT (53)     NULL,
    [IR_OXYGEN_Name]                           NVARCHAR (255) NULL,
    [IR_OXYGEN]                                FLOAT (53)     NULL,
    [IR_IV_FLUIDS_Name]                        NVARCHAR (255) NULL,
    [IR_IV_FLUIDS]                             FLOAT (53)     NULL,
    [IR_POSITION_CHANGE_Name]                  NVARCHAR (255) NULL,
    [IR_POSITION_CHANGE]                       FLOAT (53)     NULL,
    [SSMA_TimeStamp]                           ROWVERSION     NOT NULL,
    CONSTRAINT [Flowsheets$ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Flowsheets$INPATIENT_DATA_ID]
    ON [dbo].[tFlowsheets]([INPATIENT_DATA_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [Flowsheets$flo_meas_id]
    ON [dbo].[tFlowsheets]([flo_meas_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[INPATIENT_DATA_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'INDEX', @level2name = N'Flowsheets$INPATIENT_DATA_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[flo_meas_id]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'INDEX', @level2name = N'Flowsheets$flo_meas_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'CONSTRAINT', @level2name = N'Flowsheets$ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[IR_POSITION_CHANGE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'IR_POSITION_CHANGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[IR_POSITION_CHANGE_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'IR_POSITION_CHANGE_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[IR_IV_FLUIDS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'IR_IV_FLUIDS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[IR_IV_FLUIDS_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'IR_IV_FLUIDS_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[IR_OXYGEN]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'IR_OXYGEN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[IR_OXYGEN_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'IR_OXYGEN_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CONTRACTIONS_RATE_PER_20_MINS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CONTRACTIONS_RATE_PER_20_MINS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CONTRACTIONS_RATE_PER_20_MINS_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CONTRACTIONS_RATE_PER_20_MINS_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_ACCELERATIONS1]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_ACCELERATIONS1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_ACCELERATIONS]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_ACCELERATIONS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_ACCELERATIONS_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_ACCELERATIONS_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_VARIABILITY]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_VARIABILITY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_VARIABILITY_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_VARIABILITY_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_BPM_RATE]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_BPM_RATE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FHR_BPM_RATE_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FHR_BPM_RATE_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[PITOCIN_MU_MIN]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'PITOCIN_MU_MIN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[PITOCIN_MU_MIN_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'PITOCIN_MU_MIN_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CERVIX_STATION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CERVIX_STATION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CERVIX_STATION_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CERVIX_STATION_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CERVIX_EFFACEMENT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CERVIX_EFFACEMENT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CERVIX_EFFACEMENT_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CERVIX_EFFACEMENT_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CERVIX_DILATION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CERVIX_DILATION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[CERVIX_DILATION_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'CERVIX_DILATION_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FETAL_RF_INTRAUTERINE_RESUSCITATION_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FETAL_RF_INTRAUTERINE_RESUSCITATION_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FETAL_RF_INTRAUTERINE_RESUSCITATION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FETAL_RF_INTRAUTERINE_RESUSCITATION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[FETAL_RF_INTRAUTERINE_RESUSCITATION_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'FETAL_RF_INTRAUTERINE_RESUSCITATION_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[OBSTETRICAL_RF_MAL_PRESENTATION_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_MAL_PRESENTATION_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[OBSTETRICAL_RF_MAL_PRESENTATION]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_MAL_PRESENTATION';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[OBSTETRICAL_RF_MAL_PRESENTATION_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'OBSTETRICAL_RF_MAL_PRESENTATION_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[MATERNAL_RF_EPIDURAL_DT]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_EPIDURAL_DT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[MATERNAL_RF_EPIDURAL]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_EPIDURAL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[MATERNAL_RF_EPIDURAL_Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'MATERNAL_RF_EPIDURAL_Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[First_Recorded_Time]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'First_Recorded_Time';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[meas_value]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'meas_value';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[flo_meas_id]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'flo_meas_id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[INPATIENT_DATA_ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'INPATIENT_DATA_ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'Labor Safety FRI.[Flowsheets]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tFlowsheets';

