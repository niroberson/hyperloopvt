% Plot Cd data from 3d simulation
cd_data = importdata('cd-1-history');
% Plot Integral of Dynamic Pressure
int_p = importdata('int_dynamic_pressure');
figure, plot(cd_data.data(:,1), cd_data.data(:,2))
figure,plot(int_p.data(:,1), int_p.data(:,2))
