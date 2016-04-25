% Square Pulse Function Generator
clear all;
close all;

%% Digilent Setup

% Discover Digilent devices connected to your system using daq.getDevices 
% and create a session using the listed Digilent device.
s = daq.createSession('digilent')

% Add an analog output channel with device ID AD1 and channel ID 1. 
% Set the measurement type to Voltage.
ch = addAnalogOutputChannel(s,'AD1', 1, 'Voltage')

% Add an analog input channel with device ID AD1 and channel ID 2. 
% Set the measurement type to Voltage.
ch_in = addAnalogInputChannel(s,'AD1', 2, 'Voltage')

% Add a digital output channel with device ID AD1 and channel ID 0
% addDigitalChannel(s,'AD1', '0', 'OutputOnly');

%% Generate Square Pulse

% Sampling rate from square_pulse.m
rate = 10e3;
s.Rate = rate;

pulse = square_pulse(rate);

% Plot waveform
output = pulse;
plot(output)

%% Generate queued data and acquire timestamped data in the foreground. 
% For any given session, generation and acquisition run at the same rate.
t = cputime;
queueOutputData(s,output);
[data, timestamps, triggerTime] = s.startForeground;
elapsed_time = cputime - t

% Display the results
figure;
plot(timestamps, data);
xlabel('Time (seconds)'); ylabel('Voltage (Volts)');
title(['Clocked Data Triggered on: ' datestr(triggerTime)])
