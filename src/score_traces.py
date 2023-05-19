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
#import numpy as np
#from scipy.stats import mode
#import matplotlib.pyplot as plt
#from sklearn.metrics import confusion_matrix as cm
#import pdb

# import KLS helper functions
import kls

# Max rows in display
pd.set_option('display.max_rows', 5000)
pd.set_option('display.max_columns', 50)


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

caseids = tenmin.CaseID.unique().tolist()

#############################
##### Perform Analysis #####
#############################

# Loop over all rows in the 10 Min table and produce analyses
#cid=38083382 # Change for different cases
for cid in caseids:
    
    # reset previous baseline
    prev_baseline = 0
    
    loopdf = tenmin[tenmin["CaseID"]==cid]
    
    
    #for i in range(0,92): # change later for many more traces
    for i in range(0,len(loopdf)):
        
        # Load data
        #df = load_trace(loopdf.iloc[i,3].strftime('%Y-%m-%d %H:%M:%S'), loopdf.iloc[i,4].strftime('%Y-%m-%d %H:%M:%S'), cid, cnxn)
        df = kls.load_trace_seq(loopdf.iloc[i,2], cid, cnxn)
        print("CaseID", str(loopdf.iloc[i,1]) + " Seq", str(loopdf.iloc[i,2]), " Rows ", len(df))
        
        ### Data Quality Checks ###
        # check that there are no nan's
        if not kls.checks(df, PERC_DATA_AVAIL):
            print("NOT OK")
            prev_baseline = 0
            continue
        
        #######################
        ##### UA Analysis #####
        #######################
        
        df, uamode, uamedian, uagap, ucthresh, numcontractions, utime, rtime, urratio, avecontractiontime = kls.ua_analysis(df, MIN_CONTRACTION_TIME, UA_MINMAX, MIN_CONTRACTION_GAP)
        
        ########################
        ##### FHR Analysis #####
        ########################
        
        #### FHR Baseline ####
        df, fhrmode, fhrmedian, fhrbaseline = kls.fhrbl(df, prev_baseline)
        
        #### FHR variability ###
        df, fhrrange, fhrstdev, fhrvar = kls.fhrvar(df)
        
        ### FHR Late Recovery ###
        df, laterecovery = kls.fhrlr(df, fhrbaseline, FHR_LR_TIME, AUC_CUTOFF)
        
        ### Identify accelerations ###
        df, fhraccelerations, fhrthreshold = kls.fhraccel(df, fhrbaseline, FHR_ACCEL_THRESHOLD, FHR_ACCEL_DURATION)
        
        ##########################
        #### FRI Calculations ####
        ##########################
        
        # update FRI-UA
        FRIUA = True
        if(numcontractions > 4):
            print("Number of Contractions: {0}".format(numcontractions))
            FRIUA = False
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
            print("FHR Baseline too low: {0}".format(fhrbaseline))
            FRIBL = False
        elif (fhrbaseline > 159):
            print("FHR Baseline too high: {0}".format(fhrbaseline))
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
            print("FHR Late Recoveries Present: {0}".format(laterecovery))
            FRILR = False
        else:
            FRILR = True
        
        # Write critical data to the 10-Minute table
        engine.execute("update ana.tKlsFrame10Min set FHRBaselineBPM=" + str(fhrbaseline) + \
                       ", FHRThreshold=" + str(int(fhrthreshold)) + \
                       ", FHRVariabilityBPM=" + str(int(fhrstdev)) + \
                       ", UABaseline=" + str(uamode) + \
                       ", UAThreshold=" + str(ucthresh) + \
                       ", NumContractions=" + str(numcontractions) + \
                       ", AvgTimePerContractionSec=" + str(int(avecontractiontime)) + \
                       ", TotalTimeContractionSec=" + str(int(utime)) + \
                       ", TotalTimeRelaxationSec=" + str(int(rtime)) + \
                       ", URRatio={0:.2f}".format(urratio) + \
                       ", NumFHRAccelerations=" + str(fhraccelerations) + \
                       ", NumFHRLateRecovery=" + str(laterecovery) + \
                       ", FRIExcessiveUA=" + str(int(FRIUA)) + \
                       ", FRIAccelerations=" + str(int(FRIACC)) + \
                       ", FRIFhrBaseline=" + str(int(FRIBL)) + \
                       ", FRIFhrVariability=" + str(int(FRIVAR)) + \
                       ", FRILateRecovery=" + str(int(FRILR)) + \
                       ", m_ExecutionDt = GETUTCDATE()" + \
                       " where CaseID=" + str(int(cid)) + \
                       " and CaseFrameSeqID=" + str(loopdf.iloc[i,2].astype(int)) + ";")
        
        prev_baseline = fhrbaseline
        
        # Save image
        #kls.plot_trace_marked(df, fhrstdev, fhrbaseline, numcontractions, urratio, fhraccelerations, laterecovery)
        #kls.plot_trace_marked_plus(df, fhrstdev, fhrbaseline, numcontractions, urratio, fhraccelerations, laterecovery, FRIUA, FRIBL, FRIACC, FRILR, FRIVAR)


# Always clean up after yourself...
cnxn.close()
