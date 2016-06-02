%% Determine levitation gap over time
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
gapFinal = 0.040;
gapRes = 0.0001;
d1 = gapInitial;
d2 = gapInitial;

dt = 0.1;
l_track = 1609;
PodMass = 250;
PodForce = PodMass*9.81;
MechanicalClearance = 0.017;

[gt, gx, velocity] = full_velocity_profile(dt, PodMass, l_track);

%% Run Simulations
ride_height = [];
for k=1:numel(velocity)
    d1 = gapInitial;
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                   = DoubleHalbachModelNew(parameters,velocity(k),d1,h);
    
    % Handle case before transition speed
    if Force_y - PodForce < 0
        ride_height(end+1) = 0;
        continue;
    end
    
    % Find equilibrium gap
    while Force_y - PodForce > 0
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                    = DoubleHalbachModelNew(parameters,velocity(k),d1,h);
        
        d1 = d1 + gapRes;
        if d1 > gapFinal
            break;
        end
    end
    ride_height(end+1) = d1;
end

%% Calculate drag at expected ride heights
Force_y_gap = [];
Force_z_gap = [];
for k=1:numel(velocity)
    d1 = ride_height(k)
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModelNew(parameters,velocity(k),d1,h);
    Force_y_gap(end+1) = Force_y;
    Force_z_gap(end+1) = Force_z;                
end    

%% Plot results
figure, hold on
ride_height(ride_height < MechanicalClearance) = MechanicalClearance;
plot(gt, ride_height*1000)
wheel_clearance = ride_height - MechanicalClearance;
wheel_clearance(wheel_clearance < 0) = 0;
plot(gt, wheel_clearance*1000)
xlabel('Time (s)');
ylabel('Clearance (mm)');
title('Surface Clearance vs. Time');
legend('Magnet Surface','Wheel Surface')

figure
plot(velocity, wheel_clearance*1000)
xlabel('Velocity (m/s)');
ylabel('Clearance (mm)');
title('Wheel Clearance vs. Velocity');
text(9,0.25,'\leftarrow Lift Off Velocity \approx 8 m/s')

figure
plot(velocity, ride_height*1000);
xlabel('Velocity (m/s)');
ylabel('Clearance (mm)');
title('Magnet Surface Clearance vs. Velocity');
text(9,17.25,'\leftarrow Lift Off Velocity \approx 8 m/s')

figure
plot(gt, Force_y_gap);
xlabel('Time (s)');
ylabel('Force (N)');
title('Force vs. Velocity');
hold on;
plot(gt, Force_z_gap);
legend('Lift','Drag');
