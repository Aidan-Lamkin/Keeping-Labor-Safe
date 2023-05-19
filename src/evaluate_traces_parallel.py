# -*- coding: utf-8 -*-
"""
Created on Wed Oct 30 15:14:55 2019

Keeping Labor Safe (KLS)
Automated marked-up strip printing of Uterine 
Activity (UA) and Fetal Heart Rate (FHR).

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

from pandarallel import pandarallel
pandarallel.initialize()

# Max rows in display
pd.set_option('display.max_rows', 5000)
pd.set_option('display.max_columns', 50)

###############################
########## Constants ##########
###############################

# Data Quality
# Percentage of data in 10 minute segment greater than this or do not score
PERC_DATA_AVAIL = 0.95

# UA
# UA Threshold of time, in seconds, that UA must maintain above threshold to be
# called a contraction.
MIN_CONTRACTION_TIME = 15

# UA Threshold minimum difference to mode to set thresshold.
MIN_CONTRACTION_GAP = 5.5

# UA Threshold when uagap is 0
UA_MINMAX = 0.30

# FHR
# Threshold to acknoledge FHR accelerations in BPM
FHR_ACCEL_THRESHOLD = 10

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

# Loop over all rows in the 10 Min table and produce analyses
#for cid in tenmin.CaseID.unique():
gt = pd.read_csv("C:/Users/lfinco/OneDrive - Insight/Git/Keeping%20Labor%20Safe/Sample Data/GroundTruth2.csv")
df2 = gt.merge(tenmin, how='inner', on=['CaseID','CaseFrameSeqID'], suffixes=['_a','_p'])
df2.index = df2.Id

# Save evaluation results
rslt = []

# list columns to be evaluated usign the evaluation() function
evalcolumns = ['FRIExcessiveUA','FRIAccelerations','FRIFhrBaseline','FRIFhrVariability','FRILateRecovery']

# load trace data for all cases
caseids = df2.CaseID.unique().tolist()
seqids = df2.CaseFrameSeqID.unique().tolist()
%time data = kls.load_caselist_traces(caseids, cnxn)

#################################
##### Perform Test Analyses #####
#################################

#for UA_MINMAX in np.linspace(0,1,41):
#for MIN_CONTRACTION_GAP in np.linspace(0,10,41):

from joblib import Parallel, delayed
import multiprocessing

def applyParallel(dfGrouped, func):
    retLst = Parallel(n_jobs=(cpu_count()-2))(delayed(func)(group) for name, group in dfGrouped)
    return pd.concat(retLst)

df.apply(kls.trace_apply)

for UA_MINMAX in np.linspace(0.01,0.6,60):
    
    # Evaluate traces
    %time res = applyParallel(data.groupby(['CaseID','CaseFrameSeqID']), kls.trace_apply)
    
    # Merge with Ground Truth
    df2 = gt.merge(res, how='inner', on=['CaseID','CaseFrameSeqID'], suffixes=['_a','_p'])
    
    # Evaluate and save
    e = kls.evaluate(df2, evalcolumns)
    rslt.append([UA_MINMAX, e[0][1], e[0][2], e[0][3], e[0][4], e[0][5], e[0][6]])


# plot results
results = pd.DataFrame(rslt, columns=['UA_MINMAX','FPR','FNR','MSE','MAE', 'Precision', 'Recall'])

ax1 = results.plot(x='UA_MINMAX', y='FPR', figsize=(12,8))
results.plot(x='UA_MINMAX', y='FNR',secondary_y=True, ax=ax1)

ax1 = results.plot(x='UA_MINMAX', y='MSE', figsize=(12,8))
results.plot(x='UA_MINMAX', y='MAE',secondary_y=True, ax=ax1)

results.plot(x='UA_MINMAX')

ax1 = results.plot(x='UA_MINMAX', y='Precision', figsize=(12,8))
results.plot(x='UA_MINMAX', y='Recall',secondary_y=True, ax=ax1)

results.plot(x='Precision', y='Recall')


# Always clean up after yourself...
cnxn.close()











