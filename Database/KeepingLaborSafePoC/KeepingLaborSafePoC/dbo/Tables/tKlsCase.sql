/* Full historical list of cases ingested, including internal CaseID, external key to source system and start/end time*/

CREATE TABLE [dbo].[tKlsCase] (
    [CaseID]            INT           NOT NULL,
    [CaseKey]           VARCHAR (128) NULL,
    [CaseStartDateTime] DATETIME2 (2) NULL,
    [CaseEndDateTime]   DATETIME2 (2) NULL,
    [m_IsEnabled]       BIT           NOT NULL,
    [m_ExecutionDt]     DATETIME2 (7) NOT NULL,
    [m_IsValid]         BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([CaseID] ASC)
);













