%% Stability Calculations
clear all;
close all;

%parameters = 'Hyperloop-Doubles';
parameters = 'Hyperloop-Stilts';

[vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
          = ParameterSelect(parameters);

%% Set up the simulation

c = d1; % Distance from bottom of top halbach to top of bottom halbach
gapInitial = 0.000;
gapFinal = 0.045;
gapRes = 0.0001;
size = (gapFinal-gapInitial)/gapRes;

i = 1;
k = 1;

for v=10:100:110
    for d1 = gapInitial:gapRes:gapFinal
        %d2 = c - l - d1; % d2 as a function of d1 and conductor thickness
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
            weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModelNew(parameters,v,d1,h);
        F_lift(1,i) = Force_y;
        F_drag(1,i) = Force_z;
        n(1,i) = LtD;
        m(1,i) = LtW;
        i = i + 1;
    end
    
    if k == 1
        F_lift_v10 = F_lift;
        i = 1;
    elseif k == 2
        F_lift_v110 = F_lift;
    end
    k = k + 1;
end                        

gap = gapInitial:gapRes:gapFinal;
gap = gap*1000;

plot(gap,F_lift_v10/1000);
hold on;
plot(gap,F_lift_v110/1000);
title('Total Stiffness vs. Gap');
xlabel('Gap (mm)') % label x-axis
ylabel('kN/mm');
legend('v = 10 m/s',' v = 110 m/s');
grid on;
                  