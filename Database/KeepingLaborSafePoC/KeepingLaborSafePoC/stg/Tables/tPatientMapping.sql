CREATE TABLE [stg].[tPatientMapping] (
    [MRN]               VARCHAR (50)  NULL,
    [File]              VARCHAR (50)  NULL,
    [Mother_Admit_Tm]   VARCHAR (50)  NULL,
    [DELIVERY_TIME]     VARCHAR (50)  NULL,
    [GUID]              VARCHAR (50)  NULL,
    [INPATIENT_DATA_ID] VARCHAR (50)  NULL,
    [filename]          VARCHAR (200) NULL,
    [m_ExecutionDt]     DATETIME2 (0) DEFAULT (getutcdate()) NULL
);

