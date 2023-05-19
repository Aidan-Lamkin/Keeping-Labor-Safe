
CREATE VIEW [app].[vwSamplePivot] 
AS
SELECT piv.*, CAST(piv.CaseID AS VARCHAR(128)) + '|' + CAST(piv.CaseFrameSeqID AS VARCHAR(128)) AS CaseFrameKey, frm.FrameStartDateTime, frm.FrameEndDateTime, frm.FHRBaselineBPM, frm.UABaseline, frm.FHRThreshold, frm.UAThreshold
FROM app.tKlsSample_Pivot piv
	INNER JOIN ana.tKlsFrame10Min frm
		ON piv.CaseID = frm.CaseID 
			AND piv.SampleDateTime BETWEEN frm.FrameStartDateTime AND frm.FrameEndDateTime