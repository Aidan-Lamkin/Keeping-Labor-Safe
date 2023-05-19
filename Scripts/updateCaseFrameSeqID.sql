/* add CaseFrameSeqID from frame table */

UPDATE aklsn
SET CaseFrameSeqID = frm.CaseFrameSeqID
FROM app.tKlsSample_Pivot_New aklsn
	INNER JOIN ana.tKlsFrame10Min_New frm
		ON aklsn.CaseID = frm.CaseID
			AND aklsn.SampleDateTime BETWEEN frm.FrameStartDateTime AND frm.FrameEndDateTime
WHERE aklsn.CaseID = 28

select count(*) from app.tKlsSample_Pivot_New
where CaseFrameSeqID is null