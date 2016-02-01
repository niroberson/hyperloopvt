% Braking
clear all;

vpk = 5;
F_bmax = 3000;
velocity = 105;

v = 0:1:velocity;      % (m/s)
f_b = 2*F_bmax*((v*vpk)./(v.^2 + vpk.^2)); % (N)

i = 1;

for v_iter = -velocity:1:1
    v = v_iter*-1;
    f_b = 2*F_bmax*((v*vpk)./(v.^2 + vpk.^2)); % (N)
    f_b_new(i,1) = f_b;
    
    i = i + 1;
end

v_initial = 105;
mass = 500;
i = 1;
for t = 1:1:105
    v_final(i,1) = v_initial + (-1*f_b_new(i,1)/mass)*t
    v_initial = v_final(i,1);
    i = i + 1;
end
    
v_initial = 105;

t = 1:1:15;
plot(v_final)
%plot(f_b_new)
