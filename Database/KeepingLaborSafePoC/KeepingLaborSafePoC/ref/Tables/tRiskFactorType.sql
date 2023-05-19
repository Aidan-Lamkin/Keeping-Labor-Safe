/* Reference table that defines types of Risk Factors. Currently, these are: chronic conditions (preexisting or unchanging during labor), dynamic conditions (potentially changing during labor)
	unidirectional/event-based (one particular event that occurs during labor and will not be reversed), or quantitative (unchanging during labor and more measurement-focused - age, 
	BMI, height, etc) */

CREATE TABLE [ref].[tRiskFactorType] (
    [RiskFactorTypeID]          INT           IDENTITY (1, 1) NOT NULL,
    [RiskFactorTypeKey]         VARCHAR (128) NULL,
    [RiskFactorTypeName]        VARCHAR (128) NULL,
    [RiskFactorTypeDescription] VARCHAR (128) NULL,
    [m_ExecutionDt]             DATETIME2 (2) NULL
);

