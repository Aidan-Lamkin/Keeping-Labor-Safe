# -*- coding: utf-8 -*-
"""
Created on Mon Sep 10 16:00:02 2018

@author: lfinco
"""

import pandas as pd
import numpy as np
from scipy.optimize import least_squares
from scipy.stats import norm, lognorm, mode
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import tqdm
import sqlalchemy



# Curve Fitting

def uc(x, t):
    return x[0] + (x[1] * norm.pdf(t, x[2], x[3]))


def ucfunc(x, t, y):
    return x[0] + (x[1] * norm.pdf(t, x[2], x[3])) - y


def uc3(x, t):
    return x[0] + norm.pdf(t, x[1], x[2])


def ucfunc3(x, t, y):
    return x[0] + norm.pdf(t, x[1], x[2]) - y


def ucfunc2(x, t, y):
    return x[0] + (x[1] * lognorm.pdf(t, x[2], x[3], x[4])) - y


def uc2(x, t):
    return x[0] + (x[1] * lognorm.pdf(t, x[2], x[3], x[4]))


tdata = np.array([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543])
ydata = np.array([28,27,26,25,24,23,23,23,24,25,25,25,24,23,22,21,20,20,21,22,23,24,25,25,24,23,21,20,19,19,20,20,21,22,23,23,23,22,22,22,23,24,24,25,25,25,26,27,28,28,28,28,27,27,26,25,24,24,24,25,25,25,25,25,24,24,23,22,21,21,21,21,21,21,21,20,20,20,19,19,18,18,17,17,17,17,17,18,18,19,20,20,21,20,20,20,20,20,20,20,20,20,19,19,18,18,18,18,18,18,18,18,17,17,17,16,16,15,15,14,14,14,13,13,13,13,13,14,15,15,15,15,14,12,11,10,10,10,11,11,12,11,11,10,9,8,8,8,8,9,9,10,10,10,9,8,7,7,8,9,10,11,11,11,9,8,7,6,6,7,7,7,6,7,9,10,11,10,9,8,8,7,8,9,9,10,10,9,8,7,6,6,6,8,9,10,11,11,11,10,9,9,9,11,12,13,15,15,15,15,14,15,16,17,18,19,19,20,20,20,21,22,23,24,25,25,26,26,26,26,26,26,26,26,26,26,26,28,30,32,35,37,38,39,39,40,40,40,41,41,42,43,44,45,46,47,49,51,52,53,54,54,55,54,54,54,55,56,57,58,58,58,58,57,56,56,56,56,57,58,59,60,60,59,58,57,57,57,58,58,59,59,59,58,58,58,59,59,60,60,60,60,60,60,60,60,61,61,62,62,62,62,62,62,62,62,62,61,60,59,58,56,55,54,53,52,51,50,50,49,48,46,45,44,43,43,43,43,43,43,42,41,40,39,38,38,38,38,37,37,37,36,36,36,35,35,35,34,34,34,34,34,34,34,34,33,32,32,32,32,33,34,35,35,35,35,34,34,34,34,34,35,36,36,36,35,34,33,33,33,34,34,34,34,33,31,29,28,28,28,29,30,30,31,31,31,30,29,30,31,32,34,35,35,35,34,33,33,34,35,36,36,36,34,32,31,30,30,30,30,29,29,28,27,27,27,27,26,26,25,24,23,22,21,21,20,20,20,21,21,21,21,21,21,21,21,20,20,19,18,17,17,16,16,16,16,16,17,17,17,17,16,15,15,14,14,14,14,14,14,14,14,13,12,11,10,9,9,10,11,12,12,13,12,12,11,10,10,10,11,11,12,12,12,11,10,9,8,9,9,11,12,12,13,12,11,10,9,8,8,9,10,11,12,12,12,11,11,10,9,10,11,12,13,13,13,13,12,12,12,13,13,13])

tdata = np.array([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367])
ydata = np.array([8,8,9,10,11,12,12,12,11,11,10,9,10,11,12,13,13,13,13,12,12,12,13,13,13,13,12,11,11,11,12,13,14,15,17,18,19,20,22,24,27,28,29,30,31,32,33,34,34,35,36,36,37,38,38,39,39,39,40,40,41,42,44,45,46,47,47,47,48,48,49,50,52,53,54,55,56,56,57,58,59,60,61,61,62,63,64,65,66,66,66,67,66,66,65,63,61,59,58,57,57,57,58,59,60,61,61,62,62,63,63,64,65,66,66,67,67,67,68,68,69,69,70,71,72,72,73,74,75,75,76,77,78,79,79,80,80,81,82,82,83,82,82,82,81,81,81,81,81,81,81,82,82,82,83,83,83,83,83,83,83,83,83,83,83,82,82,81,80,79,78,76,75,74,74,74,76,78,81,85,88,91,93,94,93,90,87,84,82,80,79,79,79,79,79,79,78,78,77,76,75,74,74,73,73,73,72,72,70,69,68,66,65,64,64,64,65,66,66,66,66,65,64,64,64,64,63,63,62,61,59,57,55,53,51,49,48,46,44,43,41,40,40,39,39,39,40,40,40,40,39,38,38,37,36,36,36,37,38,38,39,39,39,40,40,39,39,39,38,38,38,38,37,37,36,35,34,34,33,33,32,32,31,31,30,30,31,31,32,32,32,32,31,31,31,30,30,29,29,28,27,27,26,25,25,25,25,25,25,25,25,25,25,25,25,25,25,26,26,27,27,28,29,30,30,30,31,31,30,30,30,30,30,30,30,30,30,30,29,28,28,27,27,26,26,25,25,25,26,26,26,26,26,26,25,25,25,25,25,26,27,27,27,28,28,28,28])

x0 = np.array([10, 500, 30, 1])
x2 = np.array([30, 50, 2, 150, 1])
x3 = np.array([10, 100, 10])

res_lsq = least_squares(ucfunc3, x3, args=(tdata, ydata))
res_robust = least_squares(ucfunc3, x3, loss='soft_l1', f_scale=0.1, args=(tdata, ydata))
res_huber = least_squares(ucfunc3, x3, loss='huber', f_scale=0.1, args=(tdata, ydata))

res_lsq = least_squares(ucfunc2, x2, args=(tdata, ydata))
res_robust = least_squares(ucfunc2, x2, loss='soft_l1', f_scale=0.5, args=(tdata, ydata))
res_huber = least_squares(ucfunc2, x2, loss='huber', f_scale=0.5, args=(tdata, ydata))

ylsq = uc3(res_lsq.x, tdata)
yrobust = uc3(res_robust.x, tdata)
yhuber = uc3(res_huber.x, tdata)

ylsq = uc2(res_lsq.x, tdata)
yrobust = uc2(res_robust.x, tdata)
yhuber = uc2(res_huber.x, tdata)

res_lsq.x
res_robust.x
res_huber.x


plt.plot(tdata, ydata, label="data")
plt.plot(tdata, ylsq, label="lsq")
plt.plot(tdata, yrobust, label="robust")
plt.plot(tdata, yhuber, label="huber")
plt.xlabel('time')
plt.ylabel('UA')
plt.legend()

#########################################################

# try convolution function in pandas with a few different curves
contraction = []
# stock curves for convolution or correlation
for i in range(30,90):
    normloop = []
    lnormloop = []
    for j in range(0, (i*4)):
        normloop.append(2000*norm.pdf(j, ((i*4)/2), ((i*4)/4)))
        lnormloop.append(2000*lognorm.pdf(j, (i/40), ((i*4)/8), (i*2)))
    np.convolve(df.HR2.values, normloop)
#    contraction.append(normloop)

pd.DataFrame(lnormloop).plot(figsize=(12,8))

#########################################################


connstring = "select * from tKlsSample_New where 'Case ID' = 1 and 'SampleDateTime' = '2014-08-25 06:27:00';"
connstring = "select CaseID, SeqID, SampleDateTime, UA, HR2 from app.tKlsSample_Pivot where [CaseID] = 12 and [SampleDateTime] between '2014-08-25 06:17:00' and '2014-08-25 06:27:00';"
connstring = "select * from app.tKlsSample_Pivot where [CaseID] = 12;"
df = pd.read_sql_query(connstring, cnxn, parse_dates=['SampleDateTime'])

# pyodbc.drivers()
#constring = 'DRIVER={SQL Server};SERVER=keepinglaborsafe.database.windows.net;DATABASE=KeepingLaborSafePoC;UID=sqladmin;PWD=239PotterRd480'
#cnxn = pyodbc.connect(constring)
#cursor = cnxn.cursor()
#cursor.execute("DROP TABLE IF EXISTS ana.KlsStripDetails")
#cnxn.commit()
#engine = sqlalchemy.create_engine('mssql+pyodbc://sqladmin:239PotterRd480@keepinglaborsafe.database.microsoft.net/KeepingLaborSafePoC?driver=SQL%20Server?Integrated Security=False')
#engine = sqlalchemy.create_engine('mssql+pyodbc://KLSPoC')


dtime = '2014-08-25 06:27:00'
dtime2 = datetime.strptime(dtime, '%Y-%m-%d %H:%M:%S')
dtime3 = (dtime2 + timedelta(minutes=-10))

# All rows
cursor.execute("insert into ana.tKlsFrame10Min (CaseID,CaseFrameSeqID,FrameStartDateTime,FrameEndDateTime,FHRBaselineBPM,FHRVariabilityBPM,FHRAccelerationBPM,UABaseline,NumContractions,AvgTimePerContractionSec,TotalTimeContractionSec,TotalTimeRelaxationSec,URRatio,bFHRLateRecovery,bFHROvershoot,bTachycardia,bBradycardia,bNormalUA,bNormalAcceleration,bNormalFHRBaseline,bNormalFHRVariability,bMaternalRiskFactor,bFetalRiskFactor,bObstetricRiskFactor,bTerminalEvent,FRI) values (12,131,'" + \
               (dtime2 + timedelta(minutes=-10)).strftime('%Y-%m-%d %H:%M:%S') + "','" + \
               dtime2.strftime('%Y-%m-%d %H:%M:%S') + "'," + \
               str(fhrbaseline) + "," + \
               str(fhrrange) + "," + \
               str(fhrmax) + "," + \
               str(uamode) + "," + \
               str(numcontractions) + "," + \
               str(avecontractiontime) + "," + \
               str(utime) + "," + \
               str(rtime) + "," + \
               str(urratio) + "," + \
               str(laterecovery) + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + "," + \
               "1" + \
               ")")
cnxn.commit()

# str(tenmin.iloc[i,0]) + "," + str(tenmin.iloc[i,1]) + "," + str(tenmin.iloc[i,2]) + "," + \



# Thresholding

ua = pd.DataFrame({'SeqID':tdata.tolist(), 'UA':ydata.tolist()}, columns=["SeqID", "UA"])
mode(ydata, axis=None)
ua.UA.mode()
ua['uabaseline'] = ua.UA.mode().values[0]
ua['uadiff'] = ua['UA'] - ua['uabaseline']

ua['contraction'] = 0

# loop over sequence 
for l in range(len(df)-1):
    print(l)
#    print ua.at(l,'UA')


#grab one 10-min data frame for testing
    cid=12
df = load_trace(tenmin[tenmin["CaseID"]==cid].iloc[29,3].strftime('%Y-%m-%d %H:%M:%S'), tenmin.iloc[29,4].strftime('%Y-%m-%d %H:%M:%S'), cid, cnxn)

# Plotting
df['zero']=0
df['laterecovery'] = 0
df.plot(x="SampleDateTime", y="HR2", figsize=(12,8))
df.plot(x="SampleDateTime", y="UA", figsize=(12,8))
df.plot(x="SampleDateTime", y=["UA","uamode"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["UA","uamode", "ucthreshold"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["UA","uamode", "uaabovethresh"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["UA","uamode", "uatrunsum"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["UA","uamode", "contraction"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["HR2","fhrmode", "fhrbaseline"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["HR2","fhrmode", "fhrbaseline", "laterecovery"], figsize=(12,8))
df[df['HR2']!=0].plot(x="SampleDateTime", y=["fhrdiff", "zero", "laterecovery"], figsize=(12,8))
df[df['HR2']!=0].plot(x="SampleDateTime", y=["HR2","fhrmode", "fhrbaseline"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["HR2","fhrrange", "fhrstdev", "fhrvar"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["HR2","fhrbaseline", "fhracceleration", "fhrabovethresh", "fhrrunsum"], figsize=(12,8))
df.plot(x="SampleDateTime", y=["HR2","fhracceleration"], figsize=(12,8))

df.plot(x="SampleDateTime", y=["HR2","laterecovery", "UA"], subplots=True, grid=True, ylim=[0,210], figsize=(12,8))
df.plot(x="SampleDateTime", y=["UA","contraction"], subplots=True, grid=True, figsize=(12,8))
df[df['HR2']!=0].plot(x="SampleDateTime", y=["HR2","laterecovery", "UA"], subplots=True, grid=True, figsize=(12,8))

xmintic = dtime3.toordinal()+dtime3.hour/24+dtime3.minute/24/60+dtime3.second/24/60/60
xmaxtic = dtime2.toordinal()+dtime2.hour/24+dtime2.minute/24/60+dtime2.second/24/60/60



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
axs[0].set_title(dtime2.strftime('%Y-%m-%d %H:%M:%S'))
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

plt.show()


        # ??? FHR Acceleration BPM
        fhrmax = np.max(df['HR2'])


df = pd.read_sql_query("select * from app.tKlsSample_Pivot \
                       left join ana.tKlsFrame10Min on app.tKlsSample_Pivot.CaseID = ana.tKlsFrame10Min.CaseID \
                       and app.tKlsSample_Pivot.SampleDateTime between ana.tKlsFrame10Min.FrameStartDateTime and ana.tKlsFrame10Min.FrameEndDateTime;",
                       cnxn)

# update FRI calculations
engine.execute("exec ana.uspCalculateFRIAllCases 1,25")
