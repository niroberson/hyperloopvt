clear all; close all;

vres = 8.3333;
vlow = 0;
vhigh = 5*8.3333;
mbound = 1e0; % bound for fourier sums
nbound = 1e0;
atol = 1e0; % desired tolerance
rtol = 1e0;

% reference values from null flux paper for vx = 8.3:8.3:5*8.3
liftREF = [0, 140,  262.5  337.5  380,  412];
dragREF = [0, 26, 37.5, 44.5, 50, 55];

tic % time start

for vx = vlow:vres:vhigh
    if vx == vlow
        [levF,dragF,dragFx,dragFz] = magnetEQUATIONS(0,0,0,mbound,nbound,atol,rtol);
    else
        [nextlev,nextdrag,Fx,Fz] = magnetEQUATIONS(vx,0,0,mbound,nbound,atol,rtol);
        levF = [levF,nextlev];
        dragF = [dragF,nextdrag];
        dragFx = [dragFx,Fx];
        dragFz = [dragFz,Fz];
    end
end

figure
subplot(2,2,1);
scatter(vlow:vres:vhigh,levF,'filled');
hold on
plot(vlow:vres:vhigh,levF);
ylabel('Lift Force [N]');
xlabel('Translational Velocity [m/s]');
grid

subplot(2,2,2);
scatter(vlow:vres:vhigh,dragF,'filled');
hold on
plot(vlow:vres:vhigh,dragF);
ylabel('Drag Force [N]');
xlabel('Translational Velocity [m/s]');
grid

subplot(2,2,3);
plot(vlow:vres:vhigh,levF,'-o');
hold on;
plot(vlow:vres:vhigh,dragF,'-d');
hold on;
plot(vlow:vres:vhigh,abs(dragFx),'--d');
hold on;
plot(vlow:vres:vhigh,abs(dragFz),'--d');
ylabel('Force [N]');
xlabel('Translational Velocity [m/s]');
axis([0 45 0 max(levF)*1.67])
i=legend('lift','drag','trans drag ($$\hat{x}$$)','planar drag ($$\hat{z}$$)');
set(i,'Interpreter','Latex');
title('Lorentz Forces from Dual Halbach PM i-EC on Al Conductor');
grid

subplot(2,2,4);
plot(vlow:vres:vhigh,liftREF,'--','LineWidth',2);
hold on;
plot(vlow:vres:vhigh,dragREF,'--','LineWidth',2);
hold on;
plot(vlow:vres:vhigh,levF,'-o');
hold on;
plot(vlow:vres:vhigh,dragF,'-d');
hold on;
ylabel('Force [N]');
xlabel('Translational Velocity [m/s]');
axis([0 45 0 max(liftREF)*1.67])
i=legend('lift ref','drag ref','lift model','drag model');
set(i,'Interpreter','Latex');
title('Model Forces vs. True Values');
grid

toc % time stop