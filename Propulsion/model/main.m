clear, clc
%% Gas Constants
k = 1.4;
R = 297;
Isp = 73;
g = 9.81;
Pamb = 140; % Pa
T0 = 300; % K

%% Design Constraints - Scuba Tank
P0 = 3.1026e+7;
Volume_tank = 0.018; % m3

%% Design Constraints - COPV Orbital Atk
P0 = 3.1026e+7; % Pa
Volume_tank = 0.0672689; % m3

%% Sweep Area of Throat with several mach numbers at exit
dt = 0.001:0.00005:0.009525;
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
% plot([dt(1)/2 dt(end)/2], [Fmax Fmax])
% Plot chamber radius
dc = 0.01905;
% plot([dc/2 dc/2], [Fth(1) Fth(end)])
xlabel('Radius of Throat (m)')
ylabel('Force of Thrust (N)')
title('Effect of Nozzle Throat Radius on Propulsion Force')

%% Choose characteristics flow
Me_chosen = 3.5;
[F_chosen, mdot] = CGT(P0, T0, Me_chosen, At);

%% Calculate the propellant mass
rho0 = P0/(R*T0);
mass_prop = rho0*Volume_tank; % kg

%% Find nozzle geometry for 9800 N of force
Me_chosen = 3.5;
F_chosen = 9700;
[F, mdot, Pe, Ae] = CGT(P0, T0, Me_chosen, At);
[val, idx] = min(abs(F-F_chosen));
[F, mdot, Pe, Ae] = CGT(P0, T0, Me_chosen, At(idx))
Athroat = At(idx)
t = mass_prop/mdot
[vmax, xprop] = v_prop(F/500, t, Vpush)
rt = sqrt(Athroat/pi)
re = sqrt(Ae/pi)
alpha = 15*pi/180;
L = re/tan(alpha) - rt/tan(alpha)

%% Loop over Mach Number to find nozzle geometry
figure, hold on
Ma = 1:0.1:5;
for i = 1:numel(Ma)
    % Find Rt for a given force
    [F, mdot, Pe, Ae] = CGT(P0, T0, Ma(i), Athroat);
    % Using the mass of propellant and mass flow calculate the time of depletion
    t = mass_prop/mdot;
    a_prop = F/500;
    % Calculate distance of propulsion and final velocity
    [vmax, xprop] = v_prop(a_prop, t, Vpush)
    plot(Ma(i), vmax);
end


%% Our configuration
At = (4.750/1000)^2*pi;
[F, mdot, Pe, Ae] = CGT(P0, T0, 3.5, At);
