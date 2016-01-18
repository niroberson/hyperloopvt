%% Actual configuration
clear, clc
P0 = 2.4132e+7; % Pa
T0 = 300; % K
At = (0.006 / 2)^2*pi; % m2
Me = 2;
Fth = CGT(P0, T0, Me, At);

%% Sweep Area of Throat
clear, clc
P0 = 2.4132e+7; % Pa
dt = 0.001:0.01:0.1;
At = (dt / 2).^2*pi; % m2
Me = 2;
T0 = 300;
F = [];
for i=1:numel(At)
    F(end+1) = CGT(P0, T0, Me, At(i));
end

figure, plot(At, F, 'r.')

%% Testing Tank Temperature
% CGT does not yet have isothermic or pressure drop off in tank model
clear, clc
P0 = 2.4132e+7; % Pa
At = (0.006 / 2)^2*pi; % m2
Me = 2;
T0 = 250:10:300;
F = [];
for i=1:numel(T0)
    F(end+1) = CGT(P0, T0(i), Me, At);
end

figure, plot(T0, F, 'r.')
