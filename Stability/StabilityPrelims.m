%% Stability Calculations
clear all;
close all;

parameters = 'Hyperloop-Doubles';

profile = 'Brakes-';
coeff = 'Set2';

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

end

%% Set up the simulation

v = 50; % Velocity (m/s)
c = 0.01 + 0.017 + 0.030; % Distance from bottom of top halbach to top of bottom halbach
gapInitial = 0.010;
gapFinal = 0.040;
gapRes = 0.0001;
size = (gapFinal-gapInitial)/gapRes;

%F_lift = zeros(1,size);
%F_drag = zeros(1,size);
i = 1;
Jc = 0;
Jm = 0;

for d1 = gapInitial:gapRes:gapFinal
    d2 = c - l - d1; % d2 as a function of d1 and conductor thickness
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,geometry,...
                              tau_factor,M,tau,Br,h,l,rho_track,d1,d2,...
                              coeff,profile,Jc,Jm);
    F_lift(1,i) = Fy*width*numArrays;
    F_drag(1,i) = (-1*Fz*width*numArrays);
    
    i = i + 1;
end                        

gap = gapInitial:gapRes:gapFinal;
gap = gap*1000;

plot(gap,F_lift/1000);
title('Total Stiffness vs Gap @v = 15');
xlabel('Gap (mm)') % label x-axis
ylabel('kN/mm');
grid on;
                  