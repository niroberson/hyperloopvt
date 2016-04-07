function [Force_lift, Force_drag, Force_lift_matrix,Force_drag_matrix] = MagnetEquationsRomainMN(v_x, v_y, v_z, mHigh, nHigh, aTol, rTol)
% defining parameters of set up--------------------------------------------
tau = 0.1;    % pole pitch
L1 = 0.4;     % length of array
tau_m = 0.05; % length of single magnet
t1 = 0.1;     % magnet thickness
w1 = .05;      % width of single magnet
Br = 1.28;    % magnet remanence
q = 2;        % number of magnets in one pole pair
P = 2;        % Number of pole pairs

% Track Parameters:
L2 = 0.8;       % length of plate
t2 = 0.006;     % thickness of plate
w2 = 1.2;       % width of aluminum plate
sigma = 2.54*1e7; % conductivity of plate

% Air-gap Parameters:
d1 = 0.026;        % upper air gap
d2 = 0.032;        % lower air gap

mu_0 = 4*pi*1e-7; % permeability of free space

Force_drag_matrix = zeros(mHigh*2+1, nHigh*2+1); 
Force_lift_matrix = zeros(mHigh*2+1, nHigh*2+1); 
Force_drag = 0;
Force_lift = 0;

% manually defining arguments for now
mRes = 1;
nRes = 1;
ytop = -d1;
ybot = d2;

% begin computations-------------------------------------------------------
for m = -mHigh:mRes:mHigh %m = -mHigh:mRes:mHigh
%for m = 51:mRes:100
    for n = -nHigh:nRes:nHigh %n = -nHigh:nRes:nHigh
        if(m~=0 || n~=0) % m == 0 && n == 0 -> NaN    
            % all code goes here
            % eqn 18, 19, 20
            xi = 2*pi*m/L2;
            k = 2*pi*n/w2;
            kappa = sqrt((xi).^2 + (k).^2);
            % eqn 28, 29, 30
            lambda =  -0.5*v_y*mu_0*sigma;
            gamma = sqrt(kappa^2 - 1i*mu_0*sigma*(xi*v_x + k*v_z));
            beta = sqrt(lambda^2 + gamma^2);
            % eqn 35, 33, 34, 36
            U = (lambda^2 - (beta + kappa)^2)*exp(2*beta*t2) - ...
                (lambda^2 - (beta - kappa)^2);
            R1 = (lambda + beta - kappa)*(lambda - beta - ...
                kappa)*(1 - exp(2*beta*t2))/U;
            R3 = (lambda + beta + kappa)*(lambda - beta + ...
                kappa)*(1 - exp(2*beta*t2))/U;
            T_ytop = -4*beta*kappa*exp(beta*t2)*exp(lambda*...
                (t2 + 2*ytop))/U;
            T_ybot = -4*beta*kappa*exp(beta*t2)*exp(lambda*...
                (t2 + 2*ybot))/U;
            
            
            z0 = w2/2; % think about what z0 actually represents

            % performs integrations on x0, x, and z------------------------
            % eqn 14 and 13 plugged into 22 and 24
            B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q);
            [C1_s_int, C3_s_int] = C_1_3_integrations(B0, tau, z0, ytop, ybot, xi, k, L1, L2, w2, aTol, rTol);
            
            C1_s = C1_s_int*(1/(L2*w2));
            C3_s = C3_s_int*(1/(L2*w2));

            C1_r = R1*C1_s + T_ytop*C3_s; % ERRORR % THIS NEEDS TO BE Y=0
            C3_r = R3*C3_s + T_ybot*C1_s; % ERRORR % THIS NEEDS TO BE Y=-t2

            % eqn 39 and 40
            f_plus = conj(C1_s)*C1_r + conj(C3_s)*C3_r;
            f_minus = conj(C1_s)*C1_r - conj(C3_s)*C3_r;
            
            % eqn 38
            Force_lift_matrix(m+mHigh+1,n+nHigh+1) = real(-f_minus); %y hat component
            Force_drag_matrix(m+mHigh+1,n+nHigh+1) = real(1i*xi/kappa*f_plus); %x hat component
            
            Force_lift = Force_lift + Force_lift_matrix(m+mHigh+1,n+nHigh+1);
            Force_drag = Force_grad + Force_drag_matrix(m+mHigh+1,n+nHigh+1);
        end
    end
    display(m)
end
end