%% Optimization Sweep
clear all;
close all;

parameters = 'Hyperloop-Stilts';

profile = 'Stability-';
coeff = 'Set2';

if(strcmp(parameters,'Hyperloop-Stilts'))
    vfinal = 135;
    tau_factor = 2;
    geometry = 'Single';
    
    % Magnet Parameters
    M = 4; % Number of Magnets in Wavelength
    Hc = 11.2*1e3; % Coercive Force of Magnet
    Br = 1.48; % Magnet remanence (T)

    % Track Parameters
    l = 0.0127; % Thickness of track (m)
    rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
    sigma = 1/rho_track;

    % Air gap Parameters
    d1 = 0.020; % Upper air gap (m)
    d2 = 0; % Lower air gap (m)
    
    Jc = 0;
    Jm = 0;
    PodWeight = 2000; % Pod weight (N)
end

%% Setup simulation

v = 110;
res = 0.001;
thickTauFinal = 0.8;
widthTauFinal = 3;

size = thickTauFinal/res;
size = int32(size);

i = 1;
width = 0.100;
tau = 1.5*.100;
numArrays = 1;

for o = 0:res:thickTauFinal
    h = tau*o;
    
        volumeOneMagnet = h*width*(tau/2);
        volumeOneArray = volumeOneMagnet*M;
        volumeTotal = volumeOneArray*numArrays; % (m^2)

        densityNdFeB = 7500; % Neodymium density (kg/m^2)

        weightEstimate_kg = densityNdFeB*volumeTotal; % (kg)
        weight = weightEstimate_kg*9.81; % (N)
        
        [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,geometry,...
                                    M,tau,Br,h,l,rho_track,d1,d2,coeff,...
                                    profile,Jc,Jm);
                                
        F_lift = Fy*width*numArrays;
        F_drag = (-1*Fz*width*numArrays);
        %n(1,i) = lift_drag_ratio;
        m(1,i) = F_lift/weight;
    
    i = i + 1;
end

i = 1;
u0 = 4*pi*1e-7; % permeability of free space

for tau = 0:0.01:(0.5)
    lambda = 2*tau;
    skin_depth(1,i) = sqrt(1/(pi*(v./lambda)*u0*sigma));
    i = i + 1;
end 

%% Levitation Gap Optimization

width = 0.1;
tau = width/1.5;
h = tau*0.4;
i = 1;

for d1 = 0:0.001:0.050
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,geometry,...
                              M,tau,Br,h,l,rho_track,d1,d2,coeff,...
                              profile,Jc,Jm);
                                
    F_lift = Fy*width*numArrays;
    F_drag = (-1*Fz*width*numArrays);
    n = F_lift/F_drag;
    %(1,i)
    i = i + 1;
end

%% Track Thickness Plot

width = 0.1;
tau = width/1.5;
h = tau*0.4;
d1 = 0.020;
i = 1;

volumeOneMagnet = h*width*(tau/2);
volumeOneArray = volumeOneMagnet*M;
volumeTotal = volumeOneArray*numArrays; % (m^2)

densityNdFeB = 7500; % Neodymium density (kg/m^2)

weightEstimate_kg = densityNdFeB*volumeTotal; % (kg)
weight = weightEstimate_kg*9.81; % (N)

for l = 0:0.001:0.050
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,geometry,...
                              M,tau,Br,h,l,rho_track,d1,d2,coeff,...
                              profile,Jc,Jm);
                                
    F_lift = Fy*width*numArrays;
    F_drag = (-1*Fz*width*numArrays);
    n_new(1,i) = F_lift/F_drag;
    m_track(1,i) = F_lift/weight;
    %(1,i)
    i = i + 1;
end

o = 0:res:thickTauFinal;
u = 0:res:widthTauFinal;

figure
%surfc(u,o,m)
%surfc(u,o,weight_plot)

plot(o,m)
title('Optimization of Magnet Thickness to Pole Pitch');
xlabel('h/\tau')
ylabel('Levitation-to-Weight');

% v = 110;
% tau = 0:0.01:(0.5);
% plot(tau,skin_depth*1e3)
% ylabel('Skin Depth (mm)');
% xlabel('Halbach Array Wavelength (m)');
% title('Skin Depth vs. Halbach Array Wavelength');

% [ax,p1,p2] = plotyy(tau,n,tau,m_new)
% title('Levitation-to-Drag and Levitation-to-Weight');
% xlabel(ax(1),'Pole Pitch') % label x-axis
% ylabel(ax(1),'Levitation-to-Drag') % label left y-axis
% ylabel(ax(2),'Levitation-to-Weight') % label right y-axis
% set(ax(1),'YLim',[0 50])
% set(ax(1),'YTick',[0:10:50])
% set(ax(2),'YLim',[0 50])
% set(ax(2),'YTick',[0:10:50])
% set(ax(1),'XLim',[0 0.5])
% set(ax(1),'XTick',[0:0.1:0.5])
% grid on;

% d1 = 0:0.001:0.050;
% plot(d1,n);

%l = 0:0.001:0.050;
%plot(l,n_new);
%plot(l,m_track);