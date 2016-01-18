%% Design for Hyperloop

close all;
clear all;

parameters = 'Hyperloop-Doubles';
%parameters = 'Hyperloop-Stilts';
%parameters = 'Hyperloop-Brakes';
%parameters = 'Hyperloop-Lateral';

%profile = 'Brakes-';
profile = 'Stability-';
coeff = 'Set2';

Jc = 0;
Jm = 0;
u0 = 4*pi*1e-7; % permeability of free space
    
%% Test Bench Parameters

if(strcmp(parameters,'Test-Rig'))
    vfinal = 135;
    tau_factor = 2;
    numArrays = 1.25;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.2254; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0127; % Heigh of permanent magnet (m)
    width = .0127;
    width = width*2;
    
    % Track Parameters
    %l = 0.00047; % Thickness of track (m)
    l = 0.003175; % 1/8th inch thick 
    %rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)%
    rho_track = 3.99*1e-8; % 6061 Resistivity

    % Air gap Parameters
    d1 = 0.015; % Upper air gap (m)
    d2 = 0.030; % Lower air gap (m)
end

%% Hyperloop Design Specs   

if(strcmp(parameters,'Hyperloop-Doubles'))
    vfinal = 135;
    tau_factor = 2;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.48; % Magnet remanence (T)
    
    % Magnet Geometry 
    %tau = 0.24; %1
    %h = 0.01905; %1
    %width = 0.06; %1
    
    tau = 0.1016*2;% 2
    %h = 0.0254; % 2
    h = 0.03175;
    %h = 0.03;
    %h = 0.03175;
    width = 0.03175*2;
    %width = 0.0254*2;
    numArrays = 4;
   
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0104648; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.017; % Upper air gap (m)
    d2 = 0.030; % Lower air gap (m)
    
    % Pod Parameters
    PodWeight = 2000; % Pod weight (N)

elseif(strcmp(parameters,'Hyperloop-Stilts'))
    vfinal = 135;
    tau_factor = 2;
    geometry = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Hc = 11.2*1e3; % Coercive Force of Magnet
    Br = 1.48; % Magnet remanence (T)
   
    tau = 0.0254*2; % Pole pitch (m)
    h = 0.0254; % Height of permanent magnet (m)
    width = 0.0254; % Width of magnet (m)
    numArrays = 1.25; % Number of arrays to simulate
    lengthSingleMagnet = tau/2; 
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0127; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.017; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
    % Electromagnet Parameters
    Jc = 13*1e5; % Current density coil
    Jm = h*Hc; % Current density magnet
    
    PodWeight = 2000; % Pod weight (N)
  
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    vfinal = 135;
    tau_factor = 2;
    
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    
    tau = 0.2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0225; % Heigh of permanent magnet (m)
    width = .08;
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.001; % Upper air gap (m)
    d2 = 0.01; % Lower air gap (m)
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    vfinal = 135;
    tau_factor = 2;
    geometry = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.0254*2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0254; % Heigh of permanent magnet (m)
    width = .045; % Width 
    numArrays = 1.25; 
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.020; % Upper air gap (m)
    d2 = 0.025; % Lower air gap (m)
    
end

%% Weight and Cost Estimates

numMagnets = numArrays*M*2*2;
length = tau*2*numArrays;
length_feet = 3.28084*length
if(strcmp(geometry,'Single'))
    numMagnets = numArrays*M;
end
 
numMagnets

volumeOneMagnet = h*width*(tau/2);
volumeOneArray = volumeOneMagnet*M;
volumeTotal = volumeOneArray*numArrays; % (m^2)

densityNdFeB = 7500; % Neodymium density (kg/m^2)

weightEstimate_kg = densityNdFeB*volumeTotal*2; % (kg)
weightEstimate_lbs = densityNdFeB*volumeTotal*2.20462*2; % (lbs)
if(strcmp(geometry,'Single'))
    weightEstimate_kg = weightEstimate_kg/2;
    weightEstimate_lbs = weightEstimate_lbs/2;
end
%if(strcmp(geometry,'Hybrid'))
%    weightEstimate_kg = weightEstimate_kg/2;
%    weightEstimate_lbs = weightEstimate_lbs/2;
%end

weightEstimate_kg
weightEstimate_lbs

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
skin_depth = zeros(1,size);
i = 1;

for v = 0.1:vres:vfinal
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,geometry,...
                              tau_factor,M,tau,Br,h,l,rho_track,d1,d2,...
                              coeff,profile,Jc,Jm);
    F_lift(1,i) = Fy*width*numArrays;
    F_drag(1,i) = (-1*Fz*width*numArrays);
    n(1,i) = lift_drag_ratio;
    m(1,i) = F_lift(1,i)/weight;
    o(1,i) = (F_lift(1,i)-weight)/weight;
    skin_depth(1,i) = sqrt(1/(pi*(v./lambda)*u0*sigma));
    i = i + 1;
end

v = 0.1:vres:vfinal;
v_kmh = v*3.6;
v_mph = v*2.2;

%% Hyperloop Related Plots
if(strcmp(parameters,'Hyperloop-Doubles'))
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
    
    if(strcmp(geometry,'Single'))
        xlabel(ax(1),'Velocity (m/s)')  % label x-axis
        ylabel(ax(1),'Drag Force (N)') % label left y-axis
        ylabel(ax(2),'Lift Force (kN)') % label right y-axis
        set(ax(1),'YLim',[0 20])
        set(ax(1),'YTick',[0:5:20])
        set(ax(2),'YLim',[0 20])
        set(ax(2),'YTick',[0:5:20])
        set(ax(1),'XLim',[0 135])
        set(ax(1),'XTick',[0:15:135])
        set(ax(2),'XLim',[0 135])
        set(ax(2),'XTick',[0:15:135])
        grid on;
    end
    
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
    set(ax(2),'YLim',[0 14])
    set(ax(2),'YTick',[0:2:14])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,4)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
 elseif(strcmp(parameters,'Hyperloop-Stilts'))
    Payload = F_lift(1,130) - PodWeight - MagnetWeight;
    
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 300])
    set(ax(1),'YTick',[0:50:300])
    set(ax(2),'YLim',[0 300])
    set(ax(2),'YTick',[0:50:300])
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
    set(ax(1),'YLim',[0 100])
    set(ax(1),'YTick',[0:10:100])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:10:100])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:10:135])
    TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    text(20,25,TeXString)
    grid on;
    
    if(strcmp(geometry,'Single'))
        set(ax(1),'YLim',[0 300])
        set(ax(1),'YTick',[0:50:300])
        set(ax(2),'YLim',[0 300])
        set(ax(2),'YTick',[0:50:300])
        set(ax(1),'XLim',[0 135])
        set(ax(1),'XTick',[0:10:135]) 
    end
    
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

%figure('Name','Skin Depth');
%plot(v,skin_depth)
%title('Skin Depth');
%xlabel('Velocity (m)');
%ylabel('Skin Depth (m)');

