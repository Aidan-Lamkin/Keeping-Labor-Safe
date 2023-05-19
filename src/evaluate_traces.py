# -*- coding: utf-8 -*-
"""
Created on Wed Oct 30 15:14:55 2019

Keeping Labor Safe (KLS)
Automated looped evaluation of traces for parameter range testing.
All executed locally on a copy of the trace data.

@author: Lucas Finco - lfinco
Insight Digital Innovation
"""

import sqlalchemy
import pandas as pd
import numpy as np
#import pdb
from tqdm import tqdm

# import KLS helper functions
import kls

# Max rows in display
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 180)

from IPython import get_ipython
get_ipython().magic('who print')

###############################
########## Constants ##########
###############################

# Data Quality
# Percentage of data in 10 minute segment greater than this or do not score
PERC_DATA_AVAIL = 0.90

# UA
# UA Threshold of time, in seconds, that UA must maintain above threshold to be
# called a contraction.
MIN_CONTRACTION_TIME = 10

# UA Threshold minimum difference to mode to set thresshold.
MIN_CONTRACTION_GAP = 8

# UA Threshold when uagap is 0
UA_MINMAX = 0.25

# FHR
# Threshold to acknoledge FHR accelerations in BPM
FHR_ACCEL_THRESHOLD = 12

# Threshold of seconds above FHR threshold to count it as an acceleration
FHR_ACCEL_DURATION = 3

# FHR variability lower threshold
VAR_CUTOFF = 3

# FHR variability upper threshold
VAR_CUTOFF_HI = 15

# Seconds after end of contraction to check for a late recovery
FHR_LR_TIME = 2

# Minimum running sum value of fhrdiff to use for late recovery
AUC_CUTOFF = -50

# You can write all the details of the analysis to the tKlsStripDetails table
WRITE_DETAILS = False


#############################
##### Set up connection #####
#############################

constring = 'DRIVER={SQL%20Server}%3BSERVER=fripoc.database.windows.net%3BDATABASE=KeepingLaborSafePoC%3BUID=sqladmin%3BPWD=239PotterRd480'
engine = sqlalchemy.create_engine("mssql+pyodbc:///?odbc_connect=%s" % constring)
cnxn = engine.connect()

# Grab 10 minute table
connstring = "select * from ana.tKlsFrame10Min"
tenmin = pd.read_sql_query(connstring, cnxn, parse_dates=['FrameStartDateTime','FrameEndDateTime'])
tenmin = tenmin.sort_values(by=['CaseID','CaseFrameSeqID'], ascending=True)
tenmin.index = tenmin.Id

# Loop over all rows in the 10 Min table and produce analyses
#for cid in tenmin.CaseID.unique():
#gt = pd.read_csv("C:/Users/lfinco/OneDrive - Insight/Git/Keeping%20Labor%20Safe/Sample Data/GroundTruth3.csv")
gt = pd.read_excel("C:/Users/lfinco/OneDrive - Insight/Git/Keeping%20Labor%20Safe/Sample Data/GroundTruth5.xlsx", sheet_name="GroundTruth2")
df2 = gt.merge(tenmin, how='inner', on=['CaseID','CaseFrameSeqID'], suffixes=['_a','_p'])
df2.index = df2.Id

# Save evaluation results
rslt = []

# list columns to be evaluated usign the evaluation() function
evalcolumns = ['FRIExcessiveUA','FRIAccelerations','FRIFhrBaseline','FRIFhrVariability','FRILateRecovery']

# load trace data for all cases
caseids = df2.CaseID.unique().tolist()
seqids = df2.CaseFrameSeqID.unique().tolist()

# load copy of trace data for the cases in the Ground Truth
%time data = kls.load_caselist_traces(caseids, cnxn)

#################################
##### Perform Test Analyses #####
#################################

#change for different tuning runs
#for AUC_CUTOFF in np.linspace(-10,-260,26):
#for FHR_ACCEL_THRESHOLD in np.linspace(1,21,41):
#for UA_MINMAX in np.linspace(0,1,21):
#for FHR_LR_TIME in np.linspace(1,11,41):
#for FHR_ACCEL_DURATION in np.linspace(1,11,11, dtype=np.int8):
#for MIN_CONTRACTION_GAP in np.linspace(0,20,21):

prev_baseline = 0

%%time
for VAR_CUTOFF_HI in np.linspace(10,20,21):
    for cid in df2['CaseID'].unique():
        
        # load trace data for one case
        #case = kls.load_case_traces(cid, cnxn)
        case = data[data['CaseID']==cid]
        
        # subset tenmin table to the CaseID
        df3 = df2[df2['CaseID']==cid]
        
        # reset previous baseline
        prev_baseline = 0
        
        for i in tqdm(range(0,len(df3))):
            # Load data
            #df = kls.load_trace(df3.iloc[i,3].strftime('%Y-%m-%d %H:%M:%S'), df3.iloc[i,4].strftime('%Y-%m-%d %H:%M:%S'), cid, cnxn)
            #cid = df3.loc[i,'CaseID'].astype(int)
            #df = kls.load_trace_seq(df3.loc[i,'CaseFrameSeqID'], cid, cnxn)
            df = case[case['CaseFrameSeqID']==df3.iloc[i].loc['CaseFrameSeqID']]
            #df = case[case['CaseFrameSeqID']==cfsid] # for testing
            print("\nCaseID", str(df3.iloc[i].loc['CaseID']) + " CaseFrameSeq", str(df3.iloc[i].loc['CaseFrameSeqID']), " Rows ", len(df))
            
            ### Data Quality Checks ###
            # check that there are no nan's
            if not kls.checks(df, PERC_DATA_AVAIL):
                print("NOT OK")
                prev_baseline = 0
                continue
            
            #######################
            ##### UA Analysis #####
            #######################
            
            df, uamode, uamedian, uagap, ucthresh, numcontractions, utime, rtime, urratio, avecontractiontime = kls.ua_analysis(df, int(MIN_CONTRACTION_TIME), UA_MINMAX, MIN_CONTRACTION_GAP)
            
            #peaks, half_widths, numcontractions2 = kls.ua_peak_width(df)
            
            #numcontractions3 = kls.ua_peak_counter(df)
            
            ########################
            ##### FHR Analysis #####
            ########################
            
            #### FHR Baseline ####
            df, fhrmode, fhrmedian, fhrbaseline = kls.fhrbl(df, prev_baseline)
            
            ### FHR Late Recovery ###
            df, laterecovery = kls.fhrlr(df, fhrbaseline, FHR_LR_TIME, AUC_CUTOFF)
            
            ### Identify accelerations ###
            df, fhraccelerations, fhrthreshold = kls.fhraccel(df, fhrbaseline, FHR_ACCEL_THRESHOLD, FHR_ACCEL_DURATION)
            
            #### FHR variability ###
            df, fhrrange, fhrstdev, fhrvar = kls.fhrvar(df)
            
            #fhrstdev = kls.fhrvar_delta(df)
            
            ##########################
            #### FRI Calculations ####
            ##########################
            
            # update FRI-UA
            FRIUA = True
            if(numcontractions > 4):
                print("Number of Contractions: {0}".format(numcontractions))
                FRIUA = False
#            elif(urratio > 0.8):
#                print("U R Ratio: {0}".format(urratio))
#                FRIUA = False
            else:
                FRIUA = True
            
            # update FRI-Accelerations
            FRIACC = True
            if(fhraccelerations == 0):
                print("Number of Accelerations: {0}".format(fhraccelerations))
                FRIACC = False
            else:
                FRIACC = True
            
            # update FRI-FHR Baseline
            FRIBL = True
            if(fhrbaseline < 110):
                print("FHR Baseline: {0}".format(fhrbaseline))
                FRIBL = False
            elif (fhrbaseline > 159):
                print("FHR Baseline: {0}".format(fhrbaseline))
                FRIBL = False
            else:
                FRIBL = True
            
            # update FRI-FHR Variability
            FRIVAR = True
            if(fhrstdev < VAR_CUTOFF):
                print("FHR Variability: {0}".format(fhrstdev))
                FRIVAR = False
            elif (fhrstdev > VAR_CUTOFF_HI):
                print("FHR Variability: {0}".format(fhrstdev))
                FRIVAR = False
            else:
                FRIVAR = True
            
            # update FRI-FHR Late Recovery
            FRILR = True
            if(laterecovery > 0):
                print("FHR Late Recovery: {0}".format(laterecovery))
                FRILR = False
            else:
                FRILR = True
            
            
            #########################
            ##### Write results #####
            #########################
            # All rows
            #if WRITE_DETAILS:
            #    df.to_sql(name='tKlsStripDetails', con=cnxn, if_exists = 'append', index=False, chunksize=20)
            
            # Save data to the 10-Minute table
            tenmin.loc[df3.index[i],'FHRBaselineBPM']=fhrbaseline
            tenmin.loc[df3.index[i],'FHRVariabilityBPM']=fhrstdev
            tenmin.loc[df3.index[i],'UABaseline']=uamode
            tenmin.loc[df3.index[i],'NumContractions']=numcontractions
            tenmin.loc[df3.index[i],'NumFHRAccelerations']=fhraccelerations
            tenmin.loc[df3.index[i],'NumFHRLateRecovery']=laterecovery
            tenmin.loc[df3.index[i],'FRIExcessiveUA']=bool(FRIUA)
            tenmin.loc[df3.index[i],'FRIAccelerations']=bool(FRIACC)
            tenmin.loc[df3.index[i],'FRIFhrBaseline']=bool(FRIBL)
            tenmin.loc[df3.index[i],'FRIFhrVariability']=bool(FRIVAR)
            tenmin.loc[df3.index[i],'FRILateRecovery']=bool(FRILR)
            
            # Write critical data to the 10-Minute table
#            engine.execute("update ana.tKlsFrame10Min set FHRBaselineBPM=" + str(fhrbaseline) + \
#                           ", FHRThreshold=" + str(int(fhrthreshold)) + \
#                           ", FHRVariabilityBPM=" + str(int(fhrstdev)) + \
#                           ", UABaseline=" + str(uamode) + \
#                           ", UAThreshold=" + str(ucthresh) + \
#                           ", NumContractions=" + str(numcontractions) + \
#                           ", AvgTimePerContractionSec=" + str(int(avecontractiontime)) + \
#                           ", TotalTimeContractionSec=" + str(int(utime)) + \
#                           ", TotalTimeRelaxationSec=" + str(int(rtime)) + \
#                           ", URRatio={0:.2f}".format(urratio) + \
#                           ", NumFHRAccelerations=" + str(fhraccelerations) + \
#                           ", NumFHRLateRecovery=" + str(laterecovery) + \
#                           ", FRIExcessiveUA=" + str(int(FRIUA)) + \
#                           ", FRIAccelerations=" + str(int(FRIACC)) + \
#                           ", FRIFhrBaseline=" + str(int(FRIBL)) + \
#                           ", FRIFhrVariability=" + str(int(FRIVAR)) + \
#                           ", FRILateRecovery=" + str(int(FRILR)) + \
#                           ", m_ExecutionDt = GETUTCDATE()" + \
#                           " where CaseID=" + str(int(cid)) + \
#                           " and CaseFrameSeqID=" + str(int(df3.iloc[i].loc['CaseFrameSeqID'])) + ";")
            
            prev_baseline = fhrbaseline
            
            # Save image
            #kls.plot_trace_marked(df, fhrstdev, fhrbaseline, numcontractions, urratio, fhraccelerations, laterecovery)
            #kls.plot_trace_marked_plus(df, fhrstdev, fhrbaseline, numcontractions, urratio, fhraccelerations, laterecovery, FRIUA, FRIBL, FRIACC, FRILR, FRIVAR)
            
    # Update FRI calculations
    #%time engine.execute('EXEC ana.uspCalculateFRIFramesByCaseID ' + str(cid) + ';')
    #%time engine.execute('EXEC ana.uspCalculateFRIFramesByCaseID ' + str(cid) + ';')
    
    df5 = gt.merge(tenmin, how='inner', on=['CaseID','CaseFrameSeqID'], suffixes=['_a','_p'])
    #df2.index = df2.Id
    
    # save results
    #e = kls.evaluate(df5, evalcolumns)
    e = kls.evaluate(df5, evalcolumns, engine)
    
    rslt.append([VAR_CUTOFF_HI, e[3][1], e[3][2], e[3][3], e[3][4], e[3][5], e[3][6], e[3][7], e[3][8]])
    

### Plot Results ###

#change for different tuning runs
eval_variable = 'VAR_CUTOFF_HI'

#results = pd.DataFrame(rslt, columns=['FHR_ACCEL_THRESHOLD','FPR','FNR','MSE','MAE', 'Precision', 'Recall'])
results = pd.DataFrame(rslt, columns=[eval_variable,'FPR','FNR','Precision','TPR','TNR','NPV','MSE','MAE'])
results.iloc[:10]

ax1 = results.plot(x=eval_variable, y='FPR', figsize=(12,8))
results.plot(x=eval_variable, y='FNR', ax=ax1)

ax1 = results.plot(x=eval_variable, y='MSE', figsize=(12,8))
results.plot(x=eval_variable, y='MAE',secondary_y=True, ax=ax1)



ax1 = results.plot(x=eval_variable, y='Precision', figsize=(12,8))
results.plot(x=eval_variable, y='TPR', ax=ax1)

results.plot(x=eval_variable)
results.plot(x='Precision', y='TPR', xlim=(0,1), ylim=(0,1))




# Always clean up after yourself...
cnxn.close()








