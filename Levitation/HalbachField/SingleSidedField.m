% Magfield Single Sided
close all;

length = 0.0127;
h = 0.0127;
%tau = 2*length; % Pole Pitch (m)
tau = 4*length;
    
M = 4; % Number of Magnets in Wavelength
Br = 1.32; % Magnet remanence (T)
P = 3;
    
% Track Parameters

% Air gap Parameters
d1 = 0.003175; % Upper air gap (m)
d2 = 0;%030; % Lower air gap (m)

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
Bmag = sqrt(real(Bsy).^2 + real(Bsz).^2);

hold on;
[ax,p1,p2] = plotyy(z*1000,Bsy,z*1000,Bsz)
    title('Magnetic Field Components');
    xlabel(ax(1),'z (mm)') % label x-axis
    ylabel(ax(1),'Bsy (T)') % label left y-axis
    ylabel(ax(2),'Bsz (T)') % label right y-axis
    set(ax(1),'XLim',[-(tau*1000) (tau*1000)])
    set(ax(1),'XTick',[-(tau*1000):tau*1000/5:(tau*1000)])
    set(ax(2),'XLim',[-(tau*1000) (tau*1000)])
    set(ax(2),'XTick',[-(tau*1000):tau*1000/5:(tau*1000)])
    
%figure;
%plot(z,Bmag);
B = abs(Bsy);
plot(z*1000,Bmag,'color','c');
legend('Magnitude');
dim = [0.2 0.3 .5 .6];
str = sprintf('Air Gap: %0.1f (mm)',d1*1000);
annotation('textbox',dim,'String',str,'FitBoxToText','on');
%plot(z,Bmag)