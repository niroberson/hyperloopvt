sitch = 'production';
duration = 6;
dt = 0.001;
t = 0:dt:duration;

%% Propulsion, isentropic, isothermal
isentropic_output = cold_gas_thruster(duration, dt, sitch, 'isentropic');
isothermal_output = cold_gas_thruster(duration, dt, sitch, 'isothermal');

%% Plot thrust
figure, hold on
plot(t, isentropic_output.Fth)
plot(t, isothermal_output.Fth)
legend('isentropic', 'isothermal')
xlabel('Time [s]')
ylabel('Thrust [N]')
title('Thrust Duration')

%% Plot system temperature
figure, hold on
plot(t, isentropic_output.T0)
plot(t, isentropic_output.Tt)
plot(t, isentropic_output.Te)
legend('Tank', 'Throat', 'Exhaust')
xlabel('Time [s]')
ylabel('Tempearture [K]')

%% Plot system pressure
figure, hold on
plot(t, isentropic_output.P0)
plot(t, isentropic_output.Pt)
plot(t, isentropic_output.Pe)
legend('Tank', 'Throat', 'Exhaust')
xlabel('Time [s]')
ylabel('Pressure [Pa]')

%% Plot acceleration over time
figure
mass_pod = 350 - isentropic_output.mass_loss;
plot(t, isentropic_output.Fth./(9.81*mass_pod))
xlabel('Time [s]')
ylabel('Acceleration [gs]')