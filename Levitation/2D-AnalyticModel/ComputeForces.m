%% Compute Lorentz Forces
clear all;
close all;

PodMass = 500;
weight = PodMass*9.81; % Empty pod
skin = 'plot-';

%% Hyperloop Design Parameters
%parameters = 'Hyperloop-Stilts';
parameters = 'Hyperloop-Brakes'
%parameters = 'Hyperloop-Lateral';
%parameters = 'Hyperloop-Hybrid';
%parameters = 'Test-Rig2';

%% Paper Replica Parameters
%parameters = '3D-Initial';
%parameters = '3D-Final'; 
%parameters = '3D-Experimental'; 
%parameters = 'Fig4';
%parameters = 'Fig7';
%parameters = 'Second-2D';
%parameters = 'Test-Rig';
%parameters = 'Third-2D';
%parameters = 'Fourth-2D';
%parameters = 'Magplane';
%parameters = 'Brakes-Paper';
%parameters = 'Halbach-Brakes';

%% Setup Parameters
[vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
          = ParameterSelect(parameters);

%% Setup Simulation
vres = 1;
size = vfinal/vres;

F_lift = zeros(1,size);
F_drag = zeros(1,size);
n = zeros(1,size);
m = zeros(1,size);
skin_depth = zeros(1,size);
i = 1;

%% Compute Forces
gapInitial = 0;
gapRes = 0.001;
gapFinal = 0.020;
size = gapFinal/gapRes;

F_lift_gap = zeros(1,size);
F_drag_gap = zeros(1,size);

%d1 = 0.010;
%% Sweep Velocity 
for v = 0.1:vres:vfinal
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
     weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,v,d1,h);
    F_lift(1,i) = Force_y;
    F_drag(1,i) = Force_z;
    n(1,i) = LtD;
    m(1,i) = LtW;
    skin_depth(1,i) = skinDepth;
    i = i + 1;
end

%% Magnet Dimensions
fprintf('\nNumber of magnets: %i\r',numMagnets);

length = tau/(M/2);
fprintf('\nSingle Magnet W x L x H (mm) =  %.2f, %.2f, %.2f \r', width*1000,...
         length*1000, h*1000)
fprintf('One Array W x L x H (mm) =  %.2f, %.2f, %.2f \r', width*1000,...
         2*tau*1000, h*1000)

width = width * 39.3701;
length = (tau/2) * 39.3701;
h = h * 39.3701;

fprintf('\nSingle Magnet W x L x H (in) =  %.2f, %.2f, %.2f \r',...
        width, length, h)
fprintf('One Array W x L x H (in) =  %.2f, %.2f, %.2f \r', width,...
         length*M, h)
fprintf('\nMass/Weight Estimates: %.2f (kg), %.2f (lbs), %.2f (N) \r',...
        weightEstimate_kg, weightEstimate_lbs, weightEstimate_kg*9.81)
fprintf('Total length (ft): %0.4f\r',length_feet);

%% Average Force

avg_force = mean(F_drag);
fprintf('\nAverage Force: %i\r',avg_force);

%% Plot Forces
plotForces(parameters,vres,vfinal,F_drag,F_lift,n,m,skin_depth,l,weight,skin);

                          