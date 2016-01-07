close all;
clear all;
% Drag parameter is dipping too quickly, for both values (Fig4,
% 3D-Paper-Final)

% Chose which figure to replicate
reference = '3D-Paper';
parameters = '3D-Final'; % Fig4 or Fig7, 3D-Paper or Custom
geometry = 'Single';

if(strcmp(parameters,'3D-Final'))
    vfinal = 41;
    tau_factor = 1.25;
elseif(strcmp(parameters,'3D-Initial'))
    vfinal = 41;
    tau_factor = 0.25;
elseif(strcmp(parameters,'2D-Paper'))
    vfinal = 55;
    tau_factor = 2;
elseif(strcmp(parameters,'3D-Experimental'))
    vfinal = 41;
    tau_factor = 5.25;
end
vres = 1;
 
F_lift = zeros(1,vfinal);
F_drag = zeros(1,vfinal);
n = zeros(1,vfinal);
i = 1;

for v = 1:vres:vfinal
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,parameters,geometry,tau_factor);
    F_lift(1,i) = Fy;
    F_drag(1,i) = (-1*Fz);
    n(1,i) = lift_drag_ratio;
    i = i + 1;
end

v = 1:vres:vfinal;
v_kmh = v*3.6;

if(strcmp(parameters,'3D-Final'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 5000])
    set(ax(1),'YTick',[0:1000:5000])
    set(ax(2),'YLim',[0 50])
    set(ax(2),'YTick',[0:10:50])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
    
elseif(strcmp(parameters,'3D-Initial'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 90])
    set(ax(1),'YTick',[0:30:90])
    set(ax(2),'YLim',[0 450])
    set(ax(2),'YTick',[0:150:450])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
  
elseif(strcmp(parameters,'3D-Experimental'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 1500])
    set(ax(1),'YTick',[0:500:1500])
    set(ax(2),'YLim',[0 1500])
    set(ax(2),'YTick',[0:500:1500])
    set(ax(1),'XLim',[0 25])
    set(ax(1),'XTick',[0:5:25])
    grid on;
    
elseif(strcmp(parameters,'Fig4'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 140])
    set(ax(1),'YTick',[0:20:140])
    set(ax(2),'YLim',[0 1.4])
    set(ax(2),'YTick',[0:0.2:1.4])
    set(ax(1),'XLim',[0 200])
    set(ax(1),'XTick',[0:50:150])
    grid on;
end


subplot(2,1,2);
plot(v_kmh,n);
title('Lift/Drag Ratio');
xlabel('Velocity (km/h)');
grid on;
