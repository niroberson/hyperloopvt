% Plot Cd data from 3d simulation
cd_data_1 = importdata('cd-1-history-1');
cd_data_2 = importdata('cd-1-history-2');

% Plot Integral of Dynamic Pressure
figure, hold on
plot(cd_data_1.data(:,1), cd_data_1.data(:,2))
plot(cd_data_2.data(:,1), cd_data_2.data(:,2))