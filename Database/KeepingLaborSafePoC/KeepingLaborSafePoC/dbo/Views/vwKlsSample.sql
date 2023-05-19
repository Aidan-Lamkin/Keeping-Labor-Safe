
CREATE view [dbo].[vwKlsSample]
as

	SELECT CaseID, SampleDateTime ,MAX(UA)  AS UA, MAX(HR) AS HR, MAX(HR2) AS HR2, MAX(MHR) AS MHR, MAX(m_ExecutionDt) as m_ExecutionDt
	FROM (
	SELECT pvt.CaseID, SampleDateTime, [UA], [HR], [HR2], [MHR], m_ExecutionDt
	FROM dbo.vwTransformKlsSampleData
	PIVOT 
		(
			MAX([Value])
			FOR MetricKey in ([UA], [HR], [HR2], [MHR])

		) pvt
	) as t
	group by CaseID, SampleDateTime