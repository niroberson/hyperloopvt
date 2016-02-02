% Sweep DoubleSidedEddyBrakes.m
vfinal = 20;
vstep = 0.001;
size = vfinal/vstep

F_brake = zeros(1,size);
i = 1;

for v = 0:vstep:vfinal
    F_brake(1,i) = DoubleSidedEddyBrakes(v);
    i = i + 1;
end

v = 0:vstep:vfinal;
plot(v,F_brake)