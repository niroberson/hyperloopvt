sampleRate = 300e3;
t_on = sampleRate/600;
duration = 5;

outputN = zeros(1,(duration*sampleRate));
t = 1:(duration*sampleRate);

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
plot(t,outputN)
%axis([0 600 0 5])