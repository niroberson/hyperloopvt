
function [FliftPlot,FdragPlot] = SweepForce(filename,Values)
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

s1 = 'Initial';
s2 = 'Final';

vlow = 0;
vhigh = 5*8.3333;
vres = 8.3333;
vx = vlow:vres:vhigh;

[rows,cols] = size(vx);
numIterations = cols;

if(strcmp(Values,s1))
    mbound = 2.235; % bound for fourier sums
    mRes = 0.50;
    nbound = 0.3;
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0;
    
    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 140,  262.5  337.5  380,  412];
    dragREF = [0, 26, 37.5, 44.5, 50, 55];
end

if(strcmp(Values,s2))
    mbound = 2.235; % bound for fourier sums
    mRes = 0.50;
    nbound = 0.3;
    nRes = 0.3;
    atol = 1e0; % desired tolerance
    rtol = 1e0;
    
    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 140,  262.5  337.5  380,  412];
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
    waitbar(i/steps,h,sprintf('Loading...%.2f%%',i/steps*100))
    rows = rows + 1;
end

delete(h)
toc % time stop

%% Plot Data

vx = 0:vres:vhigh;
vxKmh = vx*3.6;

plot(vxKmh,FliftPlot)
hold on
plot(vxKmh,liftREF,'--','LineWidth',2);
hold on
plot(vxKmh,FdragPlot)
hold on
plot(vxKmh,dragREF)
xlabel('Vx (km/h)');
ylabel('Force (N)');
legend('Model_Lift','Reference_Lift','Model_Drag','Reference_Drag','location','northwest')



