clear all; close all;

vres = 8.3333;
vlow = 0;
vhigh = 5*8.3333;
mbound = 1e0; % bound for fourier sums
nbound = 1e0;
atol = 1e0; % desired tolerance
rtol = 1e0;
iternum = (2*mbound)+(2*nbound);

tic % time start

for vx = vlow:vres:vhigh
    if vx == vlow
        [levF,dragF] = MagnetEquations(0,0,0,mbound,nbound,atol,rtol);
    else
        [nextlev,nextdrag] = MagnetEquations(vx,0,0,mbound,nbound,atol,rtol);
        levF = [levF,nextlev];
        dragF = [dragF,nextdrag];
    end
end

figure(1)
subplot(1,2,1);
scatter(vlow:vres:vhigh,levF,'filled');
hold on
plot(vlow:vres:vhigh,levF);
ylabel('Lift Force [N]');
xlabel('Velocity [m/s]');
grid

subplot(1,2,2);
scatter(vlow:vres:vhigh,dragF,'filled');
hold on
plot(vlow:vres:vhigh,dragF);
ylabel('Drag Force [N]');
xlabel('Velocity [m/s]');
grid

toc % time stop