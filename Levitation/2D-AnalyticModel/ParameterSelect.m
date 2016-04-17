%% Workspace Setup

function [vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
          = ParameterSelect(parameters)

PodWeight = 0;

if(strcmp(parameters,'Test-Rig'))
    vfinal = 50;
    P = 1.25;
    profile = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.0127*2; % Pole pitch (m)
    Br = 1.48; % Magnet remanence (T)
    h = 0.0127; % Heigh of permanent magnet (m)
    width = 0.0127; 
    
    % Track Parameters
    l = 0.003175; % 1/8th inch thick 
    rho_track = 3.99*1e-8; % 6061 Resistivity
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.02; % Upper air gap (m)
    d2 = 0;%030; % Lower air gap (m)
end

if(strcmp(parameters,'Test-Rig2'))
    vfinal = 50;
    profile = 'Single';
    %profile = 'Double';
    %profile = 'Brakes';
    extend = 'yes-';
   
    length = 0.0127;
    width = 0.0381;
    h = 0.0127;
    tau = 2*length; % Pole Pitch (m)
    
    M = 4; % Number of Magnets in Wavelength
    Br = 1.32; % Magnet remanence (T)
    P = 3;
    
    if strcmp(extend,'yes')
        P = 1.5;
        tau = 4*length;
    end
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    if strcmp(profile, 'Single')
        d1 = 0.010; % Upper air gap (m)
        d2 = 0;     % Lower air gap (m)
    elseif(strcmp(profile,'Double'))
        d1 = 0.010;
        d2 = 0.015;
    elseif(strcmp(profile,'Brakes'))
        d1 = 0.010;
        d2 = 0.010;
    end
    
elseif strcmp(parameters,'Lateral-Opt')
    profile = 'Double';
    vfinal = 140;
    
    % Magnet Paramters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.32; % Magnet remanence (T)
    P = 1;
    
    width = 0.035;
    d1 = 0.015;
    d2 = 0.025;
    
    tau = width/1.5;
    h = 0.1;

    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

elseif(strcmp(parameters,'Hyperloop-Stilts'))
    vfinal = 135;
    profile = 'Single';
    plot_setting = 'Four-Stilts-';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.32; % Magnet remanence (T)
   
    %width = 0.100; % Width of magnet (m)
    width = 0.0762;
    length = (width/1.5)/2; 
    %tau = 2*length - (0.0031496/2);% - 0.0031496;
    tau = width/1.5; % Pole pitch (m)
    h = tau*.4; % Height of permanent magnet (m)
    P = 3;
    %P = 1.25; % Number of arrays to simulate
    if(strcmp(plot_setting,'Four-Stilts'))
        %P = (10*tau - 0.0031496)/2;
        P = 4*P;
    end
    
    % Track Parameters
    l = 0.0127; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    %d1 = 0.020; % Upper air gap (m)
    d1 = 0.020; 
    d2 = 0; % Lower air gap (m)
   
    PodWeight = 4905; % Total pod force (with payload) (N)
  
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    vfinal = 135;
    profile = 'Brakes';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.32; % Magnet remanence (T)
    
    P = 23;
    width = 0.0254;
    %length = 0.0127;
    tau = width*1.25;
    h = width*1.25;
  
    % Track Parameters
    %l = 0.0079502; % Thickness of track (m)
    l = 0.0105; % Proposed new web thickness
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.0070; % Upper air gap (m)
    d2 = 0.0070; % Lower air gap (m)
    %d2 = 0.01;
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    vfinal = 135;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.32; % Magnet remanence (T)
    P = 14; % Pole pair 
    
    %width = 0.01905;
    %width = 0.0381;
    width = 0.0254;
    %length = 0.0127;
    tau = width/1.5;
    %tau = width;
    h = tau*.7; 
    
    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    %l = 0.0105; % Proposed new web thickness
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    perturb = 0.013; % Perturbation in (m)
    %d1 = 0.020 - perturb; % Upper air gap (m)
    %d2 = 0.020 + perturb; % Lower air gap (m)
    d1 = 0.007;
    d2 = 0.033;
    
    elseif(strcmp(parameters,'Hyperloop-Hybrid'))
    vfinal = 135;
    profile = 'Brakes';
    %profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.48; % Magnet remanence (T)
    
    width = .0435; % Width (m)
    tau = width/1.25; % Pole pitch (m)
    h = 0.0635; % Heigh of permanent magnet (m)
    P = 24; 
    
    %length = 0.0127;
    %width = 0.0381;
    %h = 0.0127;
    %tau = 2 * length;
    %tau = 0.05;

    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    if(strcmp(profile,'Double'))
        perturb = 0.010;
        equilib = 0.020;
        d1 = equilib - perturb;  % Upper air gap (m)
        d2 = d1 + (perturb*2); % Lower air gap (m)
    elseif(strcmp(profile,'Brakes'))
        d1 = 0.015;
        d2 = 0.015;
    end
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
end

%% Paper Replica Parameters

% 3-D Null Flux paper 
if(strcmp(parameters,'3D-Final'))
    vfinal = 41;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.3; % Pole pitch (m)
    Br = 1.1; % Magnet remanence (T)
    h = 0.105; % Heigh of permanent magnet (m)
    width = 0.450;
    P = 2;
    
    % Track Parameters
    l = 0.006; % Thickness of track (m)
    sigma_track = 2.54*1e7;
    rho_track = 1/sigma_track; % Resistivity of track (Ohm*m)

    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.050; % Lower air gap (m)
    
elseif(strcmp(parameters,'3D-Initial'))
    vfinal = 41;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m) 
    Br = 1.28; % Magnet remanence (T)
    h = 0.1; % Heigh of permanent magnet (m)
    width = 0.05; % Width of magnet (m)
    P = 2;

    % Track Parameters
    l = 0.006; % Thickness of track (m)
    sigma_track = 2.54*1e7;
    rho_track = 1/sigma_track; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.026; % Upper air gap (m)
    d2 = 0.032; % Lower air gap (m)
    
elseif(strcmp(parameters,'3D-Experimental'))
    vfinal = 41;
    profile = 'Double';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    tau = 0.1; % Pole pitch (m)
    Br = 1.1; % Magnet remanence (T)
    h = 0.05; % Heigh of permanent magnet (m)
    width = 0.100; % Width of permanent magnet (m)
    P = 2;
    
    % Track Parameters
    l = 0.003; % Thickness of track (m)
    sigma_track = 2.57*1e7;
    rho_track = 1/sigma_track; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.021; % Upper air gap (m)
    d2 = 0.042; % Lower air gap (m)

elseif(strcmp(parameters,'Fig4'))
    vfinal = 55;
    P = 1;
    profile = 'Double';
    
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
    profile = 'Double';
    P = 1;
   
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.277; % Magnet remanence (T)
    
    tau = 0.8; % Pole pitch (m)
    h = 0.3; % Heigh of permanent magnet (m)
    width = 0.1; % Width of array (m)
    
    % Track Parameters
    l = 0.01; % Thickness of track (m)
    rho_track = 3.92*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.015; % Upper air gap (m)
    d2 = 0.060; % Lower air gap (m)
    
elseif(strcmp(parameters,'Second-2D'))
    vfinal = 69;
    profile = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Br = 1.34; % Magnet remanence (T)
    tau = 0.07; % Pole pitch (m)
    h = 0.035; % Heigh of permanent magnet (m)
    width = 0.200;
    P = 2;
    
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
    profile = 'Single';
    width = 0.1;
    P = 2.25;
    
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
    profile = 'Single';
    width = 0.48;
    P = 2.125;
    
    % Magnet Parameters
    M = 8; % Number of Magnets in Wavelength
    tau = 0.48; % Pole pitch (m)
    Br = 0.85; % Magnet remanence (T)
    h = 0.2; % Heigh of permanent magnet (m)
    rho_track = 1.6*1e-8; % Resistivity of track (Ohm*m)
    
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
    profile = 'Single';
    
    % Magnet Parameters
    M = 8; % Number of Magnets in Wavelength
    Br = 1.38; % Magnet remanence (T)
    
    tau = 0.030; % Pole pitch (m)
    width = 0.015;
    P = 2;
    h = 0.015; % Heigh of permanent magnet (m)
    
    % Track Parameters
    l = 0.005; % Thickness of track (m)
    rho_track = 1.7*1e-8; % Resistivity of track (Ohm*m)
   
    % Air gap Parameters
    d1 = 0.005; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
end
