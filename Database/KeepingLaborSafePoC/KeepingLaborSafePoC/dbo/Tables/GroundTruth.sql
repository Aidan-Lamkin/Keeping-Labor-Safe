CREATE TABLE [dbo].[GroundTruth] (
    [index]               BIGINT        NULL,
    [CaseID]              BIGINT        NULL,
    [CaseFrameSeqID]      BIGINT        NULL,
    [SeqID]               FLOAT (53)    NULL,
    [NumContractions]     BIGINT        NULL,
    [FHRBaseline]         BIGINT        NULL,
    [FHRVariability]      BIGINT        NULL,
    [UABaseline]          FLOAT (53)    NULL,
    [NumFHRAccelerations] BIGINT        NULL,
    [NumFHRLateRecovery]  BIGINT        NULL,
    [FRIAccelerations]    BIGINT        NULL,
    [FRIExcessiveUA]      BIGINT        NULL,
    [FRIFhrBaseline]      BIGINT        NULL,
    [FRIFhrVariability]   BIGINT        NULL,
    [FRILateRecovery]     BIGINT        NULL,
    [Unnamed: 14]         VARCHAR (MAX) NULL,
    [m_ExecutionDt]       DATETIME      NULL
);




GO
CREATE NONCLUSTERED INDEX [ix_GroundTruth_index]
    ON [dbo].[GroundTruth]([index] ASC);

