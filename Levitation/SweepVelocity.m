
function [FliftPlot,FdragPlot] = SweepVelocity(filename,Values,Profile,...
                                 Type,Geometry,SkipZero,M,mRes,N,nRes,...
                                 Velocity,Steps,Iterations)
% This is called from the command line
%
% Inputs: Filename, Values, Profile, Velocity, Steps, SkipZero
%   Filename: Any .csv format file name to store data
%   Values: 'Initial', 'Final', 'Experimental', 'Custom'   
%   Profile: 'Custom' or 'Reference'
%   Type: 'Lift', 'Drag', or 'Both'
%   Geometry: 'Double' or 'Single' sided halbach array
%   SkipZero: 'SkipZero' or 'Nothing'
%   M = top bound for M summation
%   mRes = resolution step for M summation
%   N = top bound for N summation
%   nRes = resolution step for N summation   
%   Velocity: Final Velocity (if Profile set to 'Cutsom') (mph)
%   Steps: How many steps/iterations, including zero
%   Iterations: Number of velocity iterations
%   
%
% Outputs: data in .csv format, plots of forces
%
% example: >> [FliftPlot,FdragPlot] = SweepForceAlex('SweepModelData.csv','Experimental','Custom','Both','Double',...
%                                                     3.235,0.5,0.3,1,1,6,1,1);

fprintf('Running SweepVelocity.m\n')

%% Setup bound parameters and resolutions

% best results: m=2.235 mRes = 0.5 n = 0.3 nRes = 1 atol=rtol=1e0 (lift)
if(strcmp(Values,'Initial')) 
    M = 2.235; % 2.235 bound for fourier sums
    mRes = 0.5;
    N = 0.3;
    nRes = 1;
    
    % reference values from null flux paper (initial values)
    liftREF = [0, 127.5, 270, 345, 382.5, 405];
    dragREF = [0, 26, 37.5, 44.5, 50, 55];

% best results: m=3.542 mRes = 0.5 n = 0.3 nRes = 1 atol=rtol=1e0 (lift)
% n = 0.4 (drag)
elseif(strcmp(Values,'Final'))
    %M = 3.5; %3.542 bound for fourier sums
    %mRes = 0.50;
    %N = 0.4; 
    %nRes = 1;
    
    % reference values from null flux paper (final values)
    liftREF = [0, 16600, 32500, 40000, 44000, 46000];
    dragREF = [0, 3300, 3500, 3000, 2660, 2400]; 

% best results M = 3.235 mRes: 0.5 N = 0.3 nRes = 1,
% atol=rtol=1e0 (lift) w2, l2 from final values
elseif(strcmp(Values,'Experimental'))
    %M = 3.235; % bound for fourier sums
    %mRes = 0.5;
    %N = 0.285;
    %nRes = 1;

    % reference values from null flux paper for vx = 0:8.3:5*8.3
    liftREF = [0, 120, 375, 740, 1050, 1333];
    dragREF = [0, 187.5, 302, 396, 416, 435]; 

elseif(strcmp(Values,'Custom'))
    %M = 3.2; % bound for fourier sums
    %mRes = 0.5;
    %N = 0.28;
    %nRes = 1;
    
    % Experimental Results
    liftREF = [0,0,0,0,0];
    dragREF = [0,0,0,0,0]; 
end

atol = 1e0;
rtol = 1e0;

%% Setup iterations

if(strcmp(Profile,'Reference'))
    vlow = 0;
    vres = 8.3333;
    vhigh = 5*vres;
    if(strcmp(Values,'Experimental'))
        vlow = 0;
        vres = 5;
        vhigh = 25;
    end
    
elseif(strcmp(Profile,'Custom'))
    % convert to m/s
    Velocity = Velocity*0.44704;
    vlow = 0;
    vres = Velocity/(Steps-1);
    vhigh = Velocity;
end 

i = 2;
% Preallocate
FliftPlot = zeros(1,Steps);
FdragPlot = zeros(1,Steps);

% Skip Vx = 0 calculation
if(strcmp(SkipZero,'SkipZero'))
    vlow = vlow+vres;
    Iterations = Iterations-1;
end

%% Setup Saving Data to File

headers = {'Vx','Flift','Fdrag','mHigh','mRes','nHigh','nRes','Atol','Rtol','Values','Type'};
Matrix = [0,0,0,M,mRes,N,nRes,atol,rtol,0,0];
csvwrite_with_headers(filename,Matrix,headers)

%% Start Computations

tic % time start

for vx = vlow:vres:Iterations*vres
    % Calculate Lift and Drag Forces
    if(strcmp(Geometry,'Double'))
        [Flift,Fdrag] = MagnetEquationsAlex(vx,M,N,atol,rtol,mRes,nRes,Values,Type);
    elseif(strcmp(Geometry,'Single'))
        [Flift,Fdrag] = MagnetEquationsSingle(vx,M,N,atol,rtol,mRes,nRes,Values,Type);
    end
    fprintf('Vx: %d mHigh: %d nHigh: %d mRes: %d nRes: %d Flift: %d Fdrag: %d \r',...
        vx,M,N,mRes,nRes,Flift,Fdrag*-1)
    
    % Copy data
    FliftPlot(1,i) = Flift;
    FdragPlot(1,i) = Fdrag*-1;
    
    % Output to file
    Matrix = [vx,Flift,Fdrag];
    dlmwrite (filename, Matrix,'-append');
    
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
        title(['Force Equations (Initial Values): M: ' num2str(M) ' mRes:  ' num2str(mRes)...
                ' N: ' num2str(N) ' nRes:  ' num2str(nRes)])
        ylabel('Force (N)');
        hold on
    end

    if(strcmp(Values,'Final'))
        factor = 1000;
        vx = 0:8.3333:5*8.3333;
        v = vx*3.6;
        vxREF = v;
        title(['Force Equations (Final Values): M: ' num2str(M) ' mRes:  ' num2str(mRes)...
                ' N: ' num2str(N) ' nRes:  ' num2str(nRes)])
        ylabel('Force (kN)');
        hold on
    end

    if(strcmp(Values,'Experimental'))
        factor = 1;
        v = 0:5:5*5;
        vxREF = v;
        title(['Force Equations (Experimental Values): M: ' num2str(M) ' mRes:  ' num2str(mRes)...
                ' N: ' num2str(N) ' nRes:  ' num2str(nRes)])
        ylabel('Force (N)');
        hold on
    end

    plot(v,FliftPlot/factor,'LineWidth',2)
    hold on
    plot(vxREF,liftREF/factor,'--','LineWidth',2);
    hold on
    plot(v,FdragPlot/factor,'LineWidth',2)
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
