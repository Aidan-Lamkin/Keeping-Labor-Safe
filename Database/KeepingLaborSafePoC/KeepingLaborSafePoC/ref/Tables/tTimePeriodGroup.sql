/* Reference table that allows for the grouping of time periods for analysis and/or aggregation */ 

CREATE TABLE [ref].[tTimePeriodGroup] (
    [TimePeriodGroupID]          INT           IDENTITY (1, 1) NOT NULL,
    [TimePeriodGroupKey]         VARCHAR (128) NULL,
    [TimePeriodGroupName]        VARCHAR (128) NULL,
    [TimePeriodGroupDescription] VARCHAR (500) NULL,
    [m_ExecutionDt]              DATETIME2 (2) NULL
);

