clear, clc
figure, hold on

%% Configuration
[V, Pi, At, T_min, k, R] = optimization('big_tank' , 'nitrogen');
[Fth, I, Ae] = nozzle(V, Pi, At, k, R, T_min);
plot(Ae, I, 'o')

%%
[V, Pi, At, T_min, k, R] = optimization('big_tank' , 'air');
T_min = 0;
[Fth, I, Ae] = nozzle(V, Pi, At, k, R, T_min);
plot(Ae, I, 'o')


%%
[V, Pi, At, T_min, k, R] = optimization('small_tank' , 'nitrogen');
[Fth, I, Ae] = nozzle(V, Pi, At, k, R, T_min);
plot(Ae, I, 'o')

%%
[V, Pi, At, T_min, k, R] = optimization('small_tank' , 'air');
[Fth, I, Ae] = nozzle(V, Pi, At, k, R, T_min);
plot(Ae, I, 'o')

%%
[V, Pi, At, T_min, k, R] = optimization('big_tank' , 'nitrogen');
[Fth, I, Ae] = nozzle(V, Pi, At, k, R, T_min);
plot(Ae, I, 'o')

legend({'Big, nitrogen', 'Big, air', 'Small, nitrogen', 'Small, air'}, 'location', 'best')