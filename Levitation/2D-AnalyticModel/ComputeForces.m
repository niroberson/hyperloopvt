%% Compute Lorentz Forces
clear all;
close all;

%% Hyperloop Design Parameters
%parameters = 'Hyperloop-Stilts';
%parameters = 'Hyperloop-Brakes';
%parameters = 'Hyperloop-Lateral';

%% Paper Replica Parameters
%parameters = '3D-Initial';
parameters = '3D-Final'; 
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
for v = 0.1:vres:vfinal
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
     weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,v);
    F_lift(1,i) = Force_y;
    F_drag(1,i) = Force_z;
    n(1,i) = LtD;
    m(1,i) = LtW;
    skin_depth(1,i) = skinDepth;
    i = i + 1;
end

%% Plot Forces
plotForces(parameters,vres,vfinal,F_drag,F_lift,n,m);


                            
                          