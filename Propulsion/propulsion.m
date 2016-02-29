%% Propulsion
t=0:0.01:5;
[Fth, I, Ae, Te] = cold_gas_thruster('converging-diverging', t(end));
figure
subplot(2,1,1)
plot(t, Fth)
subplot(2,1,2)
plot(t, Te)

%% Propulsion 2
t=0:0.01:10;
[Fth, I, Ae, Te] = cold_gas_thruster('converging-diverging', t(end));
figure
subplot(2,1,1)
plot(t, Fth)
subplot(2,1,2)
plot(t, Te)