function [v, x_prop] = v_prop(a_prop, t_prop, v_push)
% x = v0*t * 0.5*a*t^2
x_prop = v_push*t_prop + 0.5*a_prop*t_prop^2;
% v^2 = v0^2 + 2*a*delx
v = sqrt(v_push^2 + 2*a_prop*x_prop);
end