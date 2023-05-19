/* This is the major table used to store FRI component analysis output from python scripts. It also serves as the basis for the FRI score calculation and stores additional measurements
	that may be useful in the future */

CREATE TABLE [ana].[tKlsFrame10Min] (
    [Id]                       INT            IDENTITY (1, 1) NOT NULL,
    [CaseID]                   INT            NOT NULL,
    [CaseFrameSeqID]           INT            NOT NULL,
    [FrameStartDateTime]       DATETIME2 (2)  NULL,
    [FrameEndDateTime]         DATETIME2 (2)  NULL,
    [Duration]                 VARCHAR (100)  NULL,
    [FHRBaselineBPM]           INT            NULL,
    [FHRVariabilityBPM]        INT            NULL,
    [NumFHRAccelerations]      INT            NULL,
    [FHRThreshold]             INT            NULL,
    [UABaseline]               INT            NULL,
    [NumContractions]          INT            NULL,
    [AvgTimePerContractionSec] INT            NULL,
    [TotalTimeContractionSec]  INT            NULL,
    [TotalTimeRelaxationSec]   INT            NULL,
    [URRatio]                  DECIMAL (3, 2) NULL,
    [UAThreshold]              INT            NULL,
    [NumFHRLateRecovery]       INT            NULL,
    [NumFHROvershoot]          BIT            NULL,
    [bTachycardia]             BIT            NULL,
    [bBradycardia]             BIT            NULL,
    [bMaternalRiskFactor]      BIT            NULL,
    [bFetalRiskFactor]         BIT            NULL,
    [bObstetricalRiskFactor]   BIT            NULL,
    [bTerminalEvent]           BIT            NULL,
    [FRIExcessiveUA]           BIT            NULL,
    [FRIAccelerations]         BIT            NULL,
    [FRIFhrBaseline]           BIT            NULL,
    [FRIFhrVariability]        BIT            NULL,
    [FRILateRecovery]          BIT            NULL,
    [FRIMaternalRiskFactor]    BIT            NULL,
    [FRIObstetricalRiskFactor] BIT            NULL,
    [FRIFetalRiskFactor]       BIT            NULL,
    [FRI]                      DECIMAL (6, 3) NULL,
    [FRI_Calculated]           AS             ((((((((CONVERT([int],[FRIExcessiveUA])+CONVERT([int],[FRIAccelerations]))+CONVERT([int],[FRIFhrBaseline]))+CONVERT([int],[FRIFhrVariability]))+CONVERT([int],[FRILateRecovery]))+CONVERT([int],[FRIMaternalRiskFactor]))+CONVERT([int],[FRIObstetricalRiskFactor]))+CONVERT([int],[FRIFetalRiskFactor]))/(8.0)),
    [IsQuality]                BIT            NULL,
    [m_ExecutionDt]            DATETIME2 (0)  NULL
);
















GO



GO


