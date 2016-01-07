%% Runs Sweep Force with changing arguments

mBound = 3.235;
mRes = 0.5;
nBound = 0.3;
nRes = 1;

Velocity = 55.9234;

%% Sweep mRes
for mRes = 0.1:0.2:2 
    [FliftPlot,FdragPlot] = SweepForceAlex('SweepModelData.csv','Experimental','Custom','Both','Double',mBound,mRes,nBound,nRes,Velocity,6,1,1);
end

%% Sweep nRes
for mRes = 0.1:0.2:2 
    [FliftPlot,FdragPlot] = SweepForceAlex('SweepModelData.csv','Experimental','Custom','Both','Double',mBound,mRes,nBound,nRes,Velocity,6,1,1);
end

%% Sweep mBound
mRes = 0.5;
for mBound = 0.5:0.5:4 
    [FliftPlot,FdragPlot] = SweepForceAlex('SweepModelData.csv','Experimental','Custom','Both','Double',mBound,mRes,nBound,nRes,Velocity,6,1,1);
end

%% Sweep mBound
mBound = 3.235;
for nBound = 0.1:0.2:1.5 
    [FliftPlot,FdragPlot] = SweepForceAlex('SweepModelData.csv','Experimental','Custom','Both','Double',mBound,mRes,nBound,nRes,Velocity,6,1,1);
end