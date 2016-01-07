%% Workspace Setup
% Decreasing nRes (increasing denominator), seems to decrease Fdrag faster
% than Flift (good). 
filename = 'DataCollects/12_25_15.csv';
Values = 'Final';
Profile = 'Reference';
Type = 'Both';
Geometry = 'Double';
SkipZero = 'SkipZero';

if(strcmp(Values,'Final'))
    liftREF = [0, 16600, 32500, 40000, 44000, 46000];
    dragREF = [0, 3300, 3500, 3000, 2660, 2400]; 
end

mFactor = 1
nFactor = 6

M = 2.4;
mRes = M/mFactor;
N = 1.2;
nRes = N/nFactor;

Velocity = 1;
Steps = 6;
Iterations = 6;

[FliftPlot,FdragPlot] = SweepVelocity(filename,Values,Profile,...
                                 Type,Geometry,SkipZero,M,mRes,N,nRes,...
                                 Velocity,Steps,Iterations)
