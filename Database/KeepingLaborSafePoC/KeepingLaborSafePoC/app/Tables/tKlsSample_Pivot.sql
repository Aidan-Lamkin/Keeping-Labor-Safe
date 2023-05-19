/* Input table that stores pivoted data ready for import and analysis in Python */

CREATE TABLE [app].[tKlsSample_Pivot] (
    [CaseID]         INT                NOT NULL,
    [CaseFrameSeqID] INT                NULL,
    [SeqID]          INT                NOT NULL,
    [SampleDateTime] DATETIME2 (2)      NULL,
    [UA]             INT                NULL,
    [HR]             INT                NULL,
    [HR2]            INT                NULL,
    [MHR]            INT                NULL,
    [m_ExecutionDt]  DATETIMEOFFSET (0) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_tKlsSample_Pivot_New] PRIMARY KEY CLUSTERED ([CaseID] ASC, [SeqID] ASC)
);



