clear all;
clc;
close all;

%% Flow parameters
Pc = 6.895e+6; % Pascals Chamber Pressure
Pi = 3.1026e+7; % Pascals Tank Pressure
Pr = 1500*6894.76;
V = 0.06737; % m3 Tank Volume
Ti = 300; % K Tank gas temperature

%% Gas Parameters
k = 1.4;
R = 297;

%%
t = 0:30;

isentropic_time_regulator(Pi, Ti, V, Pr, k, R, t)

% 3.1026e+7, 300, 0.06737, 1500*6894.76, 1.4, 297, 70

