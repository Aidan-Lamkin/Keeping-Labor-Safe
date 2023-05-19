/* Reference table that defines groupings of risk factors. At this time, risk factors fall into 3 groups: Maternal, Fetal or Obstetrical. In addition, it is assumed that a risk factor
	will only be a member of one group. */

CREATE TABLE [ref].[tRiskFactorGroup] (
    [RiskFactorGroupID]          INT           IDENTITY (1, 1) NOT NULL,
    [RiskFactorGroupKey]         VARCHAR (128) NULL,
    [RiskFactorGroupName]        VARCHAR (128) NULL,
    [RiskFactorGroupDescription] VARCHAR (500) NULL,
    [IsActive]                   BIT           NULL,
    [m_ExecutionDt]              DATETIME2 (2) NULL
);

