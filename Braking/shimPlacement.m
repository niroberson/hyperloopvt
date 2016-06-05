% Minimizes overall centerline offset of mis-aligned rotating disk,
% measured at 12 points equally spaced around circumference. Code accounts
% for opposing edge deflection due to shims, but the method needs to be
% implemented on a curve-fit basis to account for next-door shim effects.

clear, clc;

D_sprocket = 5.12;
D_disk = 36;
probe = 2.045;
t_shim = 0.0625;

ratio = (D_disk-probe) / D_sprocket;

% input data points
data = zeros(1,12);
for i=1:12
    data(i) = input('Data point: ') / 100;
end

% only looking at offset from center, not 
avg = mean(data);
data = data - avg;

% center opposing offsets around midline by average value
off = zeros(1,12);
for i = 1:6
    off(i) = (data(i) + data(i+6)) / 2;
end
for i = 7:12
    off(i) = (data(i) + data(i-6)) / 2;
end

% distance to shim conversion
shims = off./ratio;
placement = [1:0.5:6.5; shims]

% fit measure and improvement
range1 = max(data) - min(data);
peak1 = max(max(data),abs(min(data)));
range2 = max(off)-min(off);
peak2 = max(max(off),abs(min(off)));

Range_improve_percent = 100 * (1 - range2 / range1)
Peak_improve_percent = 100 * (1 - peak2 / peak1)

% plot it
hold on
plot([0 12], [0 0]);
plot(1:12, data);
plot(1:12, off);
title('Offset of disk from centerline');
xlabel('data point');
ylabel('offset (in)');
legend('centerline', 'original data', 'shimmed');
