v_x = 150;
v_y = 0;
v_z = 0;
mHigh = 100;
nHigh = 100;
aTol = 1;
rTol = 1;

[Force_lift, Force_drag, Force_lift_matrix, Force_drag_matrix] = MagnetEquationsRomainMN(v_x, v_y, v_z, mHigh, nHigh, aTol, rTol);