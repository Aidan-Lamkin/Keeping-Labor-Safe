/* Reference table to track units of measurement by metric based on sample data */

CREATE TABLE [ref].[tMetricUnit]
(
    [MetricUnitID]          INT                IDENTITY (1, 1) NOT NULL,
    [MetricUnitKey]         VARCHAR (128)      NULL,
    [MetricUnitName]        VARCHAR (256)      NULL,
    [MetricUnitDescription] VARCHAR (500)      NULL,
    [m_ExecutionDt]     DATETIMEOFFSET (0) DEFAULT (getutcdate()) NULL
)
