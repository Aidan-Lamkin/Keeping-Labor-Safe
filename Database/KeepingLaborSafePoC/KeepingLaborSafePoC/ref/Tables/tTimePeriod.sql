/* Reference table that defines relevant time periods over which normal/abnormal FRI scores may be analyzed, computed or aggregated. Examples could be Stage 2 labor, 
	IR to delivery, Start of labor to Point A or B, etc.. Time periods are defined by a start and end milestone found in the MilestoneTable. At this time, a milestone
	is required to derive start/end time, but separate start/end time columns could be added to make the model more flexible. */ 

CREATE TABLE [ref].[tTimePeriod] (
    [TimePeriodID]      INT           IDENTITY (1, 1) NOT NULL,
    [TimePeriodKey]     VARCHAR (128) NULL,
	[TimePeriodName]	VARCHAR (128) NULL,
    [StartMilestoneID]  INT           NULL,
    [EndMilestoneID]    INT           NULL,
    [TimePeriodGroupID] INT           NULL,
    [IsActive]          BIT           NULL,
    [m_ExecutionDt]     DATETIME2 (2) NULL
);

