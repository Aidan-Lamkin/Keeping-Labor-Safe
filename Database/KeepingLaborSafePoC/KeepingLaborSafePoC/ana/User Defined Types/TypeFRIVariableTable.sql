/* DEPRECATED - originally created to use as input to the custom FRI scoring function ana.usfCalculateFRI */

CREATE TYPE [ana].[TypeFRIVariableTable] AS TABLE (
    [VariableKey]   VARCHAR (128)  NOT NULL,
    [VariableValue] DECIMAL (8, 3) NOT NULL);



