% Magfield Single Sided

M = 4;
Br = 1.48;

width = 0.100; % Width of magnet (m)
tau = width/1.5; % Pole pitch (m)
h = tau*.4 % Height of permanent magnet (m)

%numArrays = 16;
lambda = 2*tau;

d1 = 0.02;
l = 0.0127;

p = pi/tau; 
v = 100;
lambda = 2*tau; % Array wavelength(m)
omega = 2*pi*v/lambda;
t = 0;

z = -tau:.001:tau;
y = 0;

%% Magnetic field components Bsy + Bsz
width = 1;
B0 = Br*(1-exp(-p*h))*sin(pi/M)/(pi/M);

Bsy = B0.*(exp(-p.*(y+d1))).*exp(1i*(p.*z + omega.*t));
Bsz = B0.*(exp(-p.*(y+d1))).*exp(1i*(p.*z-pi/2+omega.*t));

[ax,p1,p2] = plotyy(z,Bsy,z,Bsz)
    title('Magnetic Field Components');
    xlabel(ax(1),'z (m)') % label x-axis
    ylabel(ax(1),'Bsy (T)') % label left y-axis
    ylabel(ax(2),'Bsz (T)') % label right y-axis
    set(ax(1),'XLim',[-0.06 0.06])
    set(ax(1),'XTick',[-0.06:0.02:0.06])
    set(ax(2),'XLim',[-0.06 0.06])
    set(ax(2),'XTick',[-0.06:0.02:0.06])
    
%Bavg = Bsy+Bsz;
%plot(z,Bavg)