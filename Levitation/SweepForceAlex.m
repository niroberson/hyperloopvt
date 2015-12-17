
function [FliftPlot,FdragPlot] = SweepForce(filename,Values,steps)
% This is called from the command line
%
% Inputs: Filename, Values
%   Filename: Any .csv format file name to store data
%   Values: 'Initial', 'Final', 'Experimental', 'Custom'
%
% Outputs: data in .csv format
%
% example: >> SweepForce('MagnetEquationsData.csv', 'Initial')
% example: >> SweepForce('MagnetEquationsData.csv', 'Final')

if(steps == 6)
    vlow = 0;
    vhigh = 5*8.3333;
    vres = 8.3333;
    vx = vlow:vres:vhigh;
end

if(steps == 11)
    vlow = 0;
    vhigh = 10*4.16667;
    vres = 4.16667;
    vx = vlow:vres:vhigh;
end

[~,cols] = size(vx);
numIterations = cols;

if(strcmp(Values,'Initial')) % best results: m=2.235 mRes = 0.5 n = 0.3 nRes = 1 atol=rtol=0
    mbound = 2.235; % bound for fourier sums
    mRes = 0.50;
    nbound = 0.3;
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0; % has little to no effect?
    
    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 127.5, 270, 345, 382.5, 405];
    dragREF = [0, 26, 37.5, 44.5, 50, 55];
end

if(strcmp(Values,'Final'))
    mbound = 3.542; % bound for fourier sums
    mRes = 0.50;
    nbound = 0.3; %2925
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0; 
    
    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 16600, 32500, 40000, 44000,  46000];
    dragREF = [0, 26, 37.5, 44.5, 50, 55]; 
end

if(strcmp(Values,'Experimental'))
    mbound = 2.235; % bound for fourier sums
    mRes = 0.50;
    nbound = 0.3;
    nRes = 0.3;
    atol = 1e0; % desired tolerance
    rtol = 1e0;
    
    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 120, 375, 740, 1050, 1333];
    dragREF = [0, 26, 37.5, 44.5, 50, 55]; 
end

headers = {'Vx','Flift','Fdrag','mHigh','mRes','nHigh','nRes','Atol','Rtol','Values'};
M = [0,0,0,mbound,mRes,nbound,nRes,atol,rtol,0];
csvwrite_with_headers(filename,M,headers)

tic % time start
h = waitbar(0,'Loading...','Name','Are we there yet?');
steps = numIterations-1;

rows = 2;
FliftPlot(1,1) = 0;
FdragPlot(1,1) = 0;

vlow = vlow+vres; % Skip zero calculation
for vx = vlow:vres:vhigh
    % Calculate Lift and Drag Forces
    [Flift,Fdrag] = MagnetEquationsAlex(vx,0,0,mbound,nbound,atol,rtol,mRes,nRes,Values);
    fprintf('Vx: %d mHigh: %d nHigh: %d Atol: %d Rtol: %d mRes: %d nRes: %d Values: %s Flift: %d Fdrag: %d \r',...
        vx,mbound,nbound,atol,rtol,mRes,nRes,Values,Flift,Fdrag)
    
    FliftPlot(1,rows) = Flift; 
    FdragPlot(1,rows) = Fdrag;
    
    % Output to file
    M = [vx,Flift,Fdrag];
    dlmwrite (filename, M,'-append');
    
    % Status bar
    waitbar(rows/steps,h,sprintf('Loading...%.2f%%',rows/steps*100))
    rows = rows + 1;
end

delete(h)
toc % time stop

%% Plot Data

vx = 0:8.3333:5*8.3333;
vxKmh = vx*3.6;
v = 0:8.3333:5*8.3333;
vxREF = v*3.6;

if(strcmp(Values,'Initial'))
    factor = 1;
    title(['Force Equations (Initial Values): mBound: ' num2str(mbound) ' mRes:  ' num2str(mRes)...
            ' nBound: ' num2str(nbound) ' nRes:  ' num2str(nRes)])
    ylabel('Force (N)');
    hold on
end

if(strcmp(Values,'Final'))
    factor = 1000;
    title(['Force Equations (Final Values): mBound: ' num2str(mbound) ' mRes:  ' num2str(mRes)...
            ' nBound: ' num2str(nbound) ' nRes:  ' num2str(nRes)])
    ylabel('Force (kN)');
end

plot(vxKmh,FliftPlot/factor)
hold on
plot(vxREF,liftREF/factor,'--','LineWidth',2);
hold on
plot(vxKmh,FdragPlot/factor)
hold on
plot(vxKmh,dragREF/factor,'--','LineWidth',2);
xlabel('Vx (km/h)');
legend('Model Lift','Reference Lift','Model Drag','Reference Drag','location','northwest')
grid on

