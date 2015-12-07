%% Create session with Digilent Analog Discovery, add analog output
s = daq.createSession('digilent')
ch_out = addAnalogOutputChannel(s,'AD1',1,'Voltage')
ch_in = addAnalogInputChannel(s,'AD1',1,'Voltage')
%% Set session and channel properties
rate = 300e3;
s.Rate = rate;
%% Define Output Waveform
duration = 5;
t = (1:(duration*rate))/rate;
t_on = rate/600; % Ratio

outputN = zeros(1,(duration*rate));
%t = 1:(duration*sampleRate);

% 1 second
for i = (rate+1):(rate+t_on+1)
    outputN(i) = 4.5;
end

% Second Second
for i = (2*rate+2):(2*rate + t_on+1)
    outputN(i) = 4.5;
end

% Third Second
for i = (3*rate+2):(3*rate + t_on+1)
    outputN(i) = 4.5;
end
next = 3*rate+(2*(t_on)+2);
for i = next:next+t_on+1
    outputN(i) = 4.5;
end

next1 = 3*rate+(4*(t_on)+2);
for i = next1:next1+t_on+1
    outputN(i) = 4.5;
end

next2 = 3*rate+(6*(t_on)+2);
for i = next2:next2+t_on+1
    outputN(i) = 4.5;
end
%% Generate/Acquire continuous data
queueOutputData(s,outputN');
[data, timestamps, triggerTime] = s.startForeground;
%% Display the results
plot(timestamps, data);