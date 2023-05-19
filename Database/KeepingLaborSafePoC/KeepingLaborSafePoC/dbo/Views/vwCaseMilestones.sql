
CREATE VIEW [dbo].[vwCaseMilestones]
AS

	SELECT DISTINCT INPATIENT_DATA_ID AS CaseID
		 , MilestoneKey
		 , MIN(MilestoneValue) AS MilestoneValue
	FROM stg.vwRiskFactorData t
	UNPIVOT
	(
		[MilestoneValue] 
		FOR MilestoneKey IN (
							   
							  [FETAL_RF_SECOND_STAGE_DT],
							  [Mother_Admit_Time],
							  [MATERNAL_DELIVERY_TIME])
	) upvt
	GROUP BY INPATIENT_DATA_ID, MilestoneKey
	UNION
	SELECT DISTINCT INPATIENT_DATA_ID
		 , MilestoneKey
		 , MilestoneValue
	FROM stg.vwRiskFactorFlowsheets t
	UNPIVOT
	(
		MilestoneValue 
		FOR MilestoneKey IN (
							   MATERNAL_RF_EPIDURAL_DT
							  ,FETAL_RF_INTRAUTERINE_RESUSCITATION_DT)
	) upvt3

	UNION
	SELECT INPATIENT_DATA_ID
		 , 'PITOCIN_START_DT' AS MilestoneKey
		 , MIN(First_Recorded_Time) AS MilestoneValue
	FROM dbo.tFlowsheets
	WHERE PITOCIN_MU_MIN = 1
	GROUP BY INPATIENT_DATA_ID