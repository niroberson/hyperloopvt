clear all;
close all;
clc;

%%Flow parameters
Pi = 3400*6894.76;
Pr = 1000*6894.76;
V = 0.06737; % m3 Tank Volume
Ti = 300; % K Tank gas temperature

%%Gas Parameters
k = 1.4;
R = 297;

t = 0:80;

Pamb = 140; % Pa

gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));

At = pi*(4/1000)^2;
Me = 5;

%% Above regulator pressure
P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
mdot1 = @(t) gamma*At*Pr./sqrt(k*R*T0(t)); % Might be At

%% Below regulator pressure
mdot2 = @(t) gamma*At*P0(t)./sqrt(k*R*T0(t));

%% Find the transient flow characteristics in the system
figure, hold on
plot(t, mdot1(t))
plot(t, mdot2(t))
legend({'1','2'})

%%Pressure and temperature at exit
% hold on
% plot(t, P0(t))
% xlabel('Time (s)')
% ylabel('Pressure (Pa)')
%                                                                                                                
% title('Pressure and Temperature at Nozzle Exit')
% set(gca,'YMinorTick','on');


