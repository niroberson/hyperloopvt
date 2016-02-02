% Magfield
clear all;
close all;

M = 4;
Br = 1.48;

width = .045; % Width (m)
tau = width/1.5; % Pole pitch (m)
h = tau*0.4; % Heigh of permanent magnet (m)

d1 = 0.020;
d2 = 0.020;

l = 0.0104648;

p = pi/tau; 
v = 50;
lambda = 2*tau; % Array wavelength(m)
omega = 2*pi*v/lambda;
t = 0;

z = -tau:.001:tau;
y = 0;

%% Magnetic field components Bsy + Bsz

B0 = Br*(1-exp(-p*h))*sin(pi/M)/(pi/M);

Bsy = B0.*(exp(-p.*(y+d1)) - exp(-p.*(-y+d2+l))).*exp(1i*(p.*z + omega.*t));
Bsz = B0.*(exp(-p.*(y+d1)) + exp(-p.*(-y+d2+l))).*exp(1i*(p.*z-pi/2+omega.*t));

[ax,p1,p2] = plotyy(z,Bsy,z,Bsz)
    title('Magnetic Field Components');
    xlabel(ax(1),'z (m)') % label x-axis
    ylabel(ax(1),'Bsy (T)') % label left y-axis
    ylabel(ax(2),'Bsz (T)') % label right y-axis
    set(ax(1),'YLim',[-.2 0.2])
    set(ax(1),'YTick',[-.2:0.05:0.2])
    set(ax(2),'YLim',[0.2 0.2])
    set(ax(2),'YTick',[-.2:0.05:0.2])
%    set(ax(1),'XLim',[0 135])
 %   set(ax(1),'XTick',[0:10:135])
%Bavg = Bsy+Bsz;
%plot(z,Bavg)