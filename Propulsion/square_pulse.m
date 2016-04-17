mPod = 350;
[gt, gx, gv] = full_velocity_profile(mPod);

x_tape = 0:30.48:1609;
x_track = 0:0.001:1609.344;
pulse = zeros(1,numel(x_track));

for i=1:numel(x_tape)
    if any(abs(x_tape(i) - gx) < 1e-8)
        v = gv(abs(gx - x_tape(i)) < 1e-1);
        dt = 0.1016./v(1);
        fprintf('Velocity: %0.05f --- Time: %0.05f \n', v(1), dt)
    end
end

for i = 1:numel(x_track)
    if any(abs(x_track(i) - x_tape) < 0.1016/2)
        pulse(i) = 1;
    end
end

% Need plot(t, pulse)
