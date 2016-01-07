close all;
clear all;
% Drag parameter is dipping too quickly, for both values (Fig4,
% 3D-Paper-Final)

% Chose which figure to replicate
<<<<<<< HEAD
parameters = '3D-Experimental'; % Fig4 or Fig7, 3D-Paper or Custom
=======
reference = '3D-Paper';
parameters = '3D-Final'; % Fig4 or Fig7, 3D-Paper or Custom
geometry = 'Single';
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7

if(strcmp(parameters,'3D-Final'))
    vfinal = 41;
    tau_factor = 1.25;
<<<<<<< HEAD
    geometry = 'Double';
elseif(strcmp(parameters,'3D-Initial'))
    vfinal = 41;
    tau_factor = 0.045;
    geometry = 'Double';
elseif(strcmp(parameters,'3D-Experimental'))
    vfinal = 41;
    tau_factor = 0.15;
    geometry = 'Double';
elseif(strcmp(parameters,'2D-Paper'))
    vfinal = 55;
    tau_factor = 2;
    geometry = 'Double';
elseif(strcmp(parameters,'Second-2D'))
    vfinal = 69;
    tau_factor = 0.70;
    geometry = 'Single';
    
% Characteristic analysis of electrodynamic suspension device
% with permanent magnet Halbach array
elseif(strcmp(parameters,'Third-2D'))
    vfinal = 69;
    tau_factor = 0.20;
    geometry = 'Single';
elseif(strcmp(parameters,'Fourth-2D'))
    vfinal = 69;
    tau_factor = 0.20;
    geometry = 'Single';
elseif(strcmp(parameters,'Magplane'))
    vfinal = 60;
    tau_factor = 0.35;
    geometry = 'Single';
end

vres = 0.1;
size = vfinal/0.1;

F_lift = zeros(1,size);
F_drag = zeros(1,size);
n = zeros(1,size);
i = 1;

for v = 0.1:vres:vfinal
=======
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
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
    [Fy,Fz,lift_drag_ratio] = DoubleHalbachModel(v,parameters,geometry,tau_factor);
    F_lift(1,i) = Fy;
    F_drag(1,i) = (-1*Fz);
    n(1,i) = lift_drag_ratio;
    i = i + 1;
end

<<<<<<< HEAD
v = 0.1:vres:vfinal;
=======
v = 1:vres:vfinal;
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
v_kmh = v*3.6;

if(strcmp(parameters,'3D-Final'))
    subplot(2,1,1);
<<<<<<< HEAD
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 5])
    set(ax(1),'YTick',[0:1:5])
=======
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 5000])
    set(ax(1),'YTick',[0:1000:5000])
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
    set(ax(2),'YLim',[0 50])
    set(ax(2),'YTick',[0:10:50])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
    
<<<<<<< HEAD
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'3D-Initial'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
=======
elseif(strcmp(parameters,'3D-Initial'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
    set(ax(1),'YLim',[0 90])
    set(ax(1),'YTick',[0:30:90])
    set(ax(2),'YLim',[0 450])
    set(ax(2),'YTick',[0:150:450])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
<<<<<<< HEAD
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'3D-Experimental'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift,'plot','plot');
=======
  
elseif(strcmp(parameters,'3D-Experimental'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
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
    
<<<<<<< HEAD
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
=======
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
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
<<<<<<< HEAD
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Second-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 2])
    set(ax(1),'YTick',[0:0.5:2])
    set(ax(2),'YLim',[0 6])
    set(ax(2),'YTick',[0:1:6])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
elseif(strcmp(parameters,'Third-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 1])
    set(ax(1),'YTick',[0:0.2:1])
    set(ax(2),'YLim',[0 3])
    set(ax(2),'YTick',[0:0.5:3])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Magplane'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag/1000,v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 100])
    set(ax(1),'YTick',[0:10:100])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:10:100])
    set(ax(1),'XLim',[0 60])
    set(ax(1),'XTick',[0:10:60])
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
end
=======
end


subplot(2,1,2);
plot(v_kmh,n);
title('Lift/Drag Ratio');
xlabel('Velocity (km/h)');
grid on;
>>>>>>> e241c6b46824e4265e11ba402c4addb6f5f738c7
