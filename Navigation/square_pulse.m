%clear all;
function [pulse] = square_pulse(sRate)
mPod = 350;
dt = 0.01;
[gt, gx, gv] = full_velocity_profile(dt,mPod,1609);

x_tape = 0:30.48:1609;

% for i=1:numel(x_tape)
%     if any(abs(x_tape(i) - gx) < 1e-8)
%         v = gv(abs(gx - x_tape(i)) < 1e-1)
%         dt = 0.1016./v(1)
%         fprintf('Velocity: %0.05f --- Time: %0.05f \n', v(1), dt)
%     end
% end

for i=1:numel(x_tape)
    for j=1:numel(gx)
        if(abs(x_tape(1,i) - gx(1,j)) < 0.9)
            
            location(1,i) = j;
            value(1,i) = gx(1,j);
            v(1,i) = gv(1,j); 
            
            if(i == 1)
                dt_on(1,i) = 0;
            else
                dt_on(1,i) = 0.1016/v(1,i);
            end
            
            if(i == 1)
                dt_off(1,i) = 0;
            elseif(i == 2)
                dt_off(1,i) = gt(1,j);
            else
                deltaT = gt(1,j) - gt(1,location(1,(i-1)));
                dt_off(1,i) = deltaT - dt_on(1,(i-1));
            end
            
            break;
        end
    end
end

dt_off = dt_off*sRate;
dt_on = dt_on*sRate;

dt_off = round(dt_off);
dt_on = round(dt_on);

k = 0;
size = sum(dt_off) + sum(dt_on);

for i=2:numel(x_tape)
    for j=(k+1):(k+dt_off(1,i))
        pulse(j) = 0;
    end
    
    for j= (k+dt_off(1,i)):(k + dt_off(1,i) + dt_on(1,i))
        pulse(j) = 1;
    end
    
    k = (k + dt_off(1,i) + dt_on(1,i));
end

pulse = 5*pulse';
csvwrite('pulse_data.csv',pulse);       
 
        