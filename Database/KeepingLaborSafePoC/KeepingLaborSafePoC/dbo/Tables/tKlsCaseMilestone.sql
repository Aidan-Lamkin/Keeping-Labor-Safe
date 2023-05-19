/* Join table that links Cases and Milestones (tall/skinny). Includes internal CaseID, MilestoneID and timestamp */

CREATE TABLE [dbo].[tKlsCaseMilestone] (
    [CaseID]            INT           NOT NULL,
    [MilestoneID]       INT           NOT NULL,
    [MilestoneDateTime] DATETIME2 (2) NULL,
    [m_ExecutionDt]     DATETIME2 (2) NULL,
    CONSTRAINT [PK_tKlsCaseMilestone] PRIMARY KEY CLUSTERED ([CaseID] ASC, [MilestoneID] ASC)
);



