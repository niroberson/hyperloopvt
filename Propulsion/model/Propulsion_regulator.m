clear all;
close all;
clc;

%%Flow parameters
Pc = 1000*6894.76;
Pi = 3400*6894.76;
Pr = 1500*6894.76;
V = 0.06737; % m3 Tank Volume
Ti = 300; % K Tank gas temperature

%%Gas Parameters
k = 1.4;
R = 297;

t = 0:80;

Pamb = 140; % Pa

gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));

At = pi*(4.5/1000)^2;
Ar = pi*(0.00635)^2;
Me = 5;

t = 0;

P = Pi;

while P>Pr
    
    P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
    P = P0(t);
    T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
    mdot = @(t) gamma*Ar*Pr./sqrt(k*R*T0(t)); % Might be At

    plot(t, Pr, 'o')
    hold on;

    t= t+1;
    
end


P0 = @(t)Pc./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pc).^((k-1)/k);
mdot = @(t) gamma*At*P0(t)./sqrt(k*R*T0(t));


%%Pressure and temperature at exit
hold on
plot(t, P0(t))
xlabel('Time (s)')
ylabel('Pressure (Pa)')
                                                                                                               
title('Pressure and Temperature at Nozzle Exit')
set(gca,'YMinorTick','on');


