%% Lateral Stability
clear all;
close all;

parameters = 'Hyperloop-Brakes';

coeff = 'Set2';

% Global Magnet Parameters
M = 4; % Number of Magnets in Wavelength
Br = 1.48; % Magnet remanence (T)
Jc = 0;
Jm = 0;

%% Setup Simulation

vinitial = 110;
mass = 500;

tInitial = 0;
tFinal = 20;
tRes= 0.1;
i = 1;

%% Run Simulations

for t = tInitial:tRes:tFinal
    v = vinitial;
    
    %% Calculate Eddy Brake Drag
    profile = 'Brakes';
    
    width = .045; % Width (m)
    tau = width/1.5; % Pole pitch (m)
    h = 0.0635; % Heigh of permanent magnet (m)
    P = 24;

    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.010; % Upper air gap (m)
    d2 = 0.010; % Lower air gap (m)
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
     weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                            = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                 P,l,rho_track,d1,d2,...
                                                 coeff,profile,Jc,Jm);
    F_eddies = Force_z;
    F_eddies_plot(1,i) = Force_z;
    
    %% Calculate Stilt Drag
    
    profile = 'Single';
    
    width = 0.100; % Width of magnet (m)
    tau = width/1.5; % Pole pitch (m)
    h = tau*.4; % Height of permanent magnet (m)
    P = 5; % Number of arrays to simulate
    
    % Track Parameters
    l = 0.0127; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.020; 
    d2 = 0;         % Lower air gap (m)
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
     weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                            = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                 P,l,rho_track,d1,d2,...
                                                 coeff,profile,Jc,Jm);
    
    F_stilts = Force_z;
    F_stilts_plot(1,i) = Force_z;
    F_drag_total = F_stilts + F_eddies;
    F_drag_total_plot(1,i) = F_drag_total;
    
    %% Kinematics

    vfinal(1,i) = vinitial - (F_drag_total/mass)*tRes;
    d(1,i) = vinitial*tRes + 0.5*(F_drag_total/mass)*(tRes*tRes);
    
   
    vinitial = vfinal(1,i);
    i = i + 1;
end

total_dist_m = sum(d);
total_dist_feet = sum(d)*3.28084

subplot(3,1,1)
t = tInitial:tRes:tFinal;
plot(t,vfinal)
xlabel('Time (s)');
ylabel('Velocity (m/s)');

subplot(3,1,2)
plot(t,F_eddies_plot)

subplot(3,1,3)
plot(t,F_stilts_plot)

