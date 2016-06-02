%% Compute Lorentz Forces
clear all;
close all;

PodMass = 250;
weight = PodMass*9.81;
skin = 'plot-';
model = 'new';

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

%% Sweep Velocity 
for v = 0.1:vres:vfinal
    if strcmp(model,'new')
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModelNew(parameters,v,d1,h);
    else
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModelNew(parameters,v,d1,h);
    end
    
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
fprintf('\nSingle Magnet W x L x H (mm)(X-Z-Y) =  %.2f, %.2f, %.2f \r', width*1000,...
         length*1000, h*1000)
fprintf('One Array W x L x H (mm)(X-Z-Y) =  %.2f, %.2f, %.2f \r', width*1000,...
         2*tau*1000, h*1000)

width = width * 39.3701;
length = (tau/2) * 39.3701;
h = h * 39.3701;
length_in = length_feet*12;


fprintf('\nSingle Magnet W x L x H (in)(X-Z-Y) =  %.2f, %.2f, %.2f \r',...
        h, length, width)
fprintf('One Array W x L x H (in)(X-Z-Y) =  %.2f, %.2f, %.2f \r', h,...
         length*M, width)
fprintf('Number of Arrays: %i\r',P);

fprintf('\nMass/Weight Estimates: %.2f (kg), %.2f (lbs), %.2f (N) \r',...
        weightEstimate_kg, weightEstimate_lbs, weightEstimate_kg*9.81)
    
if(strcmp(parameters,'Hyperloop-Stilts'))
    fprintf('Total Structure Length(z): %0.4f (ft) %0.4f (in)\r',length_feet,length_in);
    fprintf('Total Structure Width(x): %0.4f (ft) %0.4f (in)\r',width/12,width);
    fprintf('Total Structure Height(y): %0.4f (ft) %0.4f (in)\r',h/12,h);
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    fprintf('Total Structure Length(z): %0.4f (ft) %0.4f (in)\r',length_feet,length_in);
    fprintf('Total Structure Width(x): %0.4f (ft) %0.4f (in)\r',width/12,width);
    fprintf('Total Structure Height(y): %0.4f (ft) %0.4f (in)\r',h/12,h);

elseif(strcmp(parameters,'Hyperloop-Brakes'))
    fprintf('Total Structure Length(z): %0.4f (ft) %0.4f (in)\r',length_feet,length_in);
    fprintf('Total Structure Width(x): %0.4f (ft) %0.4f (in)\r',width/12,width);
    fprintf('Total Structure Height(y): %0.4f (ft) %0.4f (in)\r',h/12,h);
    
end
%% Average Force

avg_force = mean(F_drag/1000);
fprintf('\nAverage Force: %i (kN)\r',avg_force);

%% Test Rig Info
DiscDiameter_ft = 3.5;
DiscDiameter_m = DiscDiameter_ft * 0.3048;
Torque = max(F_drag)*(DiscDiameter_m/2);
    
fprintf('\nMax Torque Load on Motor: %0.4f Nm\r',Torque)

%% Plot Forces
plotForces(parameters,vres,vfinal,F_drag,F_lift,n,m,skin_depth,l,weight,...
           skin,profile,d1,d2);

                          