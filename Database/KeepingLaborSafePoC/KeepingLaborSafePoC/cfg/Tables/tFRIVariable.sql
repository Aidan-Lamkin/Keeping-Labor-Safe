/* Configuration table that defines FRI Component Variables and assigns thresholds/weights. These can be changed at any time and analysis re-run to see how the FRI score is affected.*/

CREATE TABLE [cfg].[tFRIVariable] (
    [VariableID]           INT            NULL,
    [VariableKey]          VARCHAR (128)  NULL,
    [MetricUnitID]         INT            NULL,
    [ThresholdMin]         DECIMAL (8, 3) NULL,
    [ThresholdMax]         DECIMAL (8, 3) NULL,
    [ComponentScoreWeight] DECIMAL (8, 3) NULL,
    [VariableDescription]  VARCHAR (500)  NULL
);



