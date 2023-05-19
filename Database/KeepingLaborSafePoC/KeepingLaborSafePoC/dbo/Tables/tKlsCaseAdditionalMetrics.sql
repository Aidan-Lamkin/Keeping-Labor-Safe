/* Output table that stores the results of additional metric calculation by time period on a case-by-case basis). */

CREATE TABLE [dbo].[tKlsCaseAdditionalMetrics] (
    [CaseID]         INT            NOT NULL,
    [TimePeriodKey]  VARCHAR (128)  NOT NULL,
    [TimePeriodName] VARCHAR (128)  NULL,
    [EXUA]           DECIMAL (6, 2) NULL,
    [FHR]            DECIMAL (6, 2) NULL,
    [VARIAB]         DECIMAL (6, 2) NULL,
    [ACCELS]         DECIMAL (6, 2) NULL,
    [DECELS]         DECIMAL (6, 2) NULL,
    [YELLOW]         DECIMAL (6, 2) NULL,
    [RED]            DECIMAL (6, 2) NULL,
    [m_ExecutionDt]  DATETIME2 (0)  NULL,
    CONSTRAINT [PK_tKlsCaseAdditionalMetrics] PRIMARY KEY CLUSTERED ([CaseID] ASC, [TimePeriodKey] ASC)
);



