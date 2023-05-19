/* Unpivoted sample data stored as a source for python input data. Can also be separately imported and analyzed */ 

CREATE TABLE [app].[tKlsSample] (
    [CaseID]          INT                NOT NULL,
    [SeqID]           INT                NOT NULL,
    [SampleDateTime]  DATETIME2 (2)      NULL,
    [MetricKey]       VARCHAR (128)      NULL,
    [MetricSourceKey] VARCHAR (128)      NULL,
    [Value]           INT                NULL,
    [m_ExecutionDt]   DATETIMEOFFSET (0) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_app_tKlsSample] PRIMARY KEY CLUSTERED ([CaseID] ASC, [SeqID] ASC)
);

