/* Reference table to track metric sources in sample data (external, TOCO, IUP, etc) */

CREATE TABLE [ref].[tMetricSource] (
    [MetricSourceID]          INT           IDENTITY (1, 1) NOT NULL,
    [MetricSourceKey]         VARCHAR (128) NULL,
    [MetricSourceName]        VARCHAR (256) NULL,
    [MetricSourceDescription] VARCHAR (500) NULL
);

