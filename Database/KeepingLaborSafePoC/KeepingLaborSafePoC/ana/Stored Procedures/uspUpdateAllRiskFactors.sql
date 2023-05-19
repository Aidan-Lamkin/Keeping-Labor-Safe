CREATE PROCEDURE [ana].[uspUpdateAllRiskFactors]
AS 
BEGIN

	SET NOCOUNT ON;

	DROP TABLE IF EXISTS #RiskFactorCalc;
	CREATE TABLE #RiskFactorCalc 
	( CaseID INT
	, CaseFrameSeqID INT
	, FrameStartDateTime DATETIME2(0)
	, FrameEndDateTime DATETIME2(0)
	, FinalMaternalRF BIT
	, FinalObstetricalRF BIT
	, FinalFetalRF BIT 
	, m_ExecutionDt DATETIME2(0) DEFAULT GETUTCDATE()
	)

	DECLARE @Query VARCHAR(MAX) = 'INSERT INTO #RiskFactorCalc 
									( CaseID
									, CaseFrameSeqID
									, FrameStartDateTime
									, FrameEndDateTime
									, FinalMaternalRF
									, FinalObstetricalRF
									, FinalFetalRF) '
	
	SELECT @Query += 'SELECT CaseID
						   , CaseFrameSeqID
						   , FrameStartDateTime
						   , FrameEndDateTime '
	SELECT @Query += ', MAX(CASE '
	SELECT @Query += 'WHEN ' + RiskFactorKey + ' = 1 THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1	
		AND RiskFactorGroupID = 1 -- Maternal final Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' WHEN MaternalRF = 1 THEN 1 ELSE 0 END) AS FinalMaternalRF '
	SELECT @Query += ', MAX(CASE '
	SELECT @Query += ' WHEN ' + RiskFactorKey + ' = 1 THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical final Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' WHEN ObstetricalRF = 1 THEN 1 ELSE 0 END) AS FinalObstetricalRF '
	SELECT @Query += ', MAX(CASE '
	SELECT @Query += ' WHEN ' + RiskFactorKey + ' = 1 THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal final Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' WHEN FetalRF = 1 THEN 1 ELSE 0 END) AS FinalFetalRF '
	SELECT @Query += ' FROM (SELECT arf.CaseID
							      , frm.CaseFrameSeqID
								  , frm.FrameStartDateTime
								  , frm.FrameEndDateTime '
	SELECT @Query += ',	MAX(CASE WHEN frm.FrameStartDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') OR frm.FrameEndDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') THEN 1 ELSE 0 END) AS ' + RiskFactorKey
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal datetime Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ',	MAX(CASE WHEN frm.FrameStartDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') OR frm.FrameEndDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') THEN 1 ELSE 0 END) AS ' + RiskFactorKey
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical datetime Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ',	MAX(CASE WHEN frm.FrameStartDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') OR frm.FrameEndDateTime >= CAST(' + RiskFactorKey + ' AS ' + DataType + ') THEN 1 ELSE 0 END) AS ' + RiskFactorKey
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal datetime Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' , MAX(CASE '
	SELECT @Query += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal non-datetime Risk Factors
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' ELSE 0 END) AS MaternalRF, MAX(CASE '
	SELECT @Query += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical non-datetime Risk Factors
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' ELSE 0 END) AS ObstetricalRF, MAX(CASE '
	SELECT @Query += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal BIT non-datetime Factors
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 1
	SELECT @Query += ' ELSE 0 END) AS FetalRF 
		FROM dbo.vwAllRiskFactors arf 
			LEFT JOIN ana.tKlsFrame10Min frm 
				ON arf.CaseID = frm.CaseID 
		WHERE arf.CaseID IN (SELECT CaseID 
							 FROM dbo.tKlsCase 
							 WHERE m_IsEnabled = 1) 
		GROUP BY arf.CaseID
			   , frm.CaseFrameSeqID
			   , frm.FrameStartDateTime
			   , frm.FrameEndDateTime ) fin 
	GROUP BY CaseID, CaseFrameSeqID, FrameStartDateTime, FrameEndDateTime'

	--PRINT @Query
	EXEC(@Query)

	-- Update last 10-minute segments for cases with DateTime risk factors showing up after delivery 

	DECLARE @LateEntryMaternalUpdateQuery VARCHAR(MAX) = '
			UPDATE rfc SET FinalMaternalRF = 1 
			FROM #RiskFactorCalc rfc 
				INNER JOIN dbo.vwAllRiskFactors arf 
					ON rfc.CaseID = arf.CaseID 
				INNER JOIN (SELECT CaseID
								 , MAX(CaseFrameSeqID) AS MaxCaseFrameSeqID 
							FROM ana.tKlsFrame10Min 
							GROUP BY CaseID) mcf 
					ON arf.CaseID = mcf.CaseID 
				INNER JOIN dbo.tKlsCase cs
					ON mcf.CaseID = cs.CaseID
			WHERE (rfc.CaseID = mcf.CaseID AND rfc.CaseFrameSeqID = mcf.MaxCaseFrameSeqID) 
				AND ('
	SELECT @LateEntryMaternalUpdateQuery += ' arf.' + RiskFactorKey + ' > cs.CaseEndDateTime OR ' 
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1	
		AND RiskFactorGroupID = 1 -- Maternal final Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1 
	
	IF RIGHT(@LateEntryMaternalUpdateQuery, 5) <> 'AND (' 
	BEGIN
		SET @LateEntryMaternalUpdateQuery = LEFT(@LateEntryMaternalUpdateQuery, LEN(@LateEntryMaternalUpdateQuery) - 3) + ')'
		--PRINT @LateEntryMaternalUpdateQuery
		EXEC(@LateEntryMaternalUpdateQuery)
	END
	

	DECLARE @LateEntryObstetricalUpdateQuery VARCHAR(MAX) = '
			UPDATE rfc SET FinalObstetricalRF = 1 
			FROM #RiskFactorCalc rfc 
				INNER JOIN dbo.vwAllRiskFactors arf 
					ON rfc.CaseID = arf.CaseID 
				INNER JOIN (SELECT CaseID
								 , MAX(CaseFrameSeqID) AS MaxCaseFrameSeqID 
							FROM ana.tKlsFrame10Min 
							GROUP BY CaseID) mcf 
					ON arf.CaseID = mcf.CaseID 
				INNER JOIN dbo.tKlsCase cs
					ON mcf.CaseID = cs.CaseID
			WHERE (rfc.CaseID = mcf.CaseID AND rfc.CaseFrameSeqID = mcf.MaxCaseFrameSeqID) 
				AND ('
	SELECT @LateEntryObstetricalUpdateQuery += ' arf.' + RiskFactorKey + ' > cs.CaseEndDateTime OR ' 
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1	
		AND RiskFactorGroupID = 2 -- Obstetrical final Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1 
	
	IF RIGHT(@LateEntryObstetricalUpdateQuery, 5) <> 'AND (' 
	BEGIN
		SET @LateEntryObstetricalUpdateQuery = LEFT(@LateEntryObstetricalUpdateQuery, LEN(@LateEntryObstetricalUpdateQuery) - 3) + ')'
		--PRINT @LateEntryObstetricalUpdateQuery
		EXEC(@LateEntryObstetricalUpdateQuery)
	END

	DECLARE @LateEntryFetalUpdateQuery VARCHAR(MAX) = '
			UPDATE rfc SET FinalFetalRF = 1 
			FROM #RiskFactorCalc rfc 
				INNER JOIN dbo.vwAllRiskFactors arf 
					ON rfc.CaseID = arf.CaseID 
				INNER JOIN (SELECT CaseID
								 , MAX(CaseFrameSeqID) AS MaxCaseFrameSeqID 
							FROM ana.tKlsFrame10Min 
							GROUP BY CaseID) mcf 
					ON arf.CaseID = mcf.CaseID 
				INNER JOIN dbo.tKlsCase cs
					ON mcf.CaseID = cs.CaseID
			WHERE (rfc.CaseID = mcf.CaseID AND rfc.CaseFrameSeqID = mcf.MaxCaseFrameSeqID) 
				AND ('
	SELECT @LateEntryFetalUpdateQuery += ' arf.' + RiskFactorKey + ' > cs.CaseEndDateTime OR ' 
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1	
		AND RiskFactorGroupID = 3 -- Fetal final Risk Factors
		AND DataType = 'DATETIME2(0)'
		AND Rnk = 1 
	
	IF RIGHT(@LateEntryFetalUpdateQuery, 5) <> 'AND (' 
	BEGIN
		SET @LateEntryFetalUpdateQuery = LEFT(@LateEntryFetalUpdateQuery, LEN(@LateEntryFetalUpdateQuery) - 3) + ')'
		--PRINT @LateEntryFetalUpdateQuery
		EXEC(@LateEntryFetalUpdateQuery)
	END

	-- Update calc table based on any Rank 2 risk factor columns 
	DECLARE @MaternalUpdateQuery VARCHAR(MAX) = '; WITH upd AS (SELECT t.CaseID, MAX(CASE '
	SELECT @MaternalUpdateQuery += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2
	SELECT @MaternalUpdateQuery += ' WHEN FinalMaternalRF = 1 THEN 1 ELSE 0 END) AS MaternalRF '
	SELECT @MaternalUpdateQuery += 'FROM #RiskFactorCalc t 
										INNER JOIN dbo.vwAllRiskFactors fac
											 ON t.CaseID = fac.CaseID 
									GROUP BY t.CaseID) '
	SELECT @MaternalUpdateQuery += 'UPDATE t 
									SET FinalMaternalRF = u.MaternalRF
									  , t.m_ExecutionDt = GETUTCDATE() 
									FROM #RiskFactorCalc t 
										INNER JOIN upd u 
											ON t.CaseID = u.CaseID 
										INNER JOIN dbo.vwAllRiskFactors fac 
											ON u.CaseID = fac.CaseID 
										INNER JOIN dbo.tKlsCase cas 
											ON fac.CaseID = cas.CaseID 
									WHERE (t.FinalMaternalRF <> u.MaternalRF) '
	SELECT @MaternalUpdateQuery += COALESCE((SELECT TOP 1  'AND ( '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2), '')
	SELECT @MaternalUpdateQuery += ' (fac.' + RiskFactorKey + ' = 1 AND fac.' + RiskFactorKey + '_DT IS NULL) OR '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 1 -- Maternal non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2
	SET @MaternalUpdateQuery = CASE WHEN RIGHT (@MaternalUpdateQuery, 3) = 'OR ' THEN LEFT(@MaternalUpdateQuery, LEN(@MaternalUpdateQuery) - 3) + ')' ELSE @MaternalUpdateQuery END
	--PRINT @MaternalUpdateQuery
	EXEC(@MaternalUpdateQuery)

	--WAITFOR DELAY '00:00:10'

	DECLARE @ObstetricalUpdateQuery VARCHAR(MAX) = '; WITH upd AS (SELECT t.CaseID, MAX(CASE '
	SELECT @ObstetricalUpdateQuery += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2
	SELECT @ObstetricalUpdateQuery += ' WHEN FinalObstetricalRF = 1 THEN 1 ELSE 0 END) AS ObstetricalRF '
	SELECT @ObstetricalUpdateQuery +=  'FROM #RiskFactorCalc t 
										    INNER JOIN dbo.vwAllRiskFactors fac 
												ON t.CaseID = fac.CaseID 
										GROUP BY t.CaseID) '
	SELECT @ObstetricalUpdateQuery +=  'UPDATE t 
										SET FinalObstetricalRF = u.ObstetricalRF
										  , t.m_ExecutionDt = GETUTCDATE() 
										FROM #RiskFactorCalc t 
											INNER JOIN upd u 
												ON t.CaseID = u.CaseID 
											INNER JOIN dbo.vwAllRiskFactors fac 
												ON u.CaseID = fac.CaseID
											INNER JOIN dbo.tKlsCase cas 
												ON fac.CaseID = cas.CaseID 
										WHERE (t.FinalObstetricalRF <> u.ObstetricalRF) '
	SELECT @ObstetricalUpdateQuery += COALESCE((SELECT TOP 1  'AND ( '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2), '')
	SELECT @ObstetricalUpdateQuery +=  ' (fac.' + RiskFactorKey + ' = 1 AND fac.' + RiskFactorKey + '_DT IS NULL) OR '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 2 -- Obstetrical non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2
	SET @ObstetricalUpdateQuery = CASE WHEN RIGHT (@ObstetricalUpdateQuery, 3) = 'OR ' THEN LEFT(@ObstetricalUpdateQuery, LEN(@ObstetricalUpdateQuery) - 3) + ')' ELSE @ObstetricalUpdateQuery END
	--PRINT @ObstetricalUpdateQuery
	EXEC(@ObstetricalUpdateQuery)

	--WAITFOR DELAY '00:00:10'
	
	DECLARE @FetalUpdateQuery VARCHAR(MAX) = '; WITH upd AS (SELECT t.CaseID, MAX(CASE '
	SELECT @FetalUpdateQuery += 'WHEN CAST(' + RiskFactorKey + ' AS ' + DataType + ') ' + RangeFilter + ' THEN 1 '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2
	SELECT @FetalUpdateQuery += ' WHEN FinalFetalRF = 1 THEN 1 ELSE 0 END) AS FetalRF '
	SELECT @FetalUpdateQuery +='FROM #RiskFactorCalc t 
									INNER JOIN dbo.vwAllRiskFactors fac 
										ON t.CaseID = fac.CaseID 
								GROUP BY t.CaseID) '
	SELECT @FetalUpdateQuery +='UPDATE t 
								SET FinalFetalRF = u.FetalRF
								  , t.m_ExecutionDt = GETUTCDATE() 
								FROM #RiskFactorCalc t 
									INNER JOIN upd u 
										ON t.CaseID = u.CaseID 
									INNER JOIN dbo.vwAllRiskFactors fac 
										ON u.CaseID = fac.CaseID 
									INNER JOIN dbo.tKlsCase cas 
										ON fac.CaseID = cas.CaseID 
								WHERE (t.FinalFetalRF <> u.FetalRF) '
	SELECT @FetalUpdateQuery += COALESCE((SELECT TOP 1  'AND ( '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2), '')
	SELECT @FetalUpdateQuery +=  ' (fac.' + RiskFactorKey + ' = 1 AND fac.' + RiskFactorKey + '_DT IS NULL) OR '
	FROM ref.tRiskFactor
	WHERE m_IsEnabled = 1
		AND RiskFactorGroupID = 3 -- Fetal non-datetime Risk Factors Rnk 2
		AND DataType <> 'DATETIME2(0)'
		AND Rnk = 2
	SET @FetalUpdateQuery = CASE WHEN RIGHT (@FetalUpdateQuery, 3) = 'OR ' THEN LEFT(@FetalUpdateQuery, LEN(@FetalUpdateQuery) - 3) + ')' ELSE @FetalUpdateQuery END 
	--PRINT @FetalUpdateQuery
	EXEC(@FetalUpdateQuery)

	-- Update ana table from calc table 

	UPDATE frm
		SET bMaternalRiskFactor = CASE WHEN clc.FinalMaternalRF = 1 THEN 0 ELSE 1 END -- flip bit because 1 is good and 0 is bad for FRI calculations later on
		  , bObstetricalRiskFactor = CASE WHEN clc.FinalObstetricalRF = 1 THEN 0 ELSE 1 END
		  , bFetalRiskFactor = CASE WHEN clc.FinalFetalRF = 1 THEN 0 ELSE 1 END
		  , m_ExecutionDt = GETUTCDATE()
	FROM ana.tKlsFrame10Min frm
		INNER join #RiskFactorCalc clc
			ON frm.CaseFrameSeqID = clc.CaseFrameSeqID
				AND frm.CaseID = clc.CaseID

	-- Drop temp table 

	DROP TABLE IF EXISTS #RiskFactorCalc;

END