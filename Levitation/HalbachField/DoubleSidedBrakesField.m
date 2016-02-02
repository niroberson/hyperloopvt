%% Double Sided Halbach Eddy Brakes Magnetic Field 
clear all;
close all;

Br = 1.48;
M = 4;

width = 0.100;
tau = 0.033*2;
h = 0.027;

l = 0.01;
d1 = 0.02;
d2 = 0.02;

v = 100;
p = pi/tau; 
lambda = 2*tau;         % Array wavelength(m)
omega = 2*pi*v/lambda;
t = 0;

z = -tau:.001:tau;
y = 0;

B0 = Br*(1-exp(-p*h))*sin(pi/M)/(pi/M);

Bsy = B0.*(exp(-p.*(y+d1)) + exp(-p.*(-y+d2+l))).*exp(1i*(p.*z + omega.*t));
Bsz = B0.*(exp(-p.*(y+d1)) - exp(-p.*(-y+d2+l))).*exp(1i*(p.*z-pi/2+omega.*t));

[ax,p1,p2] = plotyy(z,Bsy,z,Bsz)
title('Magnetic Field Components');
xlabel(ax(1),'z (m)') % label x-axis
ylabel(ax(1),'Bsy (T)') % label left y-axis
ylabel(ax(2),'Bsz (T)') % label right y-axis
set(ax(1),'XLim',[-0.06 0.06])
set(ax(1),'XTick',[-0.06:0.02:0.06])
set(ax(2),'XLim',[-0.06 0.06])
set(ax(2),'XTick',[-0.06:0.02:0.06])
set(ax(1),'YLim',[-0.8 0.8])
set(ax(1),'YTick',[-0.8:0.2:0.8])
set(ax(2),'YLim',[-0.8 0.8])
set(ax(2),'YTick',[-0.8:0.2:0.8])

