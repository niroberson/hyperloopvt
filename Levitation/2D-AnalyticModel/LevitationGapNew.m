%% Levitation Gap
clear all;
close all;

parameters = 'Hyperloop-Stilts';

[vfinal,profile,M,tau,Br,h,width,l,rho_track,d1_old,d2,P,PodWeight]...
          = ParameterSelect(parameters);
      
%% Setup Simulation

vlow = 0.1;
vres = 1;
size = vfinal/vres;

%gapInitial = 0.015
gapInitial = 0;
gapFinal = 0.025;
gapRes = 0.0001;
d1 = gapInitial;
d2 = gapInitial;

i = 1;
j = 1;

m = 1;
n = 1;

PodMass = 500;
PodForce = PodMass*9.81;
MechanicalClearance = 0.017;

%% Run Simulations
    
for d1 = gapInitial:gapRes:gapFinal    
    j = 1;
    m = 1;
    d2 = d1;
    for v = vlow:vres:vfinal
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,v,d1);
        F_lift(j,i) = Force_y;
        F_drag(j,i) = Force_z;
        if(F_lift(j,i) - PodForce > 0)
            if(flag == 0)
                velocity_gap(1,n) = v;
                F_lift_gap(1,n) = d1;
                clearance_wheel(1,n) = d1 - MechanicalClearance;
                n = n + 1;
                flag = 1;
                vlow = v;
                break;
            end
        end
        j = j + 1;
    end
    flag = 0;
    m = m + 1;
    i = i + 1;
end
% 250
for o=1:1:228
    if(F_lift_gap(1,o) < MechanicalClearance)
        F_lift_gap(1,o) = MechanicalClearance;
    end
end

v = 0.1:vres:vfinal;
    
if(strcmp(parameters,'Hyperloop-Brakes'))
    ax1 = subplot(2,1,1)
    plot(v,F_lift/1000)
    xlabel('Velocity (m/s)');
    ylabel('Lateral Force (kN)');
    title('Lateral Restoring Forces at Varying Perturbation Distances from Equillibrium');
    legend(ax1,'5mm','8mm','11mm','14mm');

    ax2 = subplot(2,1,2)
    plot(v,F_drag/1000);
    xlabel('Velocity (m/s)');
    ylabel('Drag Force (kN)');
    title('Braking Forces at Varying Distances from Rail');
    legend(ax2,'5mm','8mm','11mm','14mm','17mm')
end

if(strcmp(parameters,'Hyperloop-Stilts'))
    ax1 = subplot(2,1,1);
    plot(v,(F_lift-PodForce)/1000)
    axis([0 140 0 5])
    xlabel('Velocity (m/s)');
    ylabel('Levitation Force (kN)');
    title('Levitation forces at varying gaps (Pod skis)');
    %legend(ax1,'5mm','8mm','11mm','14mm','17mm');

    ax2 = subplot(2,1,2);
    plot(v,F_drag/1000);
    xlabel('Velocity (m/s)');
    ylabel('Drag Force (kN)');
    title('Magnetic Drag Forces at Varying Levitation Gaps (Pod Skis over Subtrack)');
    %legend(ax2,'5mm','8mm','11mm','14mm','17mm')
end

figure;

[ax,p1,p2] = plotyy(velocity_gap,F_lift_gap*1000,...
             velocity_gap,clearance_wheel*1000,'plot','plot');
title('Wheel and Magnet Clearance from Subtrack');
xlabel(ax(1),'Velocity (m/s)') % label x-axis
ylabel(ax(1),'Magnet Clearance (mm)') % label left y-axis
ylabel(ax(2),'Wheel Clearance (mm)') % label right y-axis
set(ax(1),'YLim',[0 30])
set(ax(1),'YTick',[0:5:30])
set(ax(2),'YLim',[0 30])
set(ax(2),'YTick',[0:5:30])
set(ax(1),'XLim',[0 130])
set(ax(1),'XTick',[0:10:130])
set(ax(2),'XLim',[0 130])
set(ax(2),'XTick',[0:10:130])
grid on
