%% Create session with Digilent Analog Discovery, add analog output
s = daq.createSession('digilent')
ch_out = addAnalogOutputChannel(s,'AD1',1,'Voltage')
ch_in = addAnalogInputChannel(s,'AD1',1,'Voltage')
%% Set session and channel properties
rate = 300e3;
s.Rate = rate;
%% Define Output Waveform
f = 120;
duration = 5;
t = (1:(duration*rate))/rate;
%output = sin(2*pi*f*t)';
%t = linspace(-pi,2*pi,121);
%t = -1:0.001:70;
% 1 second
sampleRate = 300e3;
t_on = sampleRate/600;

outputN = zeros(1,(duration*sampleRate));
%t = 1:(duration*sampleRate);

% 1 second
for i = (sampleRate+1):(sampleRate+t_on+1)
    outputN(i) = 4.5;
end

% Second Second
for i = (2*sampleRate+2):(2*sampleRate + t_on+1)
    outputN(i) = 4.5;
end

% Third Second
for i = (3*sampleRate+2):(3*sampleRate + t_on+1)
    outputN(i) = 4.5;
end
next = 3*sampleRate+(2*(t_on)+2)
for i = next:next+t_on+1
    outputN(i) = 4.5;
end

next1 = 3*sampleRate+(4*(t_on)+2)
for i = next1:next1+t_on+1
    outputN(i) = 4.5;
end

next2 = 3*sampleRate+(6*(t_on)+2)
for i = next2:next2+t_on+1
    outputN(i) = 4.5;
end
%output = 2*square(t,5)+2.1;
%% Generate/Acquire continuous data
queueOutputData(s,outputN');
[data, timestamps, triggerTime] = s.startForeground;
%% Display the results
plot(timestamps, data);