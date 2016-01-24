% Plot Cd data from 3d simulation
cd_data_1 = importdata('cd-1-history-1');
cd_data_2 = importdata('cd-1-history-2');

% Plot Integral of Dynamic Pressure
figure, hold on
plot([0.12, 0.12], [0, 6], '--g')
plot(cd_data_1.data(:,1), cd_data_1.data(:,2), 'b')
plot(cd_data_2.data(:,1), cd_data_2.data(:,2), 'b')
xlabel('Simulation Time (s)')
ylabel('Cd')
title('Drag Coefficient Over Simulation')
legend({'Steady State'})

%% Get the vortex shedding frequency
time = [cd_data_1.data(: , 1); cd_data_2.data(:,1)];
Cd = [cd_data_1.data(:,2); cd_data_2.data(:,2)];
time_steady = time(time>0.12);
Cd_steady = Cd(time>0.12);
[val, idx_peaks] = findpeaks(Cd_steady);
t_peaks = time_steady(idx_peaks);

f_shed = [];
for i = 2:numel(t_peaks)
    f_shed = [f_shed 1/(t_peaks(i) - t_peaks(i - 1))];
end

f_shed = f_shed(f_shed < 100);
mean(f_shed)

% figure,plot(time(time>0.12), Cd(time>0.12))