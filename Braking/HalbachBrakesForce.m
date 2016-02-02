%% Lateral Stability
clear all;
close all;

%parameters = 'Hyperloop-Lateral';
parameters = 'Hyperloop-Brakes';

coeff = 'Set2';
Jc = 0;
Jm = 0;

if(strcmp(parameters,'Hyperloop-Lateral'))
    vfinal = 135;
    tau_factor = 2;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.48; % Magnet remanence (T)
    
    width = .045 % Width (m)
    tau = width/1.5 % Pole pitch (m)
    h = tau*0.8 % Heigh of permanent magnet (m)
    P = 2; % Pole pair 
    lambda = 2*tau;
    length = tau/2
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    %d1 = 0.010; % Upper air gap (m)
    %d2 = 0.020; % Lower air gap (m)
    d2 = 0.020;
    
    elseif(strcmp(parameters,'Hyperloop-Brakes'))
    vfinal = 135;
    profile = 'Brakes';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.48; % Magnet remanence (T)
    
    width = .045; % Width (m)
    tau = width/1.5 % Pole pitch (m)
    h = 0.0635; % Heigh of permanent magnet (m)
    P = 24; 
    
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.005; % Upper air gap (m)
    d2 = 0.005; % Lower air gap (m)
    
end

%% Setup Simulation

vres = 1;
size = vfinal/vres;

gapInitial = 0.005;
gapFinal = 0.017;
gapRes = 0.003;
d1 = gapInitial;
d2 = gapInitial;

i = 1;
j = 1;


%% Run Simulations

for d1 = gapInitial:gapRes:gapFinal
    j = 1;
    d2 = d1;
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
    %d2 = d2 + gapRes;
    i = i + 1;
end

v = 0.1:vres:vfinal;
    
if(strcmp(parameters,'Hyperloop-Brakes'))
    ax1 = subplot(2,1,1)
    plot(v,F_lift/1000)
    xlabel('Velocity (m/s)');
    ylabel('Lateral Force (kN)');
    title('Lateral Restoring Forces at Varying Perturbation Distances from Equillibrium');
    legend(ax1,'5mm','8mm','11mm','14mm');

    ax2 = subplot(2,1,2)
    plot(v,F_drag/1000);
    xlabel('Velocity (m/s)');
    ylabel('Drag Force (kN)');
    title('Braking Forces at Varying Distances from Rail');
    legend(ax2,'5mm','8mm','11mm','14mm','17mm')
end

