# -*- coding: utf-8 -*-
"""
Created on Wed Oct 30 15:14:55 2019

Keeping Labor Safe (KLS)
Automated marked-up strip printing of Uterine 
Activity (UA) and Fetal Heart Rate (FHR).

@author: Lucas Finco - lfinco
Insight Digital Innovation
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from sklearn.metrics import confusion_matrix as cm
from sklearn.metrics import mean_squared_error as mse
from sklearn.metrics import mean_absolute_error as mae
from scipy.stats import mode
from scipy.signal import find_peaks, peak_widths


###############################
###### Helper Functions #######
###############################

def load_trace(starttime, endtime, caseid, conn):
    """
    Load data between starttime (a string) and endtime (a string) from the KLS database.
    Returns a pandas DataFrame.
    """
    connstring = "select CaseID, SeqID, SampleDateTime, UA, HR2 from app.tKlsSample_Pivot where [CaseID]=" + \
        str(caseid) + " and [SampleDateTime] between '" \
        + starttime + "' and '" + endtime + "';"
    # print(connstring)  # for troubleshooting
    df = pd.read_sql_query(connstring, conn, parse_dates=['SampleDateTime'])
    return df

def load_case_traces(caseid, conn):
    """
    Load data between starttime (a string) and endtime (a string) from the KLS database.
    Returns a pandas DataFrame.
    """
    connstring = "select CaseID, SeqID, CaseFrameSeqID, SampleDateTime, UA, HR2 from app.tKlsSample_Pivot where [CaseID]=" + \
        str(caseid) + ";"
    # print(connstring)  # for troubleshooting
    df = pd.read_sql_query(connstring, conn, parse_dates=['SampleDateTime'])
    return df

def load_caselist_traces(caseids, conn):
    """
    Load data between starttime (a string) and endtime (a string) from the KLS database.
    Returns a pandas DataFrame.
    """
    connstring = "SELECT CaseID, SeqID, CaseFrameSeqID, SampleDateTime, UA, HR2 FROM app.tKlsSample_Pivot WHERE [CaseID] IN" + \
        str(caseids).replace('[','(').replace(']',')') + ";"
    # print(connstring)  # for troubleshooting
    df = pd.read_sql_query(connstring, conn, parse_dates=['SampleDateTime'])
    return df

def load_trace_seq(caseframeseqid, caseid, conn):
    """
    Load data by CaseID and CaseFrameSeqID from the KLS database.
    Returns a pandas DataFrame.
    """
    connstring = "select CaseID, SeqID, CaseFrameSeqID, SampleDateTime, UA, HR2 from app.tKlsSample_Pivot where [CaseID]=" + \
        str(caseid) + " and [CaseFrameSeqID]=" + str(caseframeseqid) + ";"
    #print(connstring)  # for troubleshooting
    df = pd.read_sql_query(connstring, conn, parse_dates=['SampleDateTime'])
    return df

def plot_trace(df):
    """
    Create strip plots from UA and FHR data.  Returns an image inline and saves
    an image file to the current directory.
    """
    fig, axs = plt.subplots(2, 1, figsize=(16,8), sharex=True, gridspec_kw = {'height_ratios':[1.6, 1]})
    # Remove horizontal space between axes
    #fig.subplots_adjust(hspace=1)
    axs[0].plot(df.SampleDateTime, df.HR2)
    axs[0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[0].set_yticks(np.arange(30, 220, 30))
    axs[0].set_ylim(30, 211)
    axs[0].grid(True, which='both')
    axs[0].set_title("CaseID: " + str(df['CaseID'].iloc[0]) + "  SeqID: " + str(df['CaseFrameSeqID'].iloc[0]) + " - " + df.SampleDateTime[0].strftime('%Y-%m-%d %H:%M:%S'))
    axs[0].tick_params(grid_linestyle='dotted', which='minor',)
    #axs[0].set_aspect(200)
    
    axs[0].plot(df.SampleDateTime, df.HR2)
    axs[0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[0].set_yticks(np.arange(30, 220, 30))
    axs[0].set_ylim(30, 211)
    axs[0].grid(True, which='both')
    axs[0].set_title("CaseID: " + str(df['CaseID'].iloc[0]) + "  SeqID: " + str(df['CaseFrameSeqID'].iloc[0]) + " - " + df.SampleDateTime[0].strftime('%Y-%m-%d %H:%M:%S'))
    axs[0].tick_params(grid_linestyle='dotted', which='minor',)
    #axs[0].set_aspect(200)
    
    axs[1].plot(df.SampleDateTime, df.UA)
    axs[1].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[1].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[1].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[1].set_yticks(np.arange(0, 105, 25))
    axs[1].set_ylim(0, 100)
    axs[1].grid(True, which='both')
    axs[1].tick_params(grid_linestyle='dotted', which='minor',)

    # need a way to not show image inline, probably wasting time here
    #plt.show()
    plt.savefig("strip_" + str(df['CaseID'].iloc[0]) + "_" + str(df['CaseFrameSeqID'].iloc[0]) + "_" + min(df.SampleDateTime).strftime('%Y%m%d_%H%M%S') + "_" + max(df.SampleDateTime).strftime('%Y%m%d_%H%M%S')+".png")

def plot_trace_marked(df_in, fhrvariation, fhrbaseline, numcontractions, ur, accs, numlr):
    """
    Create marked-up strip plots from UA and FHR data.  
    Returns an image inline and saves
    an image file to the current directory.
    """
    #df = df_in[df_in["HR2"]!=0]
    
    fig, axs = plt.subplots(2, 1, figsize=(20,14), sharex=True, gridspec_kw = {'height_ratios':[1.6, 1]})
    # Remove horizontal space between axes
    #fig.subplots_adjust(hspace=1)
    axs[0].set_title("CaseID: " + str(df_in['CaseID'].iloc[0]) + " -- SeqID: " + str(df_in['CaseFrameSeqID'].iloc[0]) + " -- " + str(df_in['SampleDateTime'].iloc[0]))
    axs[0].plot(df_in[df_in['fhracceleration']==0].SampleDateTime, df_in[df_in['fhracceleration']==0].HR2, 'k.', markersize=2)
    axs[0].plot(df_in[df_in['fhracceleration']==1].SampleDateTime, df_in[df_in['fhracceleration']==1].HR2, 'b.', markersize=4)
    #axs[0].plot(df.SampleDateTime, df.HR2, '.', markersize=3)
    axs[0].plot(df_in.SampleDateTime, df_in.fhrbaseline, 'y')
    axs[0].plot(df_in.SampleDateTime, df_in.fhrthreshold, 'y')
    axs[0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[0].set_yticks(np.arange(30, 220, 30))
    axs[0].set_ylim(30, 211)
    axs[0].grid(True, which='both')
    axs[0].text(0.01, 0.94, "FHR Varibility: {0:2f} BPM".format(fhrvariation), fontsize=12, transform=axs[0].transAxes)
    #axs[0].set_title("CaseID: " + str(df.CaseID[0]) + " -- SeqID: " + str(df.SeqID[0]) + " -- " + df.SampleDateTime[0].strftime('%Y-%m-%d %H:%M:%S'))
    axs[0].tick_params(grid_linestyle='dotted', which='minor',)
    #axs[0].set_aspect(200)
    axs[0].legend(loc='center left', framealpha=1.0)
    
    # FHR dual y-axis
    ax2 = axs[0].twinx()
    ax2.set_ylim(-0.1, 1.1)
    #ax2.set_ylabel("accelerations, late recoveries", color="tab:green")
    #ax2.plot(df.SampleDateTime, df.fhracceleration, 'g')
    ax2.plot(df_in.SampleDateTime, df_in.laterecovery, 'r')
    ax2.tick_params(axis='y', labelcolor="tab:red")
    ax2.legend(loc='center right')
    
    # UA plot
    axs[1].plot(df_in[df_in['contraction']==0].SampleDateTime, df_in[df_in['contraction']==0].UA, 'b.', markersize=2)
    axs[1].plot(df_in[df_in['contraction']==1].SampleDateTime, df_in[df_in['contraction']==1].UA, 'm.', markersize=4)
    axs[1].plot(df_in.SampleDateTime, df_in.uamode)
    axs[1].plot(df_in.SampleDateTime, df_in.ucthreshold, 'goldenrod')
    axs[1].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[1].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[1].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[1].set_yticks(np.arange(0, 105, 25))
    axs[1].set_ylim(0, 100)
    axs[1].set_ylabel('UA')
    axs[1].grid(True, which='both')
    axs[1].tick_params(grid_linestyle='dotted', which='minor',)
    axs[1].set_title("FHRBaselineBPM: " + str(fhrbaseline) + " -- UC's: " + str(numcontractions) + " -- U/R: {0:f}".format(ur) + " -- FHR Accels: " + str(accs) + " -- # Late Recoveries: " + str(numlr))
    axs[1].legend(loc='upper left')
    
    # UA dual y-axis
    #ax1 = axs[1].twinx()
    #ax1.set_ylabel("contractions", color="darkorchid")
    #ax1.plot(df.SampleDateTime, df.contraction, 'darkorchid')
    #ax1.tick_params(axis='y', labelcolor="darkorchid")
    #ax1.legend(loc='upper right')
    
    # need a way to not show image inline, probably wasting time here
    #plt.show()
    plt.savefig("strip_" + str(df_in['CaseID'].iloc[0]) + "_" + str(df_in['CaseFrameSeqID'].iloc[0]) + "_" + (df_in['SampleDateTime'].min()).strftime('%Y%m%d_%H%M%S') + "_" + (df_in['SampleDateTime'].max()).strftime('%Y%m%d_%H%M%S')+".png")

def plot_trace_marked_plus(df_in, fhrvariation, fhrbaseline, numcontractions, ur, accs, numlr, FRIUA, FRIBL, FRIACC, FRILR, FRIVAR):
    """
    Create marked-up strip plots from UA and FHR data.  
    Returns an image inline and saves
    an image file to the current directory.
    """
    #df = df_in[df_in["HR2"]!=0]
    
    # resample 
    df_rs = df_in.copy()
    df_rs.index = df_rs.SampleDateTime
    delta1 = df_rs.resample('S').mean()
    #delta1 = delta1[~delta1['HR2'].isnull()]
    
    fig, axs = plt.subplots(nrows=4, ncols=2, figsize=(20,24), gridspec_kw = {'height_ratios':[1.8, 1,1.8, 1], 'width_ratios':[4,1]})
    # Remove horizontal space between axes
    #fig.subplots_adjust(hspace=1)
    axs[0,0].set_title("CaseID: " + str(df_in['CaseID'].iloc[0]) + " -- SeqID: " + str(df_in['CaseFrameSeqID'].iloc[0]) + " -- " + str(df_in['SampleDateTime'].iloc[0]))
    axs[0,0].plot(df_in[df_in['fhracceleration']==0].SampleDateTime, df_in[df_in['fhracceleration']==0].HR2, 'k.', markersize=2)
    axs[0,0].plot(df_in[df_in['fhracceleration']==1].SampleDateTime, df_in[df_in['fhracceleration']==1].HR2, 'g.', markersize=4)
    #axs[0,0].plot(df.SampleDateTime, df.HR2, '.', markersize=3)
    axs[0,0].plot(df_in.SampleDateTime, df_in.fhrbaseline, 'y')
    axs[0,0].plot(df_in.SampleDateTime, df_in.fhrthreshold, 'y')
    axs[0,0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[0,0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[0,0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[0,0].set_yticks(np.arange(60, 220, 10))
    axs[0,0].set_ylim(60, 211)
    axs[0,0].grid(True, which='both')
    axs[0,0].text(0.01, 0.94, "FHR Varibility: {0:2f} BPM".format(fhrvariation), fontsize=12, transform=axs[0,0].transAxes)
    #axs[0,0].set_title("CaseID: " + str(df.CaseID[0]) + " -- SeqID: " + str(df.SeqID[0]) + " -- " + df.SampleDateTime[0].strftime('%Y-%m-%d %H:%M:%S'))
    axs[0,0].tick_params(grid_linestyle='dotted', which='minor',)
    #axs[0,0].set_aspect(200)
    axs[0,0].legend(loc='lower left', framealpha=1.0)
    
    # FHR dual y-axis
    ax2 = axs[0,0].twinx()
    ax2.set_ylim(-0.3, 1.1)
    #ax2.set_ylabel("accelerations, late recoveries", color="tab:green")
    #ax2.plot(df.SampleDateTime, df.fhracceleration, 'g')
    ax2.plot(df_in.SampleDateTime, df_in.laterecovery, 'r')
    ax2.tick_params(axis='y', labelcolor="tab:red")
    ax2.legend(loc='lower right')
    
    # FHR histogram to the right
    axs[0,1].set_title("FHR Histogram")
    axs[0,1].hist(delta1[~delta1['HR2'].isnull()].HR2, bins=40, orientation='horizontal')
    axs[0,1].set_yticks(np.arange(60, 220, 10))
    axs[0,1].set_ylim(60, 211)
    
    # FHR Diff plot
    axs[1,0].set_title("FHRBaselineBPM: " + str(fhrbaseline) + " -- FHR Accels: " + str(accs) + " -- # Late Recoveries: " + str(numlr))
    axs[1,0].plot(delta1[delta1['fhracceleration']==0]['fhrdiff2'], 'k.', markersize=2)
    axs[1,0].plot(delta1[delta1['fhracceleration']==1]['fhrdiff2'], 'g.', markersize=2)
    axs[1,0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[1,0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[1,0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[1,0].set_yticks(np.arange(-5, 5, 1))
    axs[1,0].set_ylim(-5, 5)
    axs[1,0].set_ylabel('FHR Difference')
    axs[1,0].grid(True, which='both')
    axs[1,0].tick_params(grid_linestyle='dotted', which='minor',)
    
    # FHR diff histogram
    axs[1,1].set_title("FHR Difference Histogram")
    diffh = np.histogram(delta1[(delta1['fhrdiff2']<22) & (delta1['fhrdiff2']>-22) & (~delta1['fhrdiff2'].isnull())].fhrdiff2, bins=40)
    axs[1,1].barh(diffh[1][:40], width=diffh[0], height=1.0)
    axs[1,1].set_ylim(-5, 5)
    
    # UA plot
    axs[2,0].plot(df_in[df_in['contraction']==0].SampleDateTime, df_in[df_in['contraction']==0].UA, 'b.', markersize=2)
    axs[2,0].plot(df_in[df_in['contraction']==1].SampleDateTime, df_in[df_in['contraction']==1].UA, 'm.', markersize=4)
    axs[2,0].plot(df_in.SampleDateTime, df_in.uamode)
    axs[2,0].plot(df_in.SampleDateTime, df_in.ucthreshold, 'goldenrod')
    axs[2,0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[2,0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[2,0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[2,0].set_yticks(np.arange(0, 105, 25))
    axs[2,0].set_ylim(0, 100)
    axs[2,0].set_ylabel('UA')
    axs[2,0].grid(True, which='both')
    axs[2,0].tick_params(grid_linestyle='dotted', which='minor',)
    axs[2,0].set_title("UC's: " + str(numcontractions) + " -- U/R: {0:f}".format(ur))
    axs[2,0].legend(loc='upper left')
    
    axs[2,1].set_title("UA Histogram")
    axs[2,1].hist(df_in.UA, bins=80, orientation='horizontal', height=1.0)
    axs[2,1].set_yticks(np.arange(0, 105, 25))
    axs[2,1].set_ylim(0, 100)
    
    # UA diff plot
    axs[3,0].plot(delta1[delta1['contraction']==0]['UAdiff'], 'k.', markersize=2)
    axs[3,0].plot(delta1[delta1['contraction']==1]['UAdiff'], 'b.', markersize=2)
    axs[3,0].xaxis.set_minor_locator(mdates.SecondLocator(interval=10))
    axs[3,0].xaxis.set_major_locator(mdates.MinuteLocator(interval=1))
    axs[3,0].xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))
    axs[3,0].set_yticks(np.arange(-5, 5, 1))
    axs[3,0].set_ylim(-5, 5)
    axs[3,0].set_ylabel('UA Diff')
    axs[3,0].grid(True, which='both')
    axs[3,0].tick_params(grid_linestyle='dotted', which='minor',)
    axs[3,0].set_title( "FRIUA: " + str(int(FRIUA)) + " -- FRIBL: " + str(int(FRIBL)) + " -- FRIACC: " + str(int(FRIACC)) + " -- FRILR: " + str(int(FRILR)) + " -- FRIVAR: " + str(int(FRIVAR)) )
    
    axs[3,1].set_title("UA Diff Histogram")
    diffu = np.histogram(delta1[(delta1['UAdiff']<44) & (delta1['UAdiff']>-44) & (~delta1['UAdiff'].isnull())].UAdiff, bins=80)
    axs[3,1].barh(diffu[1][:80], diffu[0], height=1.0)
    axs[3,1].set_ylim(-5, 5)
    
    # UA dual y-axis
    #ax1 = axs[1,0].twinx()
    #ax1.set_ylabel("contractions", color="darkorchid")
    #ax1.plot(df.SampleDateTime, df.contraction, 'darkorchid')
    #ax1.tick_params(axis='y', labelcolor="darkorchid")
    #ax1.legend(loc='upper right')
    
    # need a way to not show image inline, probably wasting time here
    #plt.show()
    plt.savefig(str(df_in['CaseID'].iloc[0]) + "_" + str(df_in['CaseFrameSeqID'].iloc[0]) + "_" + (df_in['SampleDateTime'].min()).strftime('%Y%m%d_%H%M%S') + "_" + (df_in['SampleDateTime'].max()).strftime('%Y%m%d_%H%M%S')+".png", pad_inches=0.1)

def evaluate(df, gtcolumns, engine=None):
    """
    Function to compare FRI predictions to Ground Truth and print out evaluation
    metrics.  Must populate df2 from ana.tKlsFrame10Min.
    """
    reslt = []
    lookup = pd.DataFrame([['NumContractions_a','NumContractions_p'],['NumFHRAccelerations_a','NumFHRAccelerations_p'],['FHRBaseline','FHRBaselineBPM'],['FHRVariability','FHRVariabilityBPM'],['NumFHRLateRecovery_a','NumFHRLateRecovery_p']], ['FRIExcessiveUA','FRIAccelerations','FRIFhrBaseline','FRIFhrVariability','FRILateRecovery'])
    
    for k in range(0, len(gtcolumns)):
        
        value = gtcolumns[k]
        
        #Calculate Errors
        ms = mse(df[lookup.loc[value].loc[0]], df[lookup.loc[value].loc[1]])
        ma = mae(df[lookup.loc[value].loc[0]], df[lookup.loc[value].loc[1]])
        
        # run confusion matrices for all gtcolumns
        confm = cm(df[(value+"_a")], df[value+"_p"])
        tp, tn, fn, fp = confm[1,1], confm[0,0], confm[1,0], confm[0,1]
        acc = (tp + tn) / (tp + tn + fp + fn)
        fpr = ( fp / df.shape[0] )
        fnr = ( fn / df.shape[0] )
        ppv = ( tp / (tp + fp) )
        npv = ( tn / (tn + fn) )
        tpr = ( tp / (tp + fn) )
        tnr = ( tn / (tn + fp) )
        print("\n")
        print(value)
        print(confm)
        print("Accuracy = " + str(acc))
        print("Recall, Sensitivity or TPR = " + str(tpr))
        print("Specificity or TNR = " + str(tnr))
        print("Precision or PPV = " + str(ppv))
        print("FPR = " + str(fpr))
        print("FNR = " + str(fnr))
        print("NPV = " + str(npv))
        print(value + " MSE = " + str(ms))
        print(value + " MAE = " + str(ma))
        
        # write to database
        if not engine==None:
            engine.execute("insert into ana.tEvaluationResults (value, tp, tn, fn, fp, acc, fpr, fnr, ppv, tpr, tnr, npv, mse, mae, Evaluationdt) " + \
                           "values ('" + str(value) + \
                           "', " + str(int(tp)) + ", " + str(int(tn)) + \
                           ", " + str(int(fn)) + ", " + str(int(fp)) + \
                           ", " + str(acc) + ", " + str(fpr) + \
                           ", " + str(fnr) + ", " + str(ppv) + \
                           ", " + str(tpr) + ", " + str(tnr) + \
                           ", " + str(npv) + ", " + str(ms) + \
                           ", " + str(ma) + ", GETUTCDATE());")
        
        # append to result list
        #reslt.append([confm, ( fp / (dflen) ), ( fn / (dflen)), ms, ma, ( tp / (tp + fp) ), ( tp / (tp + fn) )])
        reslt.append([confm, fpr, fnr, ppv, tpr, tnr, npv, ms, ma])
    return reslt

def checks(df, PERC_DATA_AVAIL=0.95):
    """
    Data Quality Checks
    Returns True if passed, False if failed
    """
    # return checks = True/False
    ret = True
    # check that there are no nan's
    if df.isnull().values.any():
    #if df.isnull().values.any() or (len(df[df['HR2']==0])> 20):
        print("Contains NaN's, skipping this sequence")
        ret = False
    
    # check that we have enough data
    if len(df) < (10*60*4) * PERC_DATA_AVAIL:
        print("Not Enough Data")
        ret = False
    
    # check for a large amount of 0's in the FHR
    if len(df[df['HR2']==0]) > ((10*60*4) * (1.0-PERC_DATA_AVAIL)):
        print("Not Enough Data", len(df[df['HR2']==0]))
        ret = False
    
    # check for a large amount of 0's in the UA
    if len(df[df['UA']==0]) > ((10*60*4) * (1.0-PERC_DATA_AVAIL)):
        print("Not Enough Data")
        ret = False
    
    # check for a large amount of 100's in the UA
    if len(df[df['UA']==100]) > ((10*60*4) * (PERC_DATA_AVAIL)):
        print("Too many UAs equal 100")
        ret = False
    
    return ret

def ua_analysis(df, MIN_CONTRACTION_TIME, UA_MINMAX, MIN_CONTRACTION_GAP):
    """
    UA Analysis
    mode of UA data, used to set UA baseline
    OLD uamode = mode(df['UA'])[0][0]
    Now excluding 'max-out' 100 values from mode calculation
    """
    try:
        uamode = mode(df.loc[df.UA != 100, 'UA'])[0][0]
        uamedian = np.median(df.loc[df.UA != 100, 'UA'])
        uagap = uamode * 0.1
    except:
        print("UA calculation error")
        return
    
    if uamode < uamedian:
        # test that mode is not too high
        # take a MIN_CONTRACTION_GAP increase to set threshold for start of contraction
        if uagap==0:
            # if uagap is 0.0, use UA_MINMAX of max-min
            print("uagap is {0:f}, uagap set to {1:.1f} of min-max".format(uagap, UA_MINMAX))
            # now using 98%  and 2% quantiles for max & min, respectively
            ucthresh = (( df['UA'].quantile(q=0.98) - df['UA'].quantile(q=0.02) ) * UA_MINMAX) + df['UA'].min()
        elif uagap < MIN_CONTRACTION_GAP:
            print("uagap is {0:f}, uagap set to {1:.0f}".format(uagap, MIN_CONTRACTION_GAP))
            # if uagap too small, use MIN_CONTRACTION_GAP set above
            ucthresh = uamode + MIN_CONTRACTION_GAP
        else:
            print("uagap is {0:f}".format(uagap))
            ucthresh = uamode + uagap
    else:
        # if mode is high, use 50th percentile value instead
        # this can be the case when mother is pushing
        ucthresh = df['UA'].quantile(q=0.5)
        print("ucthresh is set by Quantile: {0:f}".format(ucthresh))
    
    # faster method to create new columns in df using above results
    append_cols = np.array([uamode*np.ones(df.shape[0]), ucthresh*np.ones(df.shape[0]), np.zeros(df.shape[0]), np.zeros(df.shape[0]), np.zeros(df.shape[0]), uagap*np.ones(df.shape[0]), df.loc[:,'UA'].diff(), np.zeros(df.shape[0])]).T
    ac = pd.DataFrame(data=append_cols, columns=['uamode', 'ucthreshold','contraction','uaabovethresh','uatrunsum', 'uagap', 'UAdiff','UaRestRunSum'], index=df.index).copy()
    df = pd.concat([df, ac], axis=1)
    
    # difference between UA and the baseline
    df.loc[:,'uadiff'] = df.loc[:,'UA'] - df.loc[:,'uamode']
    
    # Loop over strip to get contractions
    for l in range(df.index.min()+2, df.index.max()):
    #for l in range(1,400):  # for testing purposes
        # check to see if we are below threshold
        if df.at[l, 'UA'] < ucthresh:
            df.at[l, 'uatrunsum'] = 0
            df.at[l, 'UaRestRunSum'] = df.at[(l-1), 'UaRestRunSum'] + 1
            continue
        else:
            # if not, start tracking time above threshold
            df.at[l, 'uaabovethresh'] = 1
            df.at[l, 'uatrunsum'] = df.at[(l-1), 'uatrunsum'] + 1
            # check if we have been above threshold for more than MIN_CONTRACTION_TIME seconds
            if df.at[l, 'uatrunsum'] > (MIN_CONTRACTION_TIME * 4):
                df.at[l, 'contraction'] = 1
            
            # reset UA rest running sum
            df.at[l, 'UaRestRunSum'] = 0
    
    # Count number of contractions
    numcontractions = 0
    for l in range(df.index.min()+2, df.index.max()):
        # look for the end of contractions to count them
        if df.at[l, 'contraction'] == 0 and df.at[(l-1), 'contraction'] == 1:
            numcontractions = numcontractions + 1
        # Fix up first 30 seconds of contraction
        # look for start of contraction, and put back in the first minimum time
        if df.at[l, 'contraction'] == 1 and df.at[(l-1), 'contraction'] == 0:
            for k in range(0,(MIN_CONTRACTION_TIME * 4)):
                if (l-k >= 0):
                    df.at[(l-k),'contraction'] = df.at[(l),'contraction']
    
    # correction for contraction that runs off the end of the strip
    #if df.at[(len(df)-1), 'contraction']:
    if df.at[l, 'contraction']:
        numcontractions = numcontractions + 1
    
    # Calculate U/R ratio
    utime = (df.loc[:,"contraction"].sum() / 4.0)
    rtime = (len(df.loc[:,"contraction"])-df.loc[:,"contraction"].sum()) / 4.0
    urratio = utime / rtime
    
    # division can cause inf's and nan's
    if np.isnan(urratio) | np.isinf(urratio):
        urratio = 0.0
    
    # put a limit on urratio due to numeric size in SQL database
    if urratio > 9.0:
        urratio = 9.0
    
    # Calculate average contraction time
    if numcontractions != 0:
        avecontractiontime = utime / numcontractions
    else:
        avecontractiontime = 0
    
    
    if np.isnan(avecontractiontime) | np.isinf(avecontractiontime):
        avecontractiontime = 0.0
        
    return df, uamode, uamedian, uagap, ucthresh, numcontractions, utime, rtime, urratio, avecontractiontime


def ua_peak_width(df):
    """
    UA Peak Width Analysis
    Find peaks and peak widths
    using Scipy functions on UA data
    """
    
    df2 = df.copy(deep=True)
    df2.index = df2.SampleDateTime
    
    # resample data frame as the peak detection algo is very sensitive
    data = df2.resample('25s').mean()
    x = data.UA.values
    
    peaks, _ = find_peaks(x)
    #print(peaks)
    
    results_half = peak_widths(x, peaks, rel_height=0.5)
    #print(results_half[0])  # widths
    
    return peaks, results_half[0], peaks.shape[0]

def ua_peak_counter(df):
    """
    Count UA peaks
    Find peaks with diff function
    """
    
    # make a hard copy
    df2 = df.copy(deep=True)
    df2.index = df2.SampleDateTime
    
    # resample data frame as the peak detection algo is very sensitive
    df3 = df2.resample('25s').mean()
    diffr = df3.UA.diff(1)
    
    countr = 0
    
    # loop over data and find diff flips from + to -
    for i in range(1, diffr.shape[0]):
        if (diffr.iloc[(i-1)] > 0) and (diffr.iloc[i] < 0):
            countr = countr + 1
    
    return countr


def fhrbl(df, prev_bl=0):
    """
    Find baseline FHR
    prev_bl is the basline from the previous trace - defaults to 0
    Baseline only calculate when not in contraction
    """
    
    # Now excluding zeros from the calculation
    fhrmode = mode(df[(df['uaabovethresh'] == 0) & (df['HR2'] != 0)]['HR2'])[0][0]
    fhrmedian = np.median(df[(df['uaabovethresh'] == 0) & (df['HR2'] != 0)]['HR2'])
    df.loc[:,'fhrmode'] = fhrmode*np.ones(df.shape[0])
    df.loc[:,'fhrmedian'] = fhrmedian*np.ones(df.shape[0])
    
    # if there is no 2-minute period of rest, use previous baseline
    if (((df.UaRestRunSum.max()/4)/60) < 2.0) and (prev_bl != 0) and (prev_bl > fhrmode):
        fhrbaseline = prev_bl
    else:
        fhrbaseline = fhrmode
    
    # set up the baseline
    df.loc[:,'fhrbaseline'] = fhrbaseline*np.ones(df.shape[0])
    df.loc[:,'fhrdiff'] = df['HR2'] - fhrbaseline
    df.loc[:,'fhrdiff2'] = df['HR2'].diff()
    
    return df, fhrmode, fhrmedian, fhrbaseline

def fhrvar(df):
    """
    FHR variability
    uses three measures, peak-to-peak range, standard deviation, and variance
    FHR should be out of contraction and out of acceleration
    """
    # Use 3 different ways
    if len(df[(df['contraction'] == 0) & (df['HR2'] != 0)]) != 0:
        fhrrange = np.ptp(df[(df['contraction'] == 0) & (df['HR2'] != 0)]['HR2'])
        fhrstdev = np.std(df[(df['contraction'] == 0) & (df['HR2'] != 0)]['HR2'])
        fhrvar = np.var(df[(df['contraction'] == 0) & (df['HR2'] != 0)]['HR2'])
        
        # save to df
        #df.loc[:,'fhrrange'] = fhrrange
        #df.loc[:,'fhrstdev'] = fhrstdev
        #df.loc[:,'fhrvar'] = fhrvar
    else:
        fhrrange = 0.0
        fhrstdev = 0.0
        fhrvar = 0.0
        
        # save to df
        #df.loc[:,'fhrrange'] = fhrrange*np.ones(df.shape[0])
        #df.loc[:,'fhrstdev'] = fhrstdev*np.ones(df.shape[0])
        #df.loc[:,'fhrvar'] = fhrvar*np.ones(df.shape[0])
    
    
    
    return df, fhrrange, fhrstdev, fhrvar


def fhrvar_delta(df):
    """
    FHR variability
    Uses second-to-second deltas to determine variations.
    Returns Standard Deviation of 1-sec deltas
    """
    
    # make a copy so we don't mess up the original df
    df_rs = df.copy(deep=True)
    df_rs.index = df_rs.SampleDateTime
    
    # resample to 1-second
    delta1 = df_rs.resample('S').mean()
    delta1['fhr_rs_diff'] = delta1['HR2'].diff()
    
    return delta1[delta1['fhr_rs_diff']<10]['fhr_rs_diff'].std()


def fhrlr(df, fhrbaseline, FHR_LR_TIME, AUC_CUTOFF=-100):
    """
    FHR Late Recovery
    
    Has FHR late recovery?  Overshoot?
    find end of contractions# grab fhr, fhr at 30 sec later
    if diff too big, late recovery
    also compare to fhr baseline
    need to test more
    
    fhrbaseline is the previously established FHR baseline
    
    FHR_LR_TIME is the number of seconds after the contraction we should check 
        for a late recovery
    
    AUC_CUTOFF is the running sum of HR2 that we use in parallel to evaluate a 
        late recovery
    """
    
    # keep track of where the late recovery is
    df.loc[:,'laterecovery'] = np.zeros(df.shape[0])
    
    # late recovery present?
    laterecovery = 0
    
    # run through all datapoints
    for l in range(df.index.min() + 2, df.index.max() - int(FHR_LR_TIME*4)):
        
        # if end of contraction and HR2 well behaved
        if (df.at[l, 'contraction'] == 0) and (df.at[(l-1), 'contraction'] == 1) and (df.at[l, 'HR2'] != 0) and (df.at[(l+int(FHR_LR_TIME*4)), 'HR2'] != 0):
            
            # if fhrdiff below -5 and fhrdiff running sum big enough
            if (df.at[(l+int(FHR_LR_TIME*4)), 'fhrdiff'] <= -5) and (np.sum(df[df['HR2']!=0]['fhrdiff'].loc[l:(l+int(FHR_LR_TIME*4))]) < AUC_CUTOFF):
                
                laterecovery = laterecovery + 1
                
                # mark area as laterecovery
                for k in range(0,int(FHR_LR_TIME*4)):
                    df.at[(l+k),'laterecovery'] = 1
    
    return df, laterecovery

def fhraccel(df, fhrbaseline, FHR_ACCEL_THRESHOLD, FHR_ACCEL_DURATION=2):
    """
    Identify FHR accelerations
    """
    # Duration of FHR above threshold to call an acceleration
    print("FHR Threshold ",FHR_ACCEL_THRESHOLD)
    
    # default all calcuations to 0 before work
    df.loc[:,'fhracceleration'] = np.zeros(df.shape[0])
    # is FHR above threshold?
    df.loc[:,'fhrabovethresh'] = np.zeros(df.shape[0])
    # running sum of measurements since FHR crossed the threshold
    df.loc[:,'fhrrunsum'] = np.zeros(df.shape[0])
    # FHR threshold value for plotting 
    df.loc[:,'fhrthreshold'] = (fhrbaseline + FHR_ACCEL_THRESHOLD)
    
    for l in range(df.index.min()+2, df.index.max()):
        # check if above acceleration threshold
        if df.at[l, 'HR2'] > df.at[l,'fhrthreshold']:
            # start tracking time above threshold
            df.at[l, 'fhrabovethresh'] = 1
            # add one to the running sum
            df.at[l, 'fhrrunsum'] = df.at[(l-1), 'fhrrunsum'] + 1
            # check if we have been above threshold for more than 10 seconds
            if df.at[l, 'fhrrunsum'] > (FHR_ACCEL_DURATION*4):
                df.at[l, 'fhracceleration'] = 1
            # if at start of acceleration, put back last 10 seconds of acceleration
            if df.at[l, 'fhracceleration'] == 1 and df.at[(l-1), 'fhracceleration'] == 0:
                for k in range(0,(FHR_ACCEL_DURATION*4)):
                    if (l-k >= 0):
                        df.at[(l-k),'fhracceleration'] = 1
        else:   
            df.at[l, 'fhrabovethresh'] = 0
            df.at[l, 'fhrrunsum'] = 0
    
    # Count number of accelerations
    fhraccelerations = 0
    for l in range(df.index.min()+2, df.index.max()):
        if df.at[l, 'fhracceleration'] == 1 and df.at[(l-1), 'fhracceleration'] == 0:
            fhraccelerations = fhraccelerations + 1
    
    return df, fhraccelerations, (fhrbaseline + FHR_ACCEL_THRESHOLD)

def trace_apply(df, params=[15,0.3,5.5,10]):
    """
    Given 10 minutes of samplepivot data in df, return matching GT parameters
    params = [MIN_CONTRACTION_TIME, UA_MINMAX, MIN_CONTRACTION_GAP,FHR_ACCEL_THRESHOLD]
    """
    #######################
    ##### UA Analysis #####
    #######################
    
    df, uamode, uamedian, uagap, ucthresh, numcontractions, utime, rtime, urratio, avecontractiontime = ua_analysis(df, params[0], params[1], params[2])
    
    ########################
    ##### FHR Analysis #####
    ########################
    
    #### FHR Baseline ####
    df, fhrmode, fhrmedian, fhrbaseline = fhrbl(df)
    
    #### FHR variability ###
    df, fhrrange, fhrstdev, fhrvr = fhrvar(df)
    
    ### FHR Late Recovery ###
    df, laterecovery = fhrlr(df, fhrbaseline)
    
    ### Identify accelerations ###
    df, fhraccelerations = fhraccel(df, fhrbaseline, params[2])
    
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
        print("FHR Baseline: {0}".format(fhrbaseline))
        FRIBL = False
    elif (fhrbaseline > 159):
        print("FHR Baseline: {0}".format(fhrbaseline))
        FRIBL = False
    else:
        FRIBL = True
    
    # update FRI-FHR Variability
    FRIVAR = True
    if(fhrstdev < 3):
        print("FHR Variability: {0}".format(fhrstdev))
        FRIVAR = False
    elif (fhrstdev > 15):
        print("FHR Variability: {0}".format(fhrstdev))
        FRIVAR = False
    else:
        FRIVAR = True
    
    # update FRI-FHR Late Recovery
    FRILR = True
    if(laterecovery == 1):
        print("FHR Late Recovery: {0}".format(laterecovery))
        FRILR = False
    else:
        FRILR = True
    
    ret = pd.DataFrame(columns=['CaseID','CaseFrameSeqID','FHRBaselineBPM', 'FHRVariabilityBPM', 'UABaseline', 'NumContractions', 'NumFHRAccelerations', 'NumFHRLateRecovery','FRIExcessiveUA','FRIAccelerations','FRIFhrBaseline','FRIFhrVariability','FRILateRecovery'])
    ret.loc[0] = [df.iloc[0].loc['CaseID'],df.iloc[0].loc['CaseFrameSeqID'],fhrbaseline,fhrstdev,uamode,numcontractions,fhraccelerations,laterecovery,FRIUA,FRIACC,FRIBL,FRIVAR,FRILR]
    ret.CaseID = ret.CaseID.astype(np.int64)
    ret.CaseFrameSeqID = ret.CaseFrameSeqID.astype(np.float64)
    ret.FRIAccelerations = ret.FRIAccelerations.astype(np.int64)
    ret.FRIExcessiveUA = ret.FRIExcessiveUA.astype(np.int64)
    ret.FRIFhrBaseline = ret.FRIFhrBaseline.astype(np.int64)
    ret.FRIFhrVariability = ret.FRIFhrVariability.astype(np.int64)
    ret.FRILateRecovery = ret.FRILateRecovery.astype(np.int64)
    
    return ret



