﻿CREATE VIEW	ana.vwKlsEmrCaseOutcome
AS
SELECT INPATIENT_DATA_ID AS CaseID
	 , FETAL_OUTCOME_APGAR_1
	 , FETAL_OUTCOME_APGAR_5
	 , FETAL_OUTCOME_APGAR_10
	 , FETAL_OUTCOME_WEIGHT
	 , DELIVERY_C_SECTION
	 , DELIVERY_EMERGENCY
	 , DELIVERY_FORCEPS
	 , DELIVERY_NSVD
	 , DELIVERY_VACUUM
FROM dbo.tRiskFactorData