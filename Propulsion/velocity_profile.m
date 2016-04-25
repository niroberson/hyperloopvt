clear, clc
dt = 0.001;
mPod = 350;
[gt, gx, gv] = full_velocity_profile(dt, mPod);

figure, hold on
subplot(2,1,1)
plot([gt(1) gt(end)], [mean(gv) mean(gv)])
legend({'Average Velocity'})
plot(gt, gv)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
 
subplot(2,1,2)
plot(gx, gv)
xlabel('Position (m)')
ylabel('Velocity (m/s)')