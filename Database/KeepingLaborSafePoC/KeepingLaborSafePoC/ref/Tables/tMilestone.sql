/* Reference table that defines various case Milestones. These milestones represent significant points during labor/delivery that we may want to use for analytics / prediction.
   A Milestone may be associated with a particular event-based Risk Factor (Ruptured Membrane, etc). It could also define either the start or end of a particular stage of labor. 
   These Milestones are assumed to be generally predefined before analysis and computation of FRI / additional metrics */

CREATE TABLE [ref].[tMilestone] (
    [MilestoneID]   INT           IDENTITY (1, 1) NOT NULL,
    [MilestoneKey]  VARCHAR (128) NULL,
    [MilestoneName] VARCHAR (128) NULL,
	[RiskFactorID] INT			  NULL,
    [IsActive]      BIT           NULL,
    [m_ExecutionDt] DATETIME2 (2) NULL
);

