%% Deterimines the maximum allowable rotational speed, as well as the
% rotational speed achieved for a given edge linear velocity over a range
% of wheel radii. Assumptions are that the wheel does not deflect away from
% it's central axis, and that the stress at the outer edge is zero. Under a
% directional loading this might not apply 100%, particularly given the
% high rotational speed and fatigue life.

% Depends on thickWallHoop function.

clear all
close all
clc

% Dynamics

v = 150; % max linear velocity : m/s
vm = v * 60; % max linear velocity : m/min
t = 0.0254; % wheel thickness : m
r = 0.0127:0.0127:0.3556; % wheel radius : m

cir = 2 * pi * r; % wheel circumference : m/rev
n_rpm = (vm./cir); % rotational speed : rpm

% Material properties

Sy = 4e7; % Yield strength : Pa
E = 2.5e6; % Young's modulus : Pa
nu = 0.47; % Poission's ratio : nondim
rho = 1.19e3; % density : kg/m3

% Hoop stress - thick walled assumption

n_max = zeros(1,length(r));
syms n
for i = 1:length(r);
    [A,B] = thickWallHoop(0, 0, E, nu, rho, r(1), r(i));
    equ = (3+nu)*rho*r(i)^2*n*(r(i))^2/8+A+B/r(i)^2 == Sy;
    n_sol = solve(equ, n);
    n_max(i) = abs(n_sol(1));
end

n_max_rpm = n_max*60/(2*pi);
FoS = n_max_rpm/n_rpm;

% Plotting

figure(1)
hold on
plot(r, n_rpm)
plot(r, n_max_rpm)
title('Top linear speed of 150 m/s');
xlabel('Wheel Radius (m)')
ylabel('Rotational Speed (rpm)')
legend('Speed Achieved', 'Abs Max (FoS=0)')
