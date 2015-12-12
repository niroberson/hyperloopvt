clear, clc

% Acceleration provided by pusher

M = [250, 500, 750, 1000, 1500, 2000, 2500, 3000, 4000, 5000]; %kg
Ag = [2.4, 2, 1.7, 1.5, 1.2, 1, 0.9, 0.8, 0.6, 0.5]; %g
A = Ag .* 9.81; %m/s^2
D = 243.84; %m (800')
T = sqrt(2 * D ./ A); %s
V = A .* T; %m/s
F = (M .* A)/1000; %kN

m = 438.6; %kg
a = interp1(M, A, m) %m/s^2
v = interp1(M, V, m) %m/s
f = interp1(M, F, m) %kN

figure(1), hold on
plot(M, F, 'm')
[AX, H1, H2] = plotyy(M, A, M, V)
xlabel('Mass (kg)')
ylabel(AX(1), 'Max Velocity (m/s)')
ylabel(AX(2), 'Acceleration (m/s^2), Force (N)')
legend('Force', 'Acceleration', 'Velocity')
plot([m, m], [0, 100], 'gr'); 
title('Effect of Pod Mass on Pusher Characteristics')


% % Propulsive force
% d = 682.752; %m
% m = 750; % kg
% Fp = m/(2*d)*u;
% F_net = Fp-Fd;
% 
% % Plot drag, propulsive, and net force
% figure, hold on
% plot(Fp, u, 'gr')
% plot(Fd, u, 'r')
% plot(F_net, u, 'm')
% plot(Fp - max(Fd), u, 'bl')
% xlabel('Force (N)')
% ylabel('Velocity (m/s)')
% legend('Thrust Force', 'Drag Force', 'Net Force', 'Constant Drag (max)', 'Location', 'best')
% title('Effect of Velocity on Horizontal Forces')