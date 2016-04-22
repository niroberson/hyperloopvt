sitch = 'production';

%% Propulsion
duration = 10;
dt = 0.001;
t = 0:dt:duration;
output = cold_gas_thruster(duration, dt, sitch);

%% Plot thrust
figure, plot(t, output.Fth)
xlabel('Time [s]')
ylabel('Thrust [N]')
title('Thrust Duration')

%% Plot system temperature
figure, hold on
plot(t, output.T0)
plot(t, output.Tt)
plot(t, output.Te)
legend('Tank', 'Throat', 'Exhaust')
xlabel('Time [s]')
ylabel('Tempearture [K]')

%% Plot system pressure
figure, hold on
plot(t, output.P0)
plot(t, output.Pt)
plot(t, output.Pe)
legend('Tank', 'Throat', 'Exhaust')
xlabel('Time [s]')
ylabel('Pressure [Pa]')

%% Plot acceleration over time
figure
mass_pod = 300 - output.mass_loss;
plot(t, output.Fth./(9.81*mass_pod))
xlabel('Time [s]')
ylabel('Acceleration [gs]')