%% Lateral Stability
clear all;
close all;

parameters = 'Hyperloop-Stilts';
coeff = 'Set2';
Jc = 0;
Jm = 0;

if(strcmp(parameters,'Hyperloop-Stilts'))
    vfinal = 135;
    profile = 'Single';
    plot_setting = 'Four-Stilts';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Hc = 11.2*1e3; % Coercive Force of Magnet
    Br = 1.48; % Magnet remanence (T)
   
    width = 0.100; % Width of magnet (m)
    tau = width/1.5; % Pole pitch (m)
    h = tau*.4; % Height of permanent magnet (m)
    length = tau/2;
    P = 1; % Number of arrays to simulate
    if(strcmp(plot_setting,'Four-Stilts'))
        P = 5;
    end
    lengthSingleMagnet = tau/2; 
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0127; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.025; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
    % Electromagnet Parameters
    Jc = 13*1e5; % Current density coil
    Jm = h*Hc; % Current density magnet
    
    PodWeight = 4000; % Pod weight (N)
end

%% Setup Simulation

vres = 1;
size = vfinal/vres;

gapInitial = 0.005;
gapFinal = 0.015;
gapRes = 0.002;
sizeOne = gapFinal/gapRes;

%F_lift = zeros(sizeOne,size);
%F_drag = zeros(sizeOne,size);

i = 1;
j = 1;


%% Run Simulations

for d1 = gapInitial:gapRes:gapFinal
    j = 1;
    for v = 0.1:vres:vfinal
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
         weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                   = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                        P,l,rho_track,d1,d2,...
                                                        coeff,profile,Jc,Jm);
        F_lift(j,i) = Force_y;
        F_drag(j,i) = Force_z;
        j = j + 1;
    end
    d2 = d2 + gapRes;
    i = i + 1;
end

v = 0.1:vres:vfinal;

ax1 = subplot(2,1,1)
plot(v,F_lift/1000)
xlabel('Velocity (m/s)');
ylabel('Lateral Force (kN)');
title('Lateral Restoring Forces at Varying Perturbation Distances from Equillibrium');
legend(ax1,'12mm','10mm','8mm','6mm','4mm','2mm')

ax2 = subplot(2,1,2)
plot(v,F_drag);
xlabel('Velocity (m/s)');
ylabel('Drag Force (N)');
title('Drag Forces at Varying Perturbations Distances from Equillibrium');
legend(ax2,'12mm','10mm','8mm','6mm','4mm','2mm')
