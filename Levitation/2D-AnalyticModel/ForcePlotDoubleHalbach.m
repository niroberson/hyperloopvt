close all;
clear all;

%% Chose which parameters to simulate

% Chose which figure to replicate
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

profile = 'Brakes-';
coeff = 'Set2';

%% Specs from different papers

% 3-D Null Flux paper 
if(strcmp(parameters,'3D-Final'))
    vfinal = 41;
    tau_factor = 2;
    width = 0.450;
    P = 2;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.3; % Pole pitch (m)
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
    numArrays = 2;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m) 
    Br = 1.28; % Magnet remanence (T)
    h = 0.1; % Heigh of permanent magnet (m)
    width = 0.05; % Width of magnet (m)

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
    numArrays = 1;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.277; % Magnet remanence (T)
    tau = 0.1; % Pole pitch (m)
    h = 0.05; % Heigh of permanent magnet (m)
    width = 0.1;

    % Track Parameters
    l = 0.003; % Thickness of track (m)
    rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.032; % Lower air gap (m)
    
elseif(strcmp(parameters,'Fig7'))
    vfinal = 55;
    geometry = 'Double';
   
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.277; % Magnet remanence (T)
    
    tau = 0.8; % Pole pitch (m)
    h = 0.3; % Heigh of permanent magnet (m)
    width = 0.1; % Width of array (m)
    numArrays = 1; % Number of arrays
    
    % Track Parameters
    l = 0.01; % Thickness of track (m)
    rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.015; % Upper air gap (m)
    d2 = 0.060; % Lower air gap (m)
    
elseif(strcmp(parameters,'Second-2D'))
    vfinal = 69;
    geometry = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.34; % Magnet remanence (T)
    tau = 0.07; % Pole pitch (m)
    h = 0.035; % Heigh of permanent magnet (m)
    width = 0.200;
    numArrays = 2;
    
    % Track Parameters
    l = 0.03; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
   
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
    tau_factor = 2;
    geometry = 'Single';
    width = 0.48;
    numArrays = 2.125;
    
    % Magnet Parameters
    M = 8; % Number of Magnets in Wavelength
    tau = 0.48; % Pole pitch (m)
    Br = 0.85; % Magnet remanence (T)
    h = 0.2; % Heigh of permanent magnet (m)
    rho_track = 1.7*1e-8; % Resistivity of track (Ohm*m)
    
    % Track Parameters
    l = 0.02; % Thickness of track (m)
   
    % Air gap Parameters
    d1 = 0.1; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)

elseif(strcmp(parameters,'Brakes-Paper'))
    vfinal = 40;
    tau_factor = 2; %0.35
    geometry = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.277; % Magnet remanence (T)
    tau = 0.05; % Pole pitch (m) 
    h = 0.025; % Heigh of permanent magnet (m)
    width = 0.025;
    numArrays = 1.5;
    conductivity = 1.57*1e6; % Conductivity
    rho_track = 1/conductivity; % Resistivity of track (Ohm*m)
    
    % Track Parameters
    l = 0.01; % Thickness of track (m)
   
    % Air gap Parameters
    d1 = 0.010; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)

elseif(strcmp(parameters,'Halbach-Brakes'))
    vfinal = 70;
    tau_factor = 2; %0.35
    geometry = 'Single';
    
    % Magnet Parameters
    M = 8; % Number of Magnets in Wavelength
    Br = 1.38; % Magnet remanence (T)
    
    tau = 0.030; % Pole pitch (m)
    width = 0.015;
    numArrays = 2;
    h = 0.015; % Heigh of permanent magnet (m)
    
    % Track Parameters
    l = 0.005; % Thickness of track (m)
    rho_track = 1.7*1e-8; % Resistivity of track (Ohm*m)
   
    % Air gap Parameters
    d1 = 0.005; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
end

%% Setup Simulation

vres = 0.1;
size = vfinal/vres;

F_lift = zeros(1,size);
F_drag = zeros(1,size);
n = zeros(1,size);
m = zeros(1,size);
o = zeros(1,size);
i = 1;

Jc = 0;
Jm = 0;
u0 = 4*pi*1e-7; % permeability of free space

for v = 0.1:vres:vfinal
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                 = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                      P,l,rho_track,d1,d2,...
                                                      coeff,profile,Jc,Jm);
    F_lift(1,i) = Force_y;
    F_drag(1,i) = Force_z;
    n(1,i) = LtD;
    m(1,i) = LtW;
    skin_depth(1,i) = skinDepth;
    %o(1,i) = (F_lift(1,i)-weight)/weight;
    i = i + 1;
end

v = 0.1:vres:vfinal;
v_kmh = v*3.6;
v_mph = v*2.2;

if(strcmp(parameters,'3D-Final'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v_kmh,(F_drag)/1000,...
                        v_kmh,(F_lift)/1000,'plot','plot');
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
    
    if(strcmp(profile,'Brakes'))
        title('Lift and Drag Forces');
        xlabel(ax(1),'Velocity (km/h)') % label x-axis
        ylabel(ax(1),'Drag Force (kN)') % label left y-axis
        ylabel(ax(2),'Lift Force (kN)') % label right y-axis
        set(ax(1),'YLim',[0 1000])
        set(ax(1),'YTick',[0:200:1000])
        set(ax(2),'YLim',[0 100])
        set(ax(2),'YTick',[0:20:100])
        set(ax(1),'XLim',[0 150])
        set(ax(1),'XTick',[0:30:150])
        grid on;
    end
    
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
    set(ax(1),'YLim',[0 500])
    set(ax(1),'YTick',[0:100:500])
    set(ax(2),'YLim',[0 5000])
    set(ax(2),'YTick',[0:1000:5000])
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
    subplot(3,1,1);
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
    
    subplot(3,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
    subplot(3,1,3)
    plot(v_kmh,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
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

elseif(strcmp(parameters,'Brakes-Paper'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 100])
    set(ax(1),'YTick',[0:20:100])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:20:100])
    set(ax(1),'XLim',[0 40])
    set(ax(1),'XTick',[0:5.5:40])
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
    
elseif(strcmp(parameters,'Halbach-Brakes'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 35])
    set(ax(1),'YTick',[0:5:35])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:20:100])
    set(ax(1),'XLim',[0 70])
    set(ax(1),'XTick',[0:14:70])
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
    
end





