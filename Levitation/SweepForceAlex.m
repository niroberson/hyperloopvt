
function [FliftPlot,FdragPlot] = SweepForce(filename,Values,Profile,Velocity,Steps,SkipZero)
% This is called from the command line
%
% Inputs: Filename, Values, Profile, Velocity, Steps, SkipZero
%   Filename: Any .csv format file name to store data
%   Values: 'Initial', 'Final', 'Experimental', 'Custom'   
%   Profile: 'Custom' or 'Reference'
%   Velocity: Final Velocity (if Profile set to 'Cutsom') (mph)
%   Steps: How many steps/iterations, including zero
%   SkipZero: Set equal to 1 to skip first (0) calculation
%
% Outputs: data in .csv format, plots of forces
%
% example: >> SweepForce('MagnetEquationsData.csv', 'Initial', 'Reference', 200, 6, 1)
% example: >> SweepForce('MagnetEquationsData.csv', 'Final', 'Custom', 200, 8, 0)


%% Setup bound parameters and resolutions

% best results: m=2.235 mRes = 0.5 n = 0.3 nRes = 1 atol=rtol=1e0
if(strcmp(Values,'Initial')) 
    mbound = 2.235; % 2.235 bound for fourier sums
    mRes = 0.50;
    nbound = 0.3;
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0; % has little to no effect?
    
    % reference values from null flux paper (initial values)
    liftREF = [0, 127.5, 270, 345, 382.5, 405];
    dragREF = [0, 26, 37.5, 44.5, 50, 55];

elseif(strcmp(Values,'Final'))
    mbound = 3.542; %3.542 bound for fourier sums
    mRes = 0.50;
    nbound = 0.3; 
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0; 
    
    % reference values from null flux paper (final values)
    liftREF = [0, 16600, 32500, 40000, 44000,  46000];
    dragREF = [0, 26, 37.5, 44.5, 50, 55]; 

elseif(strcmp(Values,'Experimental')) % w2, l2 = w2,l2 final values
    mbound = 3.235; % bound for fourier sums
    mRes = 0.5;
    nbound = 0.3;
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0;
    
    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 120, 375, 740, 1050, 1333];
    dragREF = [0, 26, 37.5, 44.5, 50, 55]; 

elseif(strcmp(Values,'Custom'))
    mbound = 3.235; % bound for fourier sums
    mRes = 0.5;
    nbound = 0.3;
    nRes = 1;
    atol = 1e0; % desired tolerance
    rtol = 1e0;
    
    % Experimental Results
    liftREF = [0,0,0,0];
    dragREF = [0,0,0,0]; 
end

%% Setup iterations

if(strcmp(Profile,'Reference'))
    vlow = 0;
    vres = 8.3333;
    vhigh = 5*vres;
    
elseif(strcmp(Profile,'Custom'))
    % conver to m/s
    Velocity = Velocity*0.44704;
    vlow = 0;
    vres = Velocity/(Steps-1);
    vhigh = Velocity;
end 

i = 2;
FliftPlot = zeros(1,Steps);
FdragPlot = zeros(1,Steps);

if(SkipZero == 1)
    vlow = vlow+vres;
end

%% Setup Saving Data to File

headers = {'Vx','Flift','Fdrag','mHigh','mRes','nHigh','nRes','Atol','Rtol','Values'};
M = [0,0,0,mbound,mRes,nbound,nRes,atol,rtol,0];
csvwrite_with_headers(filename,M,headers)

%% Start Computations

tic % time start

for vx = vlow:vres:vhigh
    % Calculate Lift and Drag Forces
    [Flift,Fdrag] = MagnetEquationsAlex(vx,0,0,mbound,nbound,atol,rtol,mRes,nRes,Values);
    fprintf('Vx: %d mHigh: %d nHigh: %d Atol: %d Rtol: %d mRes: %d nRes: %d Values: %s Flift: %d Fdrag: %d \r',...
        vx,mbound,nbound,atol,rtol,mRes,nRes,Values,Flift,Fdrag)
    
    % Copy data
    FliftPlot(1,i) = Flift;
    FdragPlot(1,i) = Fdrag;
    
    % Output to file
    M = [vx,Flift,Fdrag];
    dlmwrite (filename, M,'-append');
    
    i = i + 1;
end

toc % time stop

%% Plot Data

if(strcmp(Profile,'Reference'))
    if(strcmp(Values,'Initial'))
        factor = 1;
        vx = 0:8.3333:5*8.3333;
        v = vx*3.6;
        vxREF = v;
        title(['Force Equations (Initial Values): mBound: ' num2str(mbound) ' mRes:  ' num2str(mRes)...
                ' nBound: ' num2str(nbound) ' nRes:  ' num2str(nRes)])
        ylabel('Force (N)');
        hold on
    end

    if(strcmp(Values,'Final'))
        factor = 1000;
        vx = 0:8.3333:5*8.3333;
        v = vx*3.6;
        vxREF = v;
        title(['Force Equations (Final Values): mBound: ' num2str(mbound) ' mRes:  ' num2str(mRes)...
                ' nBound: ' num2str(nbound) ' nRes:  ' num2str(nRes)])
        ylabel('Force (kN)');
        hold on
    end

    if(strcmp(Values,'Experimental'))
        factor = 1;
        v = 0:5:5*5;
        vxREF = v;
        title(['Force Equations (Experimental Values): mBound: ' num2str(mbound) ' mRes:  ' num2str(mRes)...
                ' nBound: ' num2str(nbound) ' nRes:  ' num2str(nRes)])
        ylabel('Force (N)');
        hold on
    end

    plot(v,FliftPlot/factor)
    hold on
    plot(vxREF,liftREF/factor,'--','LineWidth',2);
    hold on
    plot(v,FdragPlot/factor)
    hold on
    plot(vxREF,dragREF/factor,'--','LineWidth',2);
    xlabel('Vx (km/h)');
    legend('Model Lift','Reference Lift','Model Drag','Reference Drag','location','northwest')
    grid on

else
    v = 0:vres:vhigh;
    plot(v,FliftPlot)
    xlabel('Vx (mph)');
    ylabel('Force (N)');
    grid on
end
