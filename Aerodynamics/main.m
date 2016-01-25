% Plot Cd data from 3d simulation
v1_cd_1 = importdata('v1-cd-1-history-1');
v1_cd_2 = importdata('v1-cd-1-history-2');
v2_Cd = importdata('v2-cd-1-history');
v3_cd = importdata('v3-cd-1-history');

v1_time = [v1_cd_1.data(: , 1); v1_cd_2.data(:,1)];
v1_Cd = [v1_cd_1.data(:,2); v1_cd_2.data(:,2)];
v2_time = v2_cd.data(:,1);
v2_Cd = v2_cd.data(:,2);
v3_time = v3_cd.data(:,1);
v3_Cd = v3_cd.data(:,2);

v1_time_steady = v1_time(v1_time>0.12);
v1_Cd_steady = v1_Cd(v1_time>0.12);

% Plot Integral of Dynamic Pressure
figure, hold on
plot(v1_time_steady - 0.12, v1_Cd_steady, 'b')
plot(v2_time, v2_Cd, 'm')
plot(v3_time, v3_Cd, 'r')
xlabel('Simulation Time (s)')
ylabel('Cd')
title('Drag Coefficient for Design Iterations')
legend({'First Iteration', 'Second Iteration', 'Third Iteration'})
ylim([0.4 1.7])
%% Get the vortex shedding frequency

[val, idx_peaks] = findpeaks(v1_Cd_steady);
t_peaks = v1_time_steady(idx_peaks);

f_shed = [];
for i = 2:numel(t_peaks)
    f_shed = [f_shed 1/(t_peaks(i) - t_peaks(i - 1))];
end

f_shed = f_shed(f_shed < 100);
mean(f_shed)

% figure,plot(time(time>0.12), Cd(time>0.12))