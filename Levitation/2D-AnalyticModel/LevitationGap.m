clc, clear
%% Determine levitation gap over time
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

PodMass = 350;
PodForce = PodMass*9.81;
MechanicalClearance = 0.017;

[t, velocity] = full_velocity_profile(PodMass);

%% Run Simulations
ride_height = [];
for k=1:numel(velocity)
    d1 = gapInitial;
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,velocity(k),d1);
    
    % Handle case before transition speed
    if Force_y - PodForce < 0
        ride_height(end+1) = 0;
        continue;
    end
    
    % Find equilibrium gap
    while Force_y - PodForce > 0
        [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
        weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,velocity(k),d1);
        
        d1 = d1 + gapRes;
        if d1 > gapFinal
            break;
        end
    end
    ride_height(end+1) = d1;
end

%% Plot results
figure, hold on
ride_height(ride_height < MechanicalClearance) = MechanicalClearance;
plot(t, ride_height*1000)
wheel_clearance = ride_height - MechanicalClearance;
wheel_clearance(wheel_clearance < 0) = 0;
plot(t, wheel_clearance*1000)
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