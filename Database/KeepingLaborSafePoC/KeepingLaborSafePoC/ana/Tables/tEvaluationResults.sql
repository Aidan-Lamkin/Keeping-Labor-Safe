CREATE TABLE [ana].[tEvaluationResults] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [value]        VARCHAR (128) NULL,
    [tp]           INT           NULL,
    [tn]           INT           NULL,
    [fn]           INT           NULL,
    [fp]           INT           NULL,
    [acc]          FLOAT (53)    NULL,
    [fpr]          FLOAT (53)    NULL,
    [fnr]          FLOAT (53)    NULL,
    [ppv]          FLOAT (53)    NULL,
    [tpr]          FLOAT (53)    NULL,
    [tnr]          FLOAT (53)    NULL,
    [npv]          FLOAT (53)    NULL,
    [mse]          FLOAT (53)    NULL,
    [mae]          FLOAT (53)    NULL,
    [EvaluationDt] DATETIME      NULL
);

