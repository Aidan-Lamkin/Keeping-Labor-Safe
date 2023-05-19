/* Reference table to track different metrics captured in sample data (FHR, UA, etc)*/

CREATE TABLE [ref].[tMetric] (
    [MetricID]          INT                IDENTITY (1, 1) NOT NULL,
    [MetricKey]         VARCHAR (128)      NULL,
    [MetricName]        VARCHAR (256)      NULL,
    [MetricDescription] VARCHAR (500)      NULL,
    [m_ExecutionDt]     DATETIMEOFFSET (0) DEFAULT (getutcdate()) NULL
);

