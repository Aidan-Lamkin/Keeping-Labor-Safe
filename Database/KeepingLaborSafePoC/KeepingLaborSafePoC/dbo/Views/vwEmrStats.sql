CREATE VIEW [dbo].[vwEmrStats] 
AS
WITH TotalCases AS (
SELECT CAST(COUNT(DISTINCT CaseID) AS DECIMAL(12,2)) AS NumCases FROM dbo.tKlsCase),
CaseRf AS (
SELECT cs.[CaseID]
      ,CASE WHEN [FETAL_RF_INTRAUTERINE_RESUSCITATION_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS IR_Invalid_PostDelivery
      ,CASE WHEN [FETAL_RF_MECONIUM_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Meconium_Invalid_PostDelivery
      ,CASE WHEN [FETAL_RF_SECOND_STAGE_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS SecondStage_Invalid_PostDelivery
      ,CASE WHEN [FETAL_RF_TERMINAL_BRADYCARDIA_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Bradycardia_Invalid_PostDelivery
      ,CASE WHEN [MATERNAL_RF_EPIDURAL_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Epidural_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_AROM_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Arom_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_ARREST_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Arrest_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Oligo_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Poly_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_PROM_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Prom_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_PROTRACTION_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Protraction_Invalid_PostDelivery
      ,CASE WHEN [OBSTETRICAL_RF_SROM_DT] > cs.CaseEndDateTime THEN 1  ELSE  0 END AS Srom_Invalid_PostDelivery
      ,CASE WHEN [FETAL_RF_INTRAUTERINE_RESUSCITATION_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS IR_Invalid_PreAdmission
      ,CASE WHEN [FETAL_RF_MECONIUM_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Meconium_Invalid_PreAdmission
      ,CASE WHEN [FETAL_RF_SECOND_STAGE_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS SecondStage_Invalid_PreAdmission
      ,CASE WHEN [FETAL_RF_TERMINAL_BRADYCARDIA_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Bradycardia_Invalid_PreAdmission
      ,CASE WHEN [MATERNAL_RF_EPIDURAL_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Epidural_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_AROM_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Arom_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_ARREST_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Arrest_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Oligo_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Poly_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_PROM_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Prom_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_PROTRACTION_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Protraction_Invalid_PreAdmission
      ,CASE WHEN [OBSTETRICAL_RF_SROM_DT] < cs.CaseStartDateTime THEN 1  ELSE  0 END AS Srom_Invalid_PreAdmission
	  ,CASE WHEN [FETAL_RF_INTRAUTERINE_RESUSCITATION_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS IR_Valid
      ,CASE WHEN [FETAL_RF_MECONIUM_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Meconium_Valid
      ,CASE WHEN [FETAL_RF_SECOND_STAGE_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS SecondStage_Valid
      ,CASE WHEN [FETAL_RF_TERMINAL_BRADYCARDIA_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Bradycardia_Valid
      ,CASE WHEN [MATERNAL_RF_EPIDURAL_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Epidural_Valid
      ,CASE WHEN [OBSTETRICAL_RF_AROM_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Arom_Valid
      ,CASE WHEN [OBSTETRICAL_RF_ARREST_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Arrest_Valid
      ,CASE WHEN [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Oligo_Valid
      ,CASE WHEN [OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Poly_Valid
      ,CASE WHEN [OBSTETRICAL_RF_PROM_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Prom_Valid
      ,CASE WHEN [OBSTETRICAL_RF_PROTRACTION_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Protraction_Valid
      ,CASE WHEN [OBSTETRICAL_RF_SROM_DT] BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime THEN 1  ELSE  0 END AS Srom_Valid
	  ,CASE WHEN [FETAL_RF_INTRAUTERINE_RESUSCITATION_DT] IS NULL THEN 1 ELSE 0 END AS IR_Null
      ,CASE WHEN [FETAL_RF_MECONIUM_DT] IS NULL THEN 1 ELSE 0 END AS Meconium_Null
      ,CASE WHEN [FETAL_RF_SECOND_STAGE_DT] IS NULL THEN 1 ELSE 0 END AS SecondStage_Null
      ,CASE WHEN [FETAL_RF_TERMINAL_BRADYCARDIA_DT] IS NULL THEN 1 ELSE 0 END AS Bradycardia_Null
      ,CASE WHEN [MATERNAL_RF_EPIDURAL_DT] IS NULL THEN 1 ELSE 0 END AS Epidural_Null
      ,CASE WHEN [OBSTETRICAL_RF_AROM_DT] IS NULL THEN 1 ELSE 0 END AS Arom_Null
      ,CASE WHEN [OBSTETRICAL_RF_ARREST_DT] IS NULL THEN 1 ELSE 0 END AS Arrest_Null
      ,CASE WHEN [OBSTETRICAL_RF_OLI_GOHYDRAMNIOS_DT] IS NULL THEN 1 ELSE 0 END AS Oligo_Null
      ,CASE WHEN [OBSTETRICAL_RF_POLY_HYDRAMNIOS_DT] IS NULL THEN 1 ELSE 0 END AS Poly_Null
      ,CASE WHEN [OBSTETRICAL_RF_PROM_DT] IS NULL THEN 1 ELSE 0 END AS Prom_Null
      ,CASE WHEN [OBSTETRICAL_RF_PROTRACTION_DT] IS NULL THEN 1 ELSE 0 END AS Protraction_Null
      ,CASE WHEN [OBSTETRICAL_RF_SROM_DT] IS NULL THEN 1 ELSE 0 END AS Srom_Null
  FROM [dbo].[vwAllRiskFactors] rf
	INNER JOIN dbo.tKlsCase cs
		ON rf.CaseID = cs.CaseID)
, vStats AS (
SELECT SUM(IR_Invalid_PostDelivery) AS IR_Invalid_PostDelivery
, SUM(Meconium_Invalid_PostDelivery) AS Meconium_Invalid_PostDelivery
, SUM(SecondStage_Invalid_PostDelivery) AS SecondStage_Invalid_PostDelivery
, SUM(Bradycardia_Invalid_PostDelivery) AS Bradycardia_Invalid_PostDelivery
, SUM(Epidural_Invalid_PostDelivery) AS Epidural_Invalid_PostDelivery
, SUM(Arom_Invalid_PostDelivery) AS Arom_Invalid_PostDelivery
, SUM(Arrest_Invalid_PostDelivery) AS Arrest_Invalid_PostDelivery
, SUM(Oligo_Invalid_PostDelivery) AS Oligo_Invalid_PostDelivery
, SUM(Poly_Invalid_PostDelivery) AS Poly_Invalid_PostDelivery
, SUM(Prom_Invalid_PostDelivery) AS Prom_Invalid_PostDelivery
, SUM(Protraction_Invalid_PostDelivery) AS Protraction_Invalid_PostDelivery
, SUM(Srom_Invalid_PostDelivery) AS Srom_Invalid_PostDelivery
, SUM(IR_Invalid_PreAdmission) AS IR_Invalid_PreAdmission
, SUM(Meconium_Invalid_PreAdmission) AS Meconium_Invalid_PreAdmission
, SUM(SecondStage_Invalid_PreAdmission) AS SecondStage_Invalid_PreAdmission
, SUM(Bradycardia_Invalid_PreAdmission) AS Bradycardia_Invalid_PreAdmission
, SUM(Epidural_Invalid_PreAdmission) AS Epidural_Invalid_PreAdmission
, SUM(Arom_Invalid_PreAdmission) AS Arom_Invalid_PreAdmission
, SUM(Arrest_Invalid_PreAdmission) AS Arrest_Invalid_PreAdmission
, SUM(Oligo_Invalid_PreAdmission) AS Oligo_Invalid_PreAdmission
, SUM(Poly_Invalid_PreAdmission) AS Poly_Invalid_PreAdmission
, SUM(Prom_Invalid_PreAdmission) AS Prom_Invalid_PreAdmission
, SUM(Protraction_Invalid_PreAdmission) AS Protraction_Invalid_PreAdmission
, SUM(Srom_Invalid_PreAdmission) AS Srom_Invalid_PreAdmission
, SUM(IR_Valid) AS IR_Valid
, SUM(Meconium_Valid) AS Meconium_Valid
, SUM(SecondStage_Valid) AS SecondStage_Valid
, SUM(Bradycardia_Valid) AS Bradycardia_Valid
, SUM(Epidural_Valid) AS Epidural_Valid
, SUM(Arom_Valid) AS Arom_Valid
, SUM(Arrest_Valid) AS Arrest_Valid
, SUM(Oligo_Valid) AS Oligo_Valid
, SUM(Poly_Valid) AS Poly_Valid
, SUM(Prom_Valid) AS Prom_Valid
, SUM(Protraction_Valid) AS Protraction_Valid
, SUM(Srom_Valid) AS Srom_Valid
, SUM(IR_Null) AS IR_Null
, SUM(Meconium_Null) AS Meconium_Null
, SUM(SecondStage_Null) AS SecondStage_Null
, SUM(Bradycardia_Null) AS Bradycardia_Null
, SUM(Epidural_Null) AS Epidural_Null
, SUM(Arom_Null) AS Arom_Null
, SUM(Arrest_Null) AS Arrest_Null
, SUM(Oligo_Null) AS Oligo_Null
, SUM(Poly_Null) AS Poly_Null
, SUM(Prom_Null) AS Prom_Null
, SUM(Protraction_Null) AS Protraction_Null
, SUM(Srom_Null) AS Srom_Null
, MAX(tc.NumCases) - SUM(IR_Null) AS IR_NonNull
, MAX(tc.NumCases) - SUM(Meconium_Null) AS Meconium_NonNull
, MAX(tc.NumCases) - SUM(SecondStage_Null) AS SecondStage_NonNull
, MAX(tc.NumCases) - SUM(Bradycardia_Null) AS Bradycardia_NonNull
, MAX(tc.NumCases) - SUM(Epidural_Null) AS Epidural_NonNull
, MAX(tc.NumCases) - SUM(Arom_Null) AS Arom_NonNull
, MAX(tc.NumCases) - SUM(Arrest_Null) AS Arrest_NonNull
, MAX(tc.NumCases) - SUM(Oligo_Null) AS Oligo_NonNull
, MAX(tc.NumCases) - SUM(Poly_Null) AS Poly_NonNull
, MAX(tc.NumCases) - SUM(Prom_Null) AS Prom_NonNull
, MAX(tc.NumCases) - SUM(Protraction_Null) AS Protraction_NonNull
, MAX(tc.NumCases) - SUM(Srom_Null) AS Srom_NonNull
FROM CaseRf
	CROSS APPLY TotalCases tc)
,
vStats2 AS (
SELECT tc.NumCases AS TotalCases
	 , IR_Invalid_PostDelivery, IR_Null, CAST(IR_Null/tc.NumCases AS DECIMAL(12,2)) AS IR_Null_Pct,  IR_NonNull, CAST(IR_NonNull/tc.NumCases AS DECIMAL(12,2)) AS IR_NonNull_Pct
	 , Meconium_Invalid_PostDelivery, Meconium_Null, CAST(Meconium_Null/tc.NumCases AS DECIMAL(12,2)) AS Meconium_Null_Pct,  Meconium_NonNull, CAST(Meconium_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Meconium_NonNull_Pct
	 , SecondStage_Invalid_PostDelivery, SecondStage_Null, CAST(SecondStage_Null/tc.NumCases AS DECIMAL(12,2)) AS SecondStage_Null_Pct,  SecondStage_NonNull, CAST(SecondStage_NonNull/tc.NumCases AS DECIMAL(12,2)) AS SecondStage_NonNull_Pct
	 , Bradycardia_Invalid_PostDelivery, Bradycardia_Null, CAST(Bradycardia_Null/tc.NumCases AS DECIMAL(12,2)) AS Bradycardia_Null_Pct,  Bradycardia_NonNull, CAST(Bradycardia_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Bradycardia_NonNull_Pct
	 , Epidural_Invalid_PostDelivery, Epidural_Null, CAST(Epidural_Null/tc.NumCases AS DECIMAL(12,2)) AS Epidural_Null_Pct,  Epidural_NonNull, CAST(Epidural_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Epidural_NonNull_Pct
	 , Arom_Invalid_PostDelivery, Arom_Null, CAST(Arom_Null/tc.NumCases AS DECIMAL(12,2)) AS Arom_Null_Pct,  Arom_NonNull, CAST(Arom_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Arom_NonNull_Pct
	 , Arrest_Invalid_PostDelivery, Arrest_Null, CAST(Arrest_Null/tc.NumCases AS DECIMAL(12,2)) AS Arrest_Null_Pct,  Arrest_NonNull, CAST(Arrest_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Arrest_NonNull_Pct
	 , Oligo_Invalid_PostDelivery, Oligo_Null, CAST(Oligo_Null/tc.NumCases AS DECIMAL(12,2)) AS Oligo_Null_Pct,  Oligo_NonNull, CAST(Oligo_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Oligo_NonNull_Pct
	 , Poly_Invalid_PostDelivery, Poly_Null, CAST(Poly_Null/tc.NumCases AS DECIMAL(12,2)) AS Poly_Null_Pct,  Poly_NonNull, CAST(Poly_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Poly_NonNull_Pct
	 , Prom_Invalid_PostDelivery, Prom_Null, CAST(Prom_Null/tc.NumCases AS DECIMAL(12,2)) AS Prom_Null_Pct,  Prom_NonNull, CAST(Prom_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Prom_NonNull_Pct
	 , Protraction_Invalid_PostDelivery, Protraction_Null, CAST(Protraction_Null/tc.NumCases AS DECIMAL(12,2)) AS Protraction_Null_Pct,  Protraction_NonNull, CAST(Protraction_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Protraction_NonNull_Pct
	 , Srom_Invalid_PostDelivery, Srom_Null, CAST(Srom_Null/tc.NumCases AS DECIMAL(12,2)) AS Srom_Null_Pct,  Srom_NonNull, CAST(Srom_NonNull/tc.NumCases AS DECIMAL(12,2)) AS Srom_NonNull_Pct
	 , IR_Invalid_PreAdmission, Meconium_Invalid_PreAdmission, SecondStage_Invalid_PreAdmission, Bradycardia_Invalid_PreAdmission, Epidural_Invalid_PreAdmission, Arom_Invalid_PreAdmission
	 , Arrest_Invalid_PreAdmission, Oligo_Invalid_PreAdmission, Poly_Invalid_PreAdmission, Prom_Invalid_PreAdmission, Protraction_Invalid_PreAdmission, Srom_Invalid_PreAdmission
	 , IR_Valid, Meconium_Valid, SecondStage_Valid, Bradycardia_Valid, Epidural_Valid, Arom_Valid, Arrest_Valid, Oligo_Valid, Poly_Valid, Prom_Valid, Protraction_Valid, Srom_Valid
FROM vStats
	CROSS APPLY TotalCases tc ),

vStats3 AS (
SELECT TotalCases
 , IR_Invalid_PostDelivery, CAST(IR_Invalid_PostDelivery / (TotalCases - IR_Null) AS DECIMAL(12,2))AS IR_Invalid_PostDelivery_Pct, IR_Null, IR_Null_Pct, IR_NonNull, IR_NonNull_Pct
 , Meconium_Invalid_PostDelivery, CAST(Meconium_Invalid_PostDelivery / (TotalCases - Meconium_Null) AS DECIMAL(12,2))AS Meconium_Invalid_PostDelivery_Pct, Meconium_Null, Meconium_Null_Pct, Meconium_NonNull, Meconium_NonNull_Pct
 , SecondStage_Invalid_PostDelivery, CAST(SecondStage_Invalid_PostDelivery / (TotalCases - SecondStage_Null) AS DECIMAL(12,2))AS SecondStage_Invalid_PostDelivery_Pct, SecondStage_Null, SecondStage_Null_Pct, SecondStage_NonNull, SecondStage_NonNull_Pct
 , Bradycardia_Invalid_PostDelivery, CAST(Bradycardia_Invalid_PostDelivery / (TotalCases - Bradycardia_Null) AS DECIMAL(12,2))AS Bradycardia_Invalid_PostDelivery_Pct, Bradycardia_Null, Bradycardia_Null_Pct, Bradycardia_NonNull, Bradycardia_NonNull_Pct
 , Epidural_Invalid_PostDelivery, CAST(Epidural_Invalid_PostDelivery / (TotalCases - Epidural_Null) AS DECIMAL(12,2))AS Epidural_Invalid_PostDelivery_Pct, Epidural_Null, Epidural_Null_Pct, Epidural_NonNull, Epidural_NonNull_Pct
 , Arom_Invalid_PostDelivery, CAST(Arom_Invalid_PostDelivery / (TotalCases - Arom_Null) AS DECIMAL(12,2))AS Arom_Invalid_PostDelivery_Pct, Arom_Null, Arom_Null_Pct, Arom_NonNull, Arom_NonNull_Pct
 , Arrest_Invalid_PostDelivery, CAST(Arrest_Invalid_PostDelivery / (TotalCases - Arrest_Null) AS DECIMAL(12,2))AS Arrest_Invalid_PostDelivery_Pct, Arrest_Null, Arrest_Null_Pct, Arrest_NonNull, Arrest_NonNull_Pct
 , Oligo_Invalid_PostDelivery, CAST(Oligo_Invalid_PostDelivery / (TotalCases - Oligo_Null) AS DECIMAL(12,2))AS Oligo_Invalid_PostDelivery_Pct, Oligo_Null, Oligo_Null_Pct, Oligo_NonNull, Oligo_NonNull_Pct
 , Poly_Invalid_PostDelivery, CAST(Poly_Invalid_PostDelivery / (TotalCases - Poly_Null) AS DECIMAL(12,2))AS Poly_Invalid_PostDelivery_Pct, Poly_Null, Poly_Null_Pct, Poly_NonNull, Poly_NonNull_Pct
 , Prom_Invalid_PostDelivery, CAST(Prom_Invalid_PostDelivery / (TotalCases - Prom_Null) AS DECIMAL(12,2))AS Prom_Invalid_PostDelivery_Pct, Prom_Null, Prom_Null_Pct, Prom_NonNull, Prom_NonNull_Pct
 , Protraction_Invalid_PostDelivery, CAST(Protraction_Invalid_PostDelivery / (TotalCases - Protraction_Null) AS DECIMAL(12,2))AS Protraction_Invalid_PostDelivery_Pct, Protraction_Null, Protraction_Null_Pct, Protraction_NonNull, Protraction_NonNull_Pct
 , Srom_Invalid_PostDelivery, CAST(Srom_Invalid_PostDelivery / (TotalCases - Srom_Null) AS DECIMAL(12,2))AS Srom_Invalid_PostDelivery_Pct, Srom_Null, Srom_Null_Pct, Srom_NonNull, Srom_NonNull_Pct
 , IR_Invalid_PreAdmission, CAST(IR_Invalid_PreAdmission / (TotalCases - IR_Null) AS DECIMAL(12,2))AS IR_Invalid_PreAdmission_Pct 
 , Meconium_Invalid_PreAdmission, CAST(Meconium_Invalid_PreAdmission / (TotalCases - Meconium_Null) AS DECIMAL(12,2))AS Meconium_Invalid_PreAdmission_Pct
 , SecondStage_Invalid_PreAdmission, CAST(SecondStage_Invalid_PreAdmission / (TotalCases - SecondStage_Null) AS DECIMAL(12,2))AS SecondStage_Invalid_PreAdmission_Pct
 , Bradycardia_Invalid_PreAdmission, CAST(Bradycardia_Invalid_PreAdmission / (TotalCases - Bradycardia_Null) AS DECIMAL(12,2))AS Bradycardia_Invalid_PreAdmission_Pct 
 , Epidural_Invalid_PreAdmission, CAST(Epidural_Invalid_PreAdmission / (TotalCases - Epidural_Null) AS DECIMAL(12,2))AS Epidural_Invalid_PreAdmission_Pct
 , Arom_Invalid_PreAdmission, CAST(Arom_Invalid_PreAdmission / (TotalCases - Arom_Null) AS DECIMAL(12,2))AS Arom_Invalid_PreAdmission_Pct 
 , Arrest_Invalid_PreAdmission, CAST(Arrest_Invalid_PreAdmission / (TotalCases - Arrest_Null) AS DECIMAL(12,2))AS Arrest_Invalid_PreAdmission_Pct
 , Oligo_Invalid_PreAdmission, CAST(Oligo_Invalid_PreAdmission / (TotalCases - Oligo_Null) AS DECIMAL(12,2))AS Oligo_Invalid_PreAdmission_Pct 
 , Poly_Invalid_PreAdmission, CAST(Poly_Invalid_PreAdmission / (TotalCases - Poly_Null) AS DECIMAL(12,2))AS Poly_Invalid_PreAdmission_Pct
 , Prom_Invalid_PreAdmission, CAST(Prom_Invalid_PreAdmission / (TotalCases - Prom_Null) AS DECIMAL(12,2))AS Prom_Invalid_PreAdmission_Pct 
 , Protraction_Invalid_PreAdmission, CAST(Protraction_Invalid_PreAdmission / (TotalCases - Protraction_Null) AS DECIMAL(12,2))AS Protraction_Invalid_PreAdmission_Pct
 , Srom_Invalid_PreAdmission, CAST(Srom_Invalid_PreAdmission / (TotalCases - Srom_Null) AS DECIMAL(12,2))AS Srom_Invalid_PreAdmission_Pct
 , IR_Valid, CAST(IR_Valid / (TotalCases - IR_Null) AS DECIMAL(12,2))AS IR_Valid_Pct 
 , Meconium_Valid, CAST(Meconium_Valid / (TotalCases - Meconium_Null) AS DECIMAL(12,2))AS Meconium_Valid_Pct
 , SecondStage_Valid, CAST(SecondStage_Valid / (TotalCases - SecondStage_Null) AS DECIMAL(12,2))AS SecondStage_Valid_Pct
 , Bradycardia_Valid, CAST(Bradycardia_Valid / (TotalCases - Bradycardia_Null) AS DECIMAL(12,2))AS Bradycardia_Valid_Pct 
 , Epidural_Valid, CAST(Epidural_Valid / (TotalCases - Epidural_Null) AS DECIMAL(12,2))AS Epidural_Valid_Pct
 , Arom_Valid, CAST(Arom_Valid / (TotalCases - Arom_Null) AS DECIMAL(12,2))AS Arom_Valid_Pct 
 , Arrest_Valid, CAST(Arrest_Valid / (TotalCases - Arrest_Null) AS DECIMAL(12,2))AS Arrest_Valid_Pct
 , Oligo_Valid, CAST(Oligo_Valid / (TotalCases - Oligo_Null) AS DECIMAL(12,2))AS Oligo_Valid_Pct 
 , Poly_Valid, CAST(Poly_Valid / (TotalCases - Poly_Null) AS DECIMAL(12,2))AS Poly_Valid_Pct
 , Prom_Valid, CAST(Prom_Valid / (TotalCases - Prom_Null) AS DECIMAL(12,2))AS Prom_Valid_Pct 
 , Protraction_Valid, CAST(Protraction_Valid / (TotalCases - Protraction_Null) AS DECIMAL(12,2))AS Protraction_Valid_Pct
 , Srom_Valid, CAST(Srom_Valid / (TotalCases - Srom_Null) AS DECIMAL(12,2))AS Srom_Valid_Pct
FROM vStats2)

SELECT CAST([IR_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [IR_Invalid_PostDelivery]
      ,CAST([IR_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [IR_Invalid_PostDelivery_Pct]
	  ,CAST([IR_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [IR_Invalid_Preadmission]
      ,CAST([IR_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [IR_Invalid_Preadmission_Pct]
      ,CAST([IR_Null] AS DECIMAL(12,2)) AS [IR_Null]
      ,CAST([IR_Null_Pct] AS DECIMAL(12,2)) AS [IR_Null_Pct]
	  ,CAST([IR_NonNull] AS DECIMAL(12,2)) AS [IR_NonNull]
      ,CAST([IR_NonNull_Pct] AS DECIMAL(12,2)) AS [IR_NonNull_Pct]
	  ,CAST([IR_Valid] AS DECIMAL(12,2)) AS [IR_Valid]
      ,CAST([IR_Valid_Pct] AS DECIMAL(12,2)) AS [IR_Valid_Pct]
		    ,CAST([Meconium_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Meconium_Invalid_PostDelivery]
      ,CAST([Meconium_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Meconium_Invalid_PostDelivery_Pct]
	  ,CAST([Meconium_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Meconium_Invalid_Preadmission]
      ,CAST([Meconium_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Meconium_Invalid_Preadmission_Pct]
      ,CAST([Meconium_Null] AS DECIMAL(12,2)) AS [Meconium_Null]
      ,CAST([Meconium_Null_Pct] AS DECIMAL(12,2)) AS [Meconium_Null_Pct]
	  ,CAST([Meconium_NonNull] AS DECIMAL(12,2)) AS [Meconium_NonNull]
      ,CAST([Meconium_NonNull_Pct] AS DECIMAL(12,2)) AS [Meconium_NonNull_Pct]
	  ,CAST([Meconium_Valid] AS DECIMAL(12,2)) AS [Meconium_Valid]
      ,CAST([Meconium_Valid_Pct] AS DECIMAL(12,2)) AS [Meconium_Valid_Pct]
	  		,CAST([SecondStage_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [SecondStage_Invalid_PostDelivery]
      ,CAST([SecondStage_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [SecondStage_Invalid_PostDelivery_Pct]
	  ,CAST([SecondStage_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [SecondStage_Invalid_Preadmission]
      ,CAST([SecondStage_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [SecondStage_Invalid_Preadmission_Pct]
      ,CAST([SecondStage_Null] AS DECIMAL(12,2)) AS [SecondStage_Null]
      ,CAST([SecondStage_Null_Pct] AS DECIMAL(12,2)) AS [SecondStage_Null_Pct]
	  ,CAST([SecondStage_NonNull] AS DECIMAL(12,2)) AS [SecondStage_NonNull]
      ,CAST([SecondStage_NonNull_Pct] AS DECIMAL(12,2)) AS [SecondStage_NonNull_Pct]
	  ,CAST([SecondStage_Valid] AS DECIMAL(12,2)) AS [SecondStage_Valid]
      ,CAST([SecondStage_Valid_Pct] AS DECIMAL(12,2)) AS [SecondStage_Valid_Pct]
	  		,CAST([Bradycardia_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Bradycardia_Invalid_PostDelivery]
      ,CAST([Bradycardia_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Bradycardia_Invalid_PostDelivery_Pct]
	  ,CAST([Bradycardia_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Bradycardia_Invalid_Preadmission]
      ,CAST([Bradycardia_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Bradycardia_Invalid_Preadmission_Pct]
      ,CAST([Bradycardia_Null] AS DECIMAL(12,2)) AS [Bradycardia_Null]
      ,CAST([Bradycardia_Null_Pct] AS DECIMAL(12,2)) AS [Bradycardia_Null_Pct]
	  ,CAST([Bradycardia_NonNull] AS DECIMAL(12,2)) AS [Bradycardia_NonNull]
      ,CAST([Bradycardia_NonNull_Pct] AS DECIMAL(12,2)) AS [Bradycardia_NonNull_Pct]
	  ,CAST([Bradycardia_Valid] AS DECIMAL(12,2)) AS [Bradycardia_Valid]
      ,CAST([Bradycardia_Valid_Pct] AS DECIMAL(12,2)) AS [Bradycardia_Valid_Pct]
	  		,CAST([Epidural_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Epidural_Invalid_PostDelivery]
      ,CAST([Epidural_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Epidural_Invalid_PostDelivery_Pct]
	  ,CAST([Epidural_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Epidural_Invalid_Preadmission]
      ,CAST([Epidural_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Epidural_Invalid_Preadmission_Pct]
      ,CAST([Epidural_Null] AS DECIMAL(12,2)) AS [Epidural_Null]
      ,CAST([Epidural_Null_Pct] AS DECIMAL(12,2)) AS [Epidural_Null_Pct]
	  ,CAST([Epidural_NonNull] AS DECIMAL(12,2)) AS [Epidural_NonNull]
      ,CAST([Epidural_NonNull_Pct] AS DECIMAL(12,2)) AS [Epidural_NonNull_Pct]
	  ,CAST([Epidural_Valid] AS DECIMAL(12,2)) AS [Epidural_Valid]
      ,CAST([Epidural_Valid_Pct] AS DECIMAL(12,2)) AS [Epidural_Valid_Pct]
	  		,CAST([Arom_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Arom_Invalid_PostDelivery]
      ,CAST([Arom_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Arom_Invalid_PostDelivery_Pct]
	  ,CAST([Arom_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Arom_Invalid_Preadmission]
      ,CAST([Arom_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Arom_Invalid_Preadmission_Pct]
      ,CAST([Arom_Null] AS DECIMAL(12,2)) AS [Arom_Null]
      ,CAST([Arom_Null_Pct] AS DECIMAL(12,2)) AS [Arom_Null_Pct]
	  ,CAST([Arom_NonNull] AS DECIMAL(12,2)) AS [Arom_NonNull]
      ,CAST([Arom_NonNull_Pct] AS DECIMAL(12,2)) AS [Arom_NonNull_Pct]
	  ,CAST([Arom_Valid] AS DECIMAL(12,2)) AS [Arom_Valid]
      ,CAST([Arom_Valid_Pct] AS DECIMAL(12,2)) AS [Arom_Valid_Pct]
	  		,CAST([Arrest_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Arrest_Invalid_PostDelivery]
      ,CAST([Arrest_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Arrest_Invalid_PostDelivery_Pct]
	  ,CAST([Arrest_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Arrest_Invalid_Preadmission]
      ,CAST([Arrest_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Arrest_Invalid_Preadmission_Pct]
      ,CAST([Arrest_Null] AS DECIMAL(12,2)) AS [Arrest_Null]
      ,CAST([Arrest_Null_Pct] AS DECIMAL(12,2)) AS [Arrest_Null_Pct]
	  ,CAST([Arrest_NonNull] AS DECIMAL(12,2)) AS [Arrest_NonNull]
      ,CAST([Arrest_NonNull_Pct] AS DECIMAL(12,2)) AS [Arrest_NonNull_Pct]
	  ,CAST([Arrest_Valid] AS DECIMAL(12,2)) AS [Arrest_Valid]
      ,CAST([Arrest_Valid_Pct] AS DECIMAL(12,2)) AS [Arrest_Valid_Pct]
	  		,CAST([Oligo_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Oligo_Invalid_PostDelivery]
      ,CAST([Oligo_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Oligo_Invalid_PostDelivery_Pct]
	  ,CAST([Oligo_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Oligo_Invalid_Preadmission]
      ,CAST([Oligo_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Oligo_Invalid_Preadmission_Pct]
      ,CAST([Oligo_Null] AS DECIMAL(12,2)) AS [Oligo_Null]
      ,CAST([Oligo_Null_Pct] AS DECIMAL(12,2)) AS [Oligo_Null_Pct]
	  ,CAST([Oligo_NonNull] AS DECIMAL(12,2)) AS [Oligo_NonNull]
      ,CAST([Oligo_NonNull_Pct] AS DECIMAL(12,2)) AS [Oligo_NonNull_Pct]
	  ,CAST([Oligo_Valid] AS DECIMAL(12,2)) AS [Oligo_Valid]
      ,CAST([Oligo_Valid_Pct] AS DECIMAL(12,2)) AS [Oligo_Valid_Pct]
	  		,CAST([Poly_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Poly_Invalid_PostDelivery]
      ,CAST([Poly_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Poly_Invalid_PostDelivery_Pct]
	  ,CAST([Poly_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Poly_Invalid_Preadmission]
      ,CAST([Poly_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Poly_Invalid_Preadmission_Pct]
      ,CAST([Poly_Null] AS DECIMAL(12,2)) AS [Poly_Null]
      ,CAST([Poly_Null_Pct] AS DECIMAL(12,2)) AS [Poly_Null_Pct]
	  ,CAST([Poly_NonNull] AS DECIMAL(12,2)) AS [Poly_NonNull]
      ,CAST([Poly_NonNull_Pct] AS DECIMAL(12,2)) AS [Poly_NonNull_Pct]
	  ,CAST([Poly_Valid] AS DECIMAL(12,2)) AS [Poly_Valid]
      ,CAST([Poly_Valid_Pct] AS DECIMAL(12,2)) AS [Poly_Valid_Pct]
	  		,CAST([Prom_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Prom_Invalid_PostDelivery]
      ,CAST([Prom_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Prom_Invalid_PostDelivery_Pct]
	  ,CAST([Prom_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Prom_Invalid_Preadmission]
      ,CAST([Prom_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Prom_Invalid_Preadmission_Pct]
      ,CAST([Prom_Null] AS DECIMAL(12,2)) AS [Prom_Null]
      ,CAST([Prom_Null_Pct] AS DECIMAL(12,2)) AS [Prom_Null_Pct]
	  ,CAST([Prom_NonNull] AS DECIMAL(12,2)) AS [Prom_NonNull]
      ,CAST([Prom_NonNull_Pct] AS DECIMAL(12,2)) AS [Prom_NonNull_Pct]
	  ,CAST([Prom_Valid] AS DECIMAL(12,2)) AS [Prom_Valid]
      ,CAST([Prom_Valid_Pct] AS DECIMAL(12,2)) AS [Prom_Valid_Pct]
	  		,CAST([Protraction_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Protraction_Invalid_PostDelivery]
      ,CAST([Protraction_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Protraction_Invalid_PostDelivery_Pct]
	  ,CAST([Protraction_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Protraction_Invalid_Preadmission]
      ,CAST([Protraction_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Protraction_Invalid_Preadmission_Pct]
      ,CAST([Protraction_Null] AS DECIMAL(12,2)) AS [Protraction_Null]
      ,CAST([Protraction_Null_Pct] AS DECIMAL(12,2)) AS [Protraction_Null_Pct]
	  ,CAST([Protraction_NonNull] AS DECIMAL(12,2)) AS [Protraction_NonNull]
      ,CAST([Protraction_NonNull_Pct] AS DECIMAL(12,2)) AS [Protraction_NonNull_Pct]
	  ,CAST([Protraction_Valid] AS DECIMAL(12,2)) AS [Protraction_Valid]
      ,CAST([Protraction_Valid_Pct] AS DECIMAL(12,2)) AS [Protraction_Valid_Pct]
	  		,CAST([Srom_Invalid_PostDelivery] AS DECIMAL(12,2)) AS [Srom_Invalid_PostDelivery]
      ,CAST([Srom_Invalid_PostDelivery_Pct] AS DECIMAL(12,2)) AS [Srom_Invalid_PostDelivery_Pct]
	  ,CAST([Srom_Invalid_PreAdmission] AS DECIMAL(12,2)) AS [Srom_Invalid_Preadmission]
      ,CAST([Srom_Invalid_PreAdmission_Pct] AS DECIMAL(12,2)) AS [Srom_Invalid_Preadmission_Pct]
      ,CAST([Srom_Null] AS DECIMAL(12,2)) AS [Srom_Null]
      ,CAST([Srom_Null_Pct] AS DECIMAL(12,2)) AS [Srom_Null_Pct]
	  ,CAST([Srom_NonNull] AS DECIMAL(12,2)) AS [Srom_NonNull]
      ,CAST([Srom_NonNull_Pct] AS DECIMAL(12,2)) AS [Srom_NonNull_Pct]
	  ,CAST([Srom_Valid] AS DECIMAL(12,2)) AS [Srom_Valid]
      ,CAST([Srom_Valid_Pct] AS DECIMAL(12,2)) AS [Srom_Valid_Pct]
	  
	  
FROM vStats3