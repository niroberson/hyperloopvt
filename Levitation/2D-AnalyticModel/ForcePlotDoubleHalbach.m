close all;
clear all;

%% Chose which parameters to simulate

% Chose which figure to replicate
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
%parameters = 'Hyperloop-Doubles';
%parameters = 'Hyperloop-EMs';
%parameters = 'Hyperloop-Brakes';
parameters = 'Hyperloop-Lateral';

coeff = 'Set2';

%% Specs from different papers

% 3-D Null Flux paper 
if(strcmp(parameters,'3D-Final'))
    vfinal = 41;
    tau_factor = 2;
    width = 0.450;
    numArrays = 2;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.3; % Pole pitch (m)
    p = pi/tau; 
    Br = 1.1; % Magnet remanence (T)
    h = 0.105; % Heigh of permanent magnet (m)

    % Track Parameters
    l = 0.006; % Thickness of track (m)
    sigma_track = 2.54*1e7;
    rho_track = 1/sigma_track; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.050; % Lower air gap (m)
    
elseif(strcmp(parameters,'3D-Initial'))
    vfinal = 41;
    tau_factor = 2;
    numArrays = 0.5;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m) 
    Br = 1.28; % Magnet remanence (T)
    h = 0.1; % Heigh of permanent magnet (m)
    width = 0.050; % Width of magnet (m)

    % Track Parameters
    l = 0.006; % Thickness of track (m)
    sigma_track = 2.54*1e7;
    rho_track = 1/sigma_track; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.032; % Lower air gap (m)
    
elseif(strcmp(parameters,'3D-Experimental'))
    vfinal = 41;
    tau_factor = 2;
    numArrays = 2;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m)
    Br = 1.1; % Magnet remanence (T)
    h = 0.05; % Heigh of permanent magnet (m)
    width = 0.100; % Width of permanent magnet (m)
    
    % Track Parameters
    l = 0.003; % Thickness of track (m)
    sigma_track = 2.57*1e7;
    rho_track = 1/sigma_track; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.021; % Upper air gap (m)
    d2 = 0.042; % Lower air gap (m)

elseif(strcmp(parameters,'Fig4'))
    vfinal = 55;
    tau_factor = 2;
    width = 0.1;
    numArrays = 1;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m)
    Br = 1.277; % Magnet remanence (T)
    h = 0.05; % Heigh of permanent magnet (m)

    % Track Parameters
    l = 0.003; % Thickness of track (m)
    rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.032; % Lower air gap (m)
    
elseif(strcmp(parameters,'Fig7'))
    vfinal = 55;
    tau_factor = 0.25;
    geometry = 'Double';
    width = 0.1;
    numArrays = 2;
   
     % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.8; % Pole pitch (m)
    p = pi/tau; 
    Br = 1.28; % Magnet remanence (T)
    h = 0.1; % Heigh of permanent magnet (m)

    % Track Parameters
    l = 0.01; % Thickness of track (m)
    rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.015; % Upper air gap (m)
    d2 = 0.060; % Lower air gap (m)
    
elseif(strcmp(parameters,'Second-2D'))
    vfinal = 69;
    tau_factor = 2; % 0.7 
    width = 0.200;
    numArrays = 2;
    geometry = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.07; % Pole pitch (m)
    p = pi/tau; 
    Br = 1.34; % Magnet remanence (T)
    h = 0.035; % Heigh of permanent magnet (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    
    % Track Parameters
    l = 0.03; % Thickness of track (m)
   
    % Air gap Parameters
    d1 = 0.020; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
% Characteristic analysis of electrodynamic suspension device
% with permanent magnet Halbach array
elseif(strcmp(parameters,'Third-2D'))
    vfinal = 69;
    tau_factor = 2;
    geometry = 'Single';
    width = 0.1;
    numArrays = 2;
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m)
    Br = 1.277; % Magnet remanence (T)
    h = 0.05; % Heigh of permanent magnet (m)
    rho_track = 3.94*1e-8; % Resistivity of track (Ohm*m)
    
    % Track Parameters
    l = 0.035; % Thickness of track (m)
   
    % Air gap Parameters
    d1 = 0.040; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
elseif(strcmp(parameters,'Fourth-2D'))
    vfinal = 69;
    tau_factor = 2;
    geometry = 'Single';
    width = 0.1;
    numArrays = 2.25;
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m) 
    Br = 1.277; % Magnet remanence (T)
    h = 0.05; % Heigh of permanent magnet (m)
    rho_track = 3.94*1e-8; % Resistivity of track (Ohm*m)
    
    % Track Parameters
    l = 0.035; % Thickness of track (m)
   
    % Air gap Parameters
    d1 = 0.050; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)

% Magplane Paper
elseif(strcmp(parameters,'Magplane'))
    vfinal = 60;
    tau_factor = 2; %0.35
    geometry = 'Single';
    width = 0.48;
    numArrays = 2.125;
    
    % Magnet Parameters
    M = 8; % Number of Magnets in Wavelength
    tau = 0.28; % Pole pitch (m)
    Br = 1.277; % Magnet remanence (T)
    h = 0.2; % Heigh of permanent magnet (m)
    rho_track = 1.68*1e-8; % Resistivity of track (Ohm*m)
    
    % Track Parameters
    l = 0.02; % Thickness of track (m)
   
    % Air gap Parameters
    d1 = 0.1; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
end
    
%% Test Bench Parameters

if(strcmp(parameters,'Test-Rig'))
    vfinal = 135;
    tau_factor = 2;
    width = .0127;
    numArrays = 1.25;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.2254; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0127; % Heigh of permanent magnet (m)

    % Track Parameters
    l = 0.00047; % Thickness of track (m)
    rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.015; % Upper air gap (m)
    d2 = 0.020; % Lower air gap (m)
end

%% Hyperloop Design Specs   

if(strcmp(parameters,'Hyperloop-Doubles'))
    vfinal = 135;
    tau_factor = 2;
    width = .08;
    numArrays = 8;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.018; % Height of permanent magnet (m)

    % Track Parameters
    l = 0.0104648; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.032; % Lower air gap (m)
    
    % Electromagnet Parameters
    %Bre = ur*u0*Ne*Ie;
    
    % Pod Parameters
    PodWeight = 2000; % Pod weight (N)

elseif(strcmp(parameters,'Hyperloop-EMs'))
    vfinal = 135;
    tau_factor = 2;
    width = .08;
    numArrays = 1.25;
    geometry = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.05; % Pole pitch (m)
    Br = 1; % Magnet remanence (T)
    h = 0.05; % Height of permanent magnet (m)

    % Track Parameters
    l = 0.0127; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    %rho_track = 0.00000280; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
    % Electromagnet Parameters
    %Bre = ur*u0*Ne*Ie;
    
    % Pod Parameters
    PodWeight = 2000; % Pod weight (N)
  
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    vfinal = 135;
    tau_factor = 2;
    width = .08;
    numArrays = 1.25;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0225; % Heigh of permanent magnet (m)

    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.001; % Upper air gap (m)
    d2 = 0.01; % Lower air gap (m)
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    vfinal = 135;
    tau_factor = 2;
    width = .08;
    numArrays = 1.25;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0225; % Heigh of permanent magnet (m)

    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.050; % Upper air gap (m)
    d2 = 0.050; % Lower air gap (m)
    
end

%% Weight and Cost Estimates

volumeOneMagnet = h*width*(tau/2);
volumeOneArray = volumeOneMagnet*M;
volumeTotal = volumeOneArray*numArrays; % (m^2)

densityNdFeB = 7500; % Neodymium density (kg/m^2)

weightEstimate_kg = densityNdFeB*volumeTotal*2; % (kg)
weightEstimate_lbs = densityNdFeB*volumeTotal*2.20462*2 % (lbs)
if(strcmp(geometry,'Single'))
    weightEstimate_kg = weightEstimate_kg/2;
    weightEstimate_lbs = weightEstimate_lbs/2;
end

NdFeB_PerPound = 325;
costEstimate = weightEstimate_kg*NdFeB_PerPound % USD

lbsToN = 4.448221628254617;
MagnetWeight = 9.80665*weightEstimate_kg % (N)
weight = MagnetWeight;

%% Setup Simulation

vres = 1;
size = vfinal/vres;

F_lift = zeros(1,size);
F_drag = zeros(1,size);
n = zeros(1,size);
m = zeros(1,size);
o = zeros(1,size);
i = 1;

for v = 0.1:vres:vfinal
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,parameters,geometry,...
                              tau_factor,M,tau,Br,h,l,rho_track,d1,d2,coeff);
    F_lift(1,i) = Fy*width*numArrays;
    F_drag(1,i) = (-1*Fz*width*numArrays);
    n(1,i) = lift_drag_ratio;
    m(1,i) = F_lift(1,i)/weight;
    o(1,i) = (F_lift(1,i)-weight)/weight;
    i = i + 1;
end

v = 0.1:vres:vfinal;
v_kmh = v*3.6;
v_mph = v*2.2;

if(strcmp(parameters,'3D-Final'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,...
                        v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 5])
    set(ax(1),'YTick',[0:1:5])
    set(ax(2),'YLim',[0 50])
    set(ax(2),'YTick',[0:10:50])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
    
    subplot(3,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
    subplot(3,1,3)
    plot(v_kmh,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
elseif(strcmp(parameters,'3D-Initial'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 90])
    set(ax(1),'YTick',[0:30:90])
    set(ax(2),'YLim',[0 450])
    set(ax(2),'YTick',[0:150:450])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;

elseif(strcmp(parameters,'3D-Experimental'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,...
                        v_kmh,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 1500])
    set(ax(1),'YTick',[0:500:1500])
    set(ax(2),'YLim',[0 1500])
    set(ax(2),'YTick',[0:500:1500])
    set(ax(1),'XLim',[0 25])
    set(ax(1),'XTick',[0:5:25])
    grid on;

    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Fig4'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,...
                        v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 140])
    set(ax(1),'YTick',[0:20:140])
    set(ax(2),'YLim',[0 1.4])
    set(ax(2),'YTick',[0:0.2:1.4])
    set(ax(1),'XLim',[0 200])
    set(ax(1),'XTick',[0:50:200])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Fig7'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 140])
    set(ax(1),'YTick',[0:20:140])
    set(ax(2),'YLim',[0 1.4])
    set(ax(2),'YTick',[0:0.2:1.4])
    set(ax(1),'XLim',[0 200])
    set(ax(1),'XTick',[0:50:200])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Second-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,...
                        v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 2])
    set(ax(1),'YTick',[0:0.5:2])
    set(ax(2),'YLim',[0 6])
    set(ax(2),'YTick',[0:1:6])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Third-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 1])
    set(ax(1),'YTick',[0:0.2:1])
    set(ax(2),'YLim',[0 3])
    set(ax(2),'YTick',[0:0.5:3])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Fourth-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 2])
    set(ax(1),'YTick',[0:0.5:2])
    set(ax(2),'YLim',[0 2])
    set(ax(2),'YTick',[0:0.5:2])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Magplane'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag/1000,v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 100])
    set(ax(1),'YTick',[0:10:100])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:10:100])
    set(ax(1),'XLim',[0 60])
    set(ax(1),'XTick',[0:10:60])
    grid on;
    
    subplot(3,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
    subplot(3,1,3)
    plot(v,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
elseif(strcmp(parameters,'Design'))
    Payload = F_lift(1,130) - PodWeight - MagnetWeight;
    
    subplot(2,2,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 700])
    set(ax(1),'YTick',[0:100:700])
    set(ax(2),'YLim',[0 7])
    set(ax(2),'YTick',[0:1:7])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,2);
    [ax,p1,p2] = plotyy(v,((F_lift-weight)/1000),[0.1,vfinal],[Payload/1000,Payload/1000]);
    title('Usable Lift Force');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Usable Lift Force (kN)') % label left y-axis
    ylabel(ax(2),'Payload (kN)') % label right y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:25:135])
    set(ax(1),'YLim',[0 7])
    set(ax(1),'YTick',[0:.5:7])
    set(ax(2),'YLim',[0 7])
    set(ax(2),'YTick',[0:.5:7])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    TeXString = texlabel('UsableForce = F_lift - MagnetWeight');
    text(35,4,TeXString)
    TeXString2 = texlabel('Payload = F_lift - PodWeight - MagnetWeight');
    text(35,1,TeXString2)
    grid on;
    
    subplot(2,2,3);
    [ax,p1,p2]= plotyy(v,n,v,m);
    title('Lift/Drag and Lift/Weight Ratios');
    xlabel('Velocity (m/s)');
    ylabel(ax(1),'Lift/Drag'); % label left y-axis
    ylabel(ax(2),'Lift/Weight'); % label left y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 125])
    set(ax(1),'YTick',[0:25:125])
    set(ax(2),'YLim',[0 6])
    set(ax(2),'YTick',[0:1:6])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,4)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
 elseif(strcmp(parameters,'Design-EM'))
    Payload = F_lift(1,130) - PodWeight - MagnetWeight;
    
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 500])
    set(ax(1),'YTick',[0:50:500])
    set(ax(2),'YLim',[0 500])
    set(ax(2),'YTick',[0:50:500])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(3,1,2);
    [ax,p1,p2]= plotyy(v,n,v,m);
    title('Lift/Drag and Lift/Weight Ratios');
    xlabel('Velocity (m/s)');
    ylabel(ax(1),'Lift/Drag'); % label left y-axis
    ylabel(ax(2),'Lift/Weight'); % label left y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 20])
    set(ax(1),'YTick',[0:5:20])
    set(ax(2),'YLim',[0 15])
    set(ax(2),'YTick',[0:3:15])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(3,1,3)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
 elseif(strcmp(parameters,'Test-Rig'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 20])
    set(ax(1),'YTick',[0:5:20])
    set(ax(2),'YLim',[0 20])
    set(ax(2),'YTick',[0:5:20])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:10:135])
    TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    text(20,25,TeXString)
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 5000])
    set(ax(1),'YTick',[0:1000:5000])
    set(ax(2),'YLim',[0 5000])
    set(ax(2),'YTick',[0:1000:5000])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:10:135])
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 500])
    set(ax(1),'YTick',[0:100:500])
    set(ax(2),'YLim',[0 500])
    set(ax(2),'YTick',[0:100:500])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:10:135])
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on; 
    
end



