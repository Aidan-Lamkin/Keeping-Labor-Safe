﻿
/* DEPRECATED */
/* No longer need to transform into app.tKlsSample table for scoring (Phase 2) */

----/* Uses DInsert pattern to load or reload unpivoted sample data by case into an input table for analysis */

CREATE PROC [dep].[uspStoreKlsSampleByCase] 
	 @CaseID INT 
AS
BEGIN

	SET NOCOUNT ON;
	
	DELETE FROM app.tKlsSample WHERE CaseID = @CaseID;

	INSERT INTO app.tKlsSample
	SELECT CaseID, ROW_NUMBER() OVER (PARTITION BY CaseID ORDER BY SampleDateTime) AS SeqID, SampleDateTime, MetricKey, MetricSourceKey, [Value], GETUTCDATE()
		FROM (
			SELECT CaseID, DATEADD(MILLISECOND, ([Interval] - 1) * 250, CAST(SampleDate AS DATETIMEOFFSET(2))) AS SampleDateTime, smpl.MetricKey, smpl.MetricSourceKey, smpl.[Value], smpl.m_ExecutionDt
			FROM (
				SELECT CaseID, SampleDate, MetricKey, MetricSourceKey, Value, m_ExecutionDt, ROW_NUMBER() OVER (PARTITION BY SampleDate, MetricKey, MetricSourceKey ORDER BY (SELECT 0)) AS Interval
				FROM 
					(SELECT ksd.CaseID
						,[SampleDate]
						,[MetricKey]
						,[MetricSourceKey]
						,[Int_0]
						,[Int_1]
						,[Int_2]
						,[Int_3]
						,[Int_4]
						,[Int_5]
						,[Int_6]
						,[Int_7]
						,[Int_8]
						,[Int_9]
						,[Int_10]
						,[Int_11]
						,[Int_12]
						,[Int_13]
						,[Int_14]
						,[Int_15]
						,[Int_16]
						,[Int_17]
						,[Int_18]
						,[Int_19]
						,[Int_20]
						,[Int_21]
						,[Int_22]
						,[Int_23]
						,[Int_24]
						,[Int_25]
						,[Int_26]
						,[Int_27]
						,[Int_28]
						,[Int_29]
						,[Int_30]
						,[Int_31]
						,[Int_32]
						,[Int_33]
						,[Int_34]
						,[Int_35]
						,[Int_36]
						,[Int_37]
						,[Int_38]
						,[Int_39]
						,[Int_40]
						,[Int_41]
						,[Int_42]
						,[Int_43]
						,[Int_44]
						,[Int_45]
						,[Int_46]
						,[Int_47]
						,[Int_48]
						,[Int_49]
						,[Int_50]
						,[Int_51]
						,[Int_52]
						,[Int_53]
						,[Int_54]
						,[Int_55]
						,[Int_56]
						,[Int_57]
						,[Int_58]
						,[Int_59]
						,[Int_60]
						,[Int_61]
						,[Int_62]
						,[Int_63]
						,[Int_64]
						,[Int_65]
						,[Int_66]
						,[Int_67]
						,[Int_68]
						,[Int_69]
						,[Int_70]
						,[Int_71]
						,[Int_72]
						,[Int_73]
						,[Int_74]
						,[Int_75]
						,[Int_76]
						,[Int_77]
						,[Int_78]
						,[Int_79]
						,[Int_80]
						,[Int_81]
						,[Int_82]
						,[Int_83]
						,[Int_84]
						,[Int_85]
						,[Int_86]
						,[Int_87]
						,[Int_88]
						,[Int_89]
						,[Int_90]
						,[Int_91]
						,[Int_92]
						,[Int_93]
						,[Int_94]
						,[Int_95]
						,[Int_96]
						,[Int_97]
						,[Int_98]
						,[Int_99]
						,[Int_100]
						,[Int_101]
						,[Int_102]
						,[Int_103]
						,[Int_104]
						,[Int_105]
						,[Int_106]
						,[Int_107]
						,[Int_108]
						,[Int_109]
						,[Int_110]
						,[Int_111]
						,[Int_112]
						,[Int_113]
						,[Int_114]
						,[Int_115]
						,[Int_116]
						,[Int_117]
						,[Int_118]
						,[Int_119]
						,[Int_120]
						,[Int_121]
						,[Int_122]
						,[Int_123]
						,[Int_124]
						,[Int_125]
						,[Int_126]
						,[Int_127]
						,[Int_128]
						,[Int_129]
						,[Int_130]
						,[Int_131]
						,[Int_132]
						,[Int_133]
						,[Int_134]
						,[Int_135]
						,[Int_136]
						,[Int_137]
						,[Int_138]
						,[Int_139]
						,[Int_140]
						,[Int_141]
						,[Int_142]
						,[Int_143]
						,[Int_144]
						,[Int_145]
						,[Int_146]
						,[Int_147]
						,[Int_148]
						,[Int_149]
						,[Int_150]
						,[Int_151]
						,[Int_152]
						,[Int_153]
						,[Int_154]
						,[Int_155]
						,[Int_156]
						,[Int_157]
						,[Int_158]
						,[Int_159]
						,[Int_160]
						,[Int_161]
						,[Int_162]
						,[Int_163]
						,[Int_164]
						,[Int_165]
						,[Int_166]
						,[Int_167]
						,[Int_168]
						,[Int_169]
						,[Int_170]
						,[Int_171]
						,[Int_172]
						,[Int_173]
						,[Int_174]
						,[Int_175]
						,[Int_176]
						,[Int_177]
						,[Int_178]
						,[Int_179]
						,[Int_180]
						,[Int_181]
						,[Int_182]
						,[Int_183]
						,[Int_184]
						,[Int_185]
						,[Int_186]
						,[Int_187]
						,[Int_188]
						,[Int_189]
						,[Int_190]
						,[Int_191]
						,[Int_192]
						,[Int_193]
						,[Int_194]
						,[Int_195]
						,[Int_196]
						,[Int_197]
						,[Int_198]
						,[Int_199]
						,[Int_200]
						,[Int_201]
						,[Int_202]
						,[Int_203]
						,[Int_204]
						,[Int_205]
						,[Int_206]
						,[Int_207]
						,[Int_208]
						,[Int_209]
						,[Int_210]
						,[Int_211]
						,[Int_212]
						,[Int_213]
						,[Int_214]
						,[Int_215]
						,[Int_216]
						,[Int_217]
						,[Int_218]
						,[Int_219]
						,[Int_220]
						,[Int_221]
						,[Int_222]
						,[Int_223]
						,[Int_224]
						,[Int_225]
						,[Int_226]
						,[Int_227]
						,[Int_228]
						,[Int_229]
						,[Int_230]
						,[Int_231]
						,[Int_232]
						,[Int_233]
						,[Int_234]
						,[Int_235]
						,[Int_236]
						,[Int_237]
						,[Int_238]
						,[Int_239]
						,ksd.[m_ExecutionDt]
					FROM [dbo].[tKlsSampleData] ksd
						INNER JOIN dbo.tKlsCase cs
							ON ksd.CaseID = cs.CaseID
					WHERE cs.CaseID = @CaseID
						AND ksd.SampleDate BETWEEN cs.CaseStartDateTime AND cs.CaseEndDateTime) AS smpl
				UNPIVOT
				(
					[Value] FOR Intervals IN (	[Int_0]
												,[Int_1]
												,[Int_2]
												,[Int_3]
												,[Int_4]
												,[Int_5]
												,[Int_6]
												,[Int_7]
												,[Int_8]
												,[Int_9]
												,[Int_10]
												,[Int_11]
												,[Int_12]
												,[Int_13]
												,[Int_14]
												,[Int_15]
												,[Int_16]
												,[Int_17]
												,[Int_18]
												,[Int_19]
												,[Int_20]
												,[Int_21]
												,[Int_22]
												,[Int_23]
												,[Int_24]
												,[Int_25]
												,[Int_26]
												,[Int_27]
												,[Int_28]
												,[Int_29]
												,[Int_30]
												,[Int_31]
												,[Int_32]
												,[Int_33]
												,[Int_34]
												,[Int_35]
												,[Int_36]
												,[Int_37]
												,[Int_38]
												,[Int_39]
												,[Int_40]
												,[Int_41]
												,[Int_42]
												,[Int_43]
												,[Int_44]
												,[Int_45]
												,[Int_46]
												,[Int_47]
												,[Int_48]
												,[Int_49]
												,[Int_50]
												,[Int_51]
												,[Int_52]
												,[Int_53]
												,[Int_54]
												,[Int_55]
												,[Int_56]
												,[Int_57]
												,[Int_58]
												,[Int_59]
												,[Int_60]
												,[Int_61]
												,[Int_62]
												,[Int_63]
												,[Int_64]
												,[Int_65]
												,[Int_66]
												,[Int_67]
												,[Int_68]
												,[Int_69]
												,[Int_70]
												,[Int_71]
												,[Int_72]
												,[Int_73]
												,[Int_74]
												,[Int_75]
												,[Int_76]
												,[Int_77]
												,[Int_78]
												,[Int_79]
												,[Int_80]
												,[Int_81]
												,[Int_82]
												,[Int_83]
												,[Int_84]
												,[Int_85]
												,[Int_86]
												,[Int_87]
												,[Int_88]
												,[Int_89]
												,[Int_90]
												,[Int_91]
												,[Int_92]
												,[Int_93]
												,[Int_94]
												,[Int_95]
												,[Int_96]
												,[Int_97]
												,[Int_98]
												,[Int_99]
												,[Int_100]
												,[Int_101]
												,[Int_102]
												,[Int_103]
												,[Int_104]
												,[Int_105]
												,[Int_106]
												,[Int_107]
												,[Int_108]
												,[Int_109]
												,[Int_110]
												,[Int_111]
												,[Int_112]
												,[Int_113]
												,[Int_114]
												,[Int_115]
												,[Int_116]
												,[Int_117]
												,[Int_118]
												,[Int_119]
												,[Int_120]
												,[Int_121]
												,[Int_122]
												,[Int_123]
												,[Int_124]
												,[Int_125]
												,[Int_126]
												,[Int_127]
												,[Int_128]
												,[Int_129]
												,[Int_130]
												,[Int_131]
												,[Int_132]
												,[Int_133]
												,[Int_134]
												,[Int_135]
												,[Int_136]
												,[Int_137]
												,[Int_138]
												,[Int_139]
												,[Int_140]
												,[Int_141]
												,[Int_142]
												,[Int_143]
												,[Int_144]
												,[Int_145]
												,[Int_146]
												,[Int_147]
												,[Int_148]
												,[Int_149]
												,[Int_150]
												,[Int_151]
												,[Int_152]
												,[Int_153]
												,[Int_154]
												,[Int_155]
												,[Int_156]
												,[Int_157]
												,[Int_158]
												,[Int_159]
												,[Int_160]
												,[Int_161]
												,[Int_162]
												,[Int_163]
												,[Int_164]
												,[Int_165]
												,[Int_166]
												,[Int_167]
												,[Int_168]
												,[Int_169]
												,[Int_170]
												,[Int_171]
												,[Int_172]
												,[Int_173]
												,[Int_174]
												,[Int_175]
												,[Int_176]
												,[Int_177]
												,[Int_178]
												,[Int_179]
												,[Int_180]
												,[Int_181]
												,[Int_182]
												,[Int_183]
												,[Int_184]
												,[Int_185]
												,[Int_186]
												,[Int_187]
												,[Int_188]
												,[Int_189]
												,[Int_190]
												,[Int_191]
												,[Int_192]
												,[Int_193]
												,[Int_194]
												,[Int_195]
												,[Int_196]
												,[Int_197]
												,[Int_198]
												,[Int_199]
												,[Int_200]
												,[Int_201]
												,[Int_202]
												,[Int_203]
												,[Int_204]
												,[Int_205]
												,[Int_206]
												,[Int_207]
												,[Int_208]
												,[Int_209]
												,[Int_210]
												,[Int_211]
												,[Int_212]
												,[Int_213]
												,[Int_214]
												,[Int_215]
												,[Int_216]
												,[Int_217]
												,[Int_218]
												,[Int_219]
												,[Int_220]
												,[Int_221]
												,[Int_222]
												,[Int_223]
												,[Int_224]
												,[Int_225]
												,[Int_226]
												,[Int_227]
												,[Int_228]
												,[Int_229]
												,[Int_230]
												,[Int_231]
												,[Int_232]
												,[Int_233]
												,[Int_234]
												,[Int_235]
												,[Int_236]
												,[Int_237]
												,[Int_238]
												,[Int_239])) as piv
							) AS smpl
						)AS smpl2

END