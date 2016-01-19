clear, clc
%% Gas Constants
k = 1.4;
R = 297;
Isp = 73;
g = 9.81;
Pamb = 140; % Pa
T0 = 300; % K

%% Design Constraints - Scuba Tank
P0 = 2.4132e+7;
Volume_tank = 0.018; % m3

%% Design Constraints - COPV Orbital Atk
P0 = 2.4132e+7; % Pa
Volume_tank = 0.0672689; % m3

%% Calculate the propellant mass
rho0 = P0/(R*T0);
mass_prop = rho0*Volume_tank; % kg

%% Sweep Area of Throat with several mach numbers at exit
dt = 0.001:0.0001:0.01905;
At = (dt / 2).^2*pi; % m2
Me = [1.5, 2, 2.5, 3, 3.5, 4];
Fmax = 500*2*9.8;
figure, hold on
leg = {};
for j = 1:numel(Me)
    Fth = [];
    mdott = [];
    Pe = [];
    Ae = [];
    for i=1:numel(At)
        [Fth(end+1), mdott(end+1), Pe(end+1), Ae(end+1)]  = CGT(P0, T0, Me(j), At(i));
    end
    plot(dt/2, Fth)
    leg{end+1} = ['M_{3}=' num2str(Me(j))];
    % Add in legend or label for Ma
end

% Plot area ratio vs thrust
legend(leg, 'location', 'best')

% Plot max thrust force
plot([dt(1)/2 dt(end)/2], [Fmax Fmax])
% Plot chamber radius
dc = 0.01905;
plot([dc/2 dc/2], [Fth(1) Fth(end)])
xlabel('Radius of Throat (m)')
ylabel('Force of Thrust (N)')
title('Effect of Nozzle Throat Radius on Propulsion Force')

%% Choose characteristics
Me_chosen = 3.5;
[F_chosen, mdot] = CGT(P0, T0, Me_chosen, At);
Vpush = 97.7677;

%% Loop over chosen forces
figure, hold on
for i = 1:numel(F_chosen)
    % Find Rt for a given force
    F_chosen(i)
    a_prop = F_chosen(i)/500;
    % Using the mass of propellant and mass flow calculate the time of depletion
    t = mass_prop/mdot(i);

    % Calculate distance of propulsion and final velocity
    [vmax, xprop] = v_prop(a_prop, t, Vpush);
    plot(F_chosen(i), vmax, '.')
end
