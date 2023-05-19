/* Reference table that defines a list of Risk Factors that may affect the FRI score. They should have a group (Maternal, Obstetrical, or Fetal) and a type 
	(chronic, dynamic, unidirectiona/event-based, or quantitative). */

CREATE TABLE [ref].[tRiskFactor] (
    [RiskFactorID]          INT            IDENTITY (1, 1) NOT NULL,
    [RiskFactorTypeID]      INT            NULL,
    [RiskFactorGroupID]     INT            NULL,
    [RiskFactorKey]         VARCHAR (128)  NULL,
    [RiskFactorName]        VARCHAR (128)  NULL,
    [RiskFactorDescription] VARCHAR (500)  NULL,
    [DataType]              VARCHAR (128)  NULL,
    [ThresholdMin]          VARCHAR (128)  NULL,
    [ThresholdMax]          VARCHAR (128)  NULL,
    [RiskFactorWeight]      DECIMAL (6, 3) NULL,
    [m_ExecutionDt]         DATETIME2 (2)  NULL,
    [RangeFilter]           VARCHAR (2000) NULL,
    [m_IsEnabled]           BIT            DEFAULT ((1)) NULL,
    [Rnk]                   INT            NULL
);









