%% Design for Hyperloop
close all;
clear all;

%% Select Paramters to Run Simulation With

%parameters = 'Hyperloop-Doubles';
parameters = 'Hyperloop-Stilts';
%parameters = 'Hyperloop-Brakes';
%parameters = 'Hyperloop-Lateral';
%parameters = 'Test-Rig';

coeff = 'Set2';

%% Global Constants
Jc = 0;
Jm = 0;
u0 = 4*pi*1e-7; % permeability of free space
    
%% Test Bench Parameters

if(strcmp(parameters,'Test-Rig'))
    vfinal = 50;
    tau_factor = 2;
    numArrays = 1.25;
    profile = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.0127*2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0127; % Heigh of permanent magnet (m)
    width = 0.0127; 
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.003175; % 1/8th inch thick 
    rho_track = 3.99*1e-8; % 6061 Resistivity
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.01; % Upper air gap (m)
    d2 = 0;%030; % Lower air gap (m)
end

%% Hyperloop Design Specs   

if(strcmp(parameters,'Hyperloop-Doubles'))
    vfinal = 135;
    tau_factor = 2;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.48; % Magnet remanence (T)
    
    % Magnet Geometry 
    %tau = 0.24; %1
    %h = 0.01905; %1
    %width = 0.06; %1
    %h = 0.0254; % 2
    %h = 0.03;
    %h = 0.03175;
    %width = 0.0254*2;
    
    %tau = 0.1016*2;% 2
    %h = 0.03175;
    %width = 0.03175*2;
    %numArrays = 4;
    %lambda = 2*tau;
    
    %width = 0.0762;
    %tau = width/1.25;
    %h = width*.17;
    %h = 0.55*tau;
    %numArrays = 16;
    %lambda = 2*tau;
    
%     width = 0.04825;
%     tau = width/1.25;
%     h = width*.5;
%     numArrays = 28;
%     lambda = 2*tau;

    width = .02285;
    tau = width/1.25;
    h = width*.5;
    numArrays = 28*2;
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0104648; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.017; % Upper air gap (m)
    d2 = 0.023; % Lower air gap (m)
    
    %d1 = 0.005;
    %d2 = 0.042 + l;
    
    % Pod Parameters
    PodWeight = 4500; % Pod weight (N)

elseif(strcmp(parameters,'Hyperloop-Stilts'))
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
    %d1 = 0.020; % Upper air gap (m)
    d1 = 0.023
    d2 = 0; % Lower air gap (m)
    
    % Electromagnet Parameters
    Jc = 13*1e5; % Current density coil
    Jm = h*Hc; % Current density magnet
    
    PodWeight = 4905; % Total pod force (with payload) (N)
  
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
    d1 = 0.012; % Upper air gap (m)
    d2 = 0.012; % Lower air gap (m)
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    vfinal = 135;
    tau_factor = 2;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.48; % Magnet remanence (T)
    
    width = .045; % Width (m)
    tau = width/1.5; % Pole pitch (m)
    h = tau*0.4; % Heigh of permanent magnet (m)
    P = 1; % Pole pair 
    lambda = 2*tau;
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.020; % Upper air gap (m)
    d2 = 0.020; % Lower air gap (m)
    
end

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
    weight = PodWeight;
    o(1,i) = (F_lift(1,i)-weight)/weight;
    i = i + 1;
end

fprintf('MagWidth: %d MagHeight: %d MagThickness: %d MagWeightLbs: %d MagMass: %d NumMagnets: %d MagCost: %d \r',...
        width,h,(tau/2),weightEstimate_lbs,weightEstimate_kg,numMagnets,costEstimate)
    
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
    set(ax(1),'YLim',[0 800])
    set(ax(1),'YTick',[0:100:800])
    set(ax(2),'YLim',[0 8])
    set(ax(2),'YTick',[0:1:8])
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
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 8])
    set(ax(1),'YTick',[0:1:8])
    set(ax(2),'YLim',[0 8])
    set(ax(2),'YTick',[0:1:8])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    TeXString = texlabel('Usable_Force = F_lift - MagnetWeight');
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
    set(ax(1),'YLim',[0 60])
    set(ax(1),'YTick',[0:10:60])
    set(ax(2),'YLim',[0 30])
    set(ax(2),'YTick',[0:5:30])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,4)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
 elseif(strcmp(parameters,'Hyperloop-Stilts'))
    Payload = 0;% F_lift(1,130) - PodWeight - MagnetWeight;
    
    subplot(2,2,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 600])
    set(ax(1),'YTick',[0:100:600])
    set(ax(2),'YLim',[0 3])
    set(ax(2),'YTick',[0:0.5:3])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    if(strcmp(plot_setting,'Four-Stilts'))
        subplot(2,2,1);
        [ax,p1,p2] = plotyy(v,F_drag/1000,...
                        v,F_lift/1000,'plot','plot');
        title('Lift and Drag Forces');
        xlabel(ax(1),'Velocity (m/s)')  % label x-axis
        ylabel(ax(1),'Drag Force (kN)') % label left y-axis
        ylabel(ax(2),'Lift Force (kN)') % label right y-axis
        set(ax(1),'YLim',[0 8])
        set(ax(1),'YTick',[0:1:8])
        set(ax(2),'YLim',[0 8])
        set(ax(2),'YTick',[0:1:8])
        set(ax(1),'XLim',[0 135])
        set(ax(1),'XTick',[0:15:135])
        set(ax(2),'XLim',[0 135])
        set(ax(2),'XTick',[0:15:135])
        grid on;
    end
    
    subplot(2,2,2);
    [ax,p1,p2]= plotyy(v,n,v,m);
    title('Lift/Drag and Lift/Weight Ratios');
    xlabel('Velocity (m/s)');
    ylabel(ax(1),'Lift/Drag'); % label left y-axis
    ylabel(ax(2),'Lift/Weight'); % label left y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 12])
    set(ax(1),'YTick',[0:2:12])
    set(ax(2),'YLim',[0 60])
    set(ax(2),'YTick',[0:10:60])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,3)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
    gap = (F_lift-weight)/1000;
    subplot(2,2,4)
    [ax,p1,p2]= plotyy(v,gap,v,gap);
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'YLim',[0 8])
    set(ax(1),'YTick',[0:1:8])
    set(ax(2),'YLim',[0 8])
    set(ax(2),'YTick',[0:1:8])
    
 elseif(strcmp(parameters,'Test-Rig'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 10])
    set(ax(1),'YTick',[0:1:10])
    set(ax(2),'YLim',[0 10])
    set(ax(2),'YTick',[0:1:10])
    set(ax(1),'XLim',[0 50])
    set(ax(1),'XTick',[0:5:50])
    set(ax(1),'XLim',[0 50])
    set(ax(1),'XTick',[0:5:50])
    
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    grid on;
    
    if(strcmp(geometry,'Single'))
        set(ax(1),'YLim',[0 50])
        set(ax(1),'YTick',[0:10:50])
        set(ax(2),'YLim',[0 50])
        set(ax(2),'YTick',[0:10:50])
        set(ax(1),'XLim',[0 50])
        set(ax(1),'XTick',[0:5:50]) 
    end
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,(F_drag),...
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

