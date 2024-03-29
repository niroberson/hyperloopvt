% clear all; close all; 

function [Force_lift,Force_drag,Force_drag_x,Force_drag_z] =...
    magnetEQUATIONS(Vx,Vy,Vz,mHigh,nHigh,aTol,rTol)
% computes lift force and drag of a dual halbach array EDS device from
% 3-D velocities and specified computation bounds and resolution.

% resolution for coefficient integrals
atol = 1e0;
atol = aTol; % param switch
rtol = 1e0;
rtol = rTol; % param switch

% Magnet Parameters (m):
tau = 0.1*1e3;    % pole pitch
L1 = 0.4*1e3;     % length of array
tau_m = 0.05*1e3; % length of single magnet
t1 = 0.1*1e3;     % magnet thickness
w1 = .05*1e3;      % width of single magnet
Br = 1.28;    % magnet remanence
q = 2;        % number of magnets in one pole pair

% Track Parameters:
L2 = 0.8*1e3;       % length of plate
t2 = 0.006*1e3;     % thickness of plate
w2 = 1.2*1e3;       % width of aluminum plate
sigma = 2.54*1e7; % conductivity of plate

% Air-gap Parameters:
d1 = 0.026*1e3;        % upper air gap
d2 = 0.032*1e3;        % lower air gap
mew_0 = 4*pi*1e-7; % permeability of free space
 
v_y = 0;
v_y = Vy; % param switch
v_z = 0;
v_z = Vz; % param switch
v_x = 5*8.3333;
v_x = Vx; % param switch

xi_m = @(m) 2*pi*m./L2;
k_n = @(n) 2*pi*n./w2;
k_mn = @(m,n) sqrt((xi_m(m)).^2 + (k_n(n)).^2);

B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q);
psi = @(x, y, z, x0, z0) (z-z0)./sqrt((x-x0).^2 + y.^2 + (z-z0));
By_integrand = @(x, y, z, x0) B0*y/(2*pi).*(psi(x, y, z, x0, w2/2) - ...
    psi(x, y, z, x0, -w2/2)).*exp(1i.*x0.*pi/tau)./((x-x0).^2 + y.^2);

C1_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,-d1,z,x0).*exp(-1i.*(xi_m(m).*x + ...
    k_n(n).*z));
C1_mn_s_int = @(m,n) integral3(@(x0,x,z)C1_mn_s_integrand(x0,x,z,m,n),-L2/2, ...
    L2/2, -L2/2, L2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',atol,'RelTol',rtol);
C1_mn_s = @(m,n) C1_mn_s_int(m,n).*(1/(L2*w2));

C3_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,d2,z,x0).*exp(-1i.*(xi_m(m).*x +...
    k_n(n).*z));
C3_mn_s_int = @(m,n) integral3(@(x0,x,z)C3_mn_s_integrand(x0,x,z,m,n),-L2/2, L2/2,...
    -L2/2, L2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',atol,'RelTol',rtol);
C3_mn_s = @(m,n) C3_mn_s_int(m,n).*(1/(L2*w2));

lambda =  -0.5*v_y*mew_0*sigma;
gamma_mn = @(m,n) sqrt(k_mn(m,n)^2 - 1i*mew_0*sigma*(xi_m(m).*v_x + k_n(n).*v_z));
beta_mn = @(m,n) sqrt(lambda.^2 + gamma_mn(m,n).^2);

U_mn = @(m,n) (lambda.^2 - (beta_mn(m,n) + k_mn(m,n)).^2).*exp(2*beta_mn(m,n)*t2) - ...
    (lambda.^2 - (beta_mn(m,n) - k_mn(m,n)).^2);
R1_mn = @(m,n) (lambda + beta_mn(m,n) - k_mn(m,n)).*(lambda - beta_mn(m,n) - ...
    k_mn(m,n)).*(1 - exp(2*beta_mn(m,n).*t2))./U_mn(m,n);
R3_mn = @(m,n) (lambda + beta_mn(m,n) + k_mn(m,n)).*(lambda - beta_mn(m,n) + ...
    k_mn(m,n)).*(1 - exp(2*beta_mn(m,n).*t2))./U_mn(m,n);
T_mn = @(m,n,y) -4*beta_mn(m,n).*k_mn(m,n).*exp(beta_mn(m,n).*t2).*exp(lambda.*...
    (t2 + 2*y))./U_mn(m,n);

C1_mn_r = @(m,n)R1_mn(m,n).*C1_mn_s(m,n) + T_mn(m,n,-d1).*C3_mn_s(m,n);
C3_mn_r = @(m,n)R3_mn(m,n).*C3_mn_s(m,n) + T_mn(m,n,d2).*C1_mn_s(m,n);

f_mn_plus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) + conj(C3_mn_s(m,n)).*C3_mn_r(m,n);
f_mn_minus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) - conj(C3_mn_s(m,n)).*C3_mn_r(m,n);

% lift partial sums
S1 = 0;
S2 = 0;
% drag partial sums
D1 = 0;
D1b = 0;
D2 = 0;
D2b = 0;

h = waitbar(0,'Loading...','Name','Are we there yet?');

mhigh = 1e0;
mhigh = mHigh; % param switch
nhigh = 1e0;
nhigh = nHigh; % param switch
steps = 2*mhigh*2*nhigh;


for step = 1:steps
    % computations take place here
    for m = -mhigh:1:mhigh
        for n = -nhigh:1:nhigh
            if(m~=0 || n~=0) % m == 0 && n == 0 -> NaN
                p = -real(f_mn_minus(m,n));
                %q = real(1i.*(xi_m(m)+k_n(n))./k_mn(m,n).*f_mn_plus(m,n));
                q = real(1i.*(xi_m(m))./k_mn(m,n).*f_mn_plus(m,n));
                q2 = real(1i.*(k_n(n))./k_mn(m,n).*f_mn_plus(m,n));
                S1 = S1 + p;
                D1 = D1 + q;
                D1b = D1b + q2;
                % check status waitbar
                waitbar(step/steps,h,sprintf('Loading...%.2f%%',step/steps*100))
            end;
        end
        S2 = S2 + S1;
        D2 = D2 + D1;
        D2b = D2b + D1b;
    end
end

amppertesla = L2*w2/mew_0;
Force_lift = S2*amppertesla
Force_drag_x = D2*amppertesla
Force_drag_z = D2b*amppertesla
Force_drag = sqrt(Force_drag_x^2 + Force_drag_z^2)

delete(h)

=======
% clear all; close all; 

function [Force_lift,Force_drag] = MagnetEquations(Vx,Vy,Vz,mHigh,nHigh,aTol,rTol)
% computes lift force and drag of a dual halbach array EDS device from
% 3-D velocities and specified computation bounds and resolution.

% resolution for coefficient integrals
atol = 1e0;
atol = aTol; % param switch
rtol = 1e0;
rtol = rTol; % param switch

% Magnet Parameters (m):
tau = 0.1;    % pole pitch
L1 = 0.4;     % length of array
tau_m = 0.05; % length of single magnet
t1 = 0.1;     % magnet thickness
w1 = .05;      % width of single magnet
Br = 1.28;    % magnet remanence
q = 2;        % number of magnets in one pole pair

% Track Parameters:
L2 = 0.8;       % length of plate
t2 = 0.006;     % thickness of plate
w2 = 1.2;       % width of aluminum plate
sigma = 2.54*1e7; % conductivity of plate

% Air-gap Parameters:
d1 = 0.026;        % upper air gap
d2 = 0.032;        % lower air gap
mew_0 = 4*pi*1e-7; % permeability of free space
 
v_y = 0;
v_y = Vy; % param switch
v_z = 0;
v_z = Vz; % param switch
v_x = 5*8.3333;
v_x = Vx; % param switch

xi_m = @(m) 2*pi*m./L2;
k_n = @(n) 2*pi*n./w2;
k_mn = @(m,n) sqrt((xi_m(m)).^2 + (k_n(n)).^2);

B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q);
psi = @(x, y, z, x0, z0) (z-z0)./sqrt((x-x0).^2 + y.^2 + (z-z0));
By_integrand = @(x, y, z, x0) B0*y/(2*pi).*(psi(x, y, z, x0, w2/2) - ...
    psi(x, y, z, x0, -w2/2)).*exp(1i.*x0.*pi/tau)./((x-x0).^2 + y.^2);

C1_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,-d1,z,x0).*exp(-1i.*(xi_m(m).*x + ...
    k_n(n).*z));
C1_mn_s_int = @(m,n) integral3(@(x0,x,z)C1_mn_s_integrand(x0,x,z,m,n),-L2/2, ...
    L2/2, -L2/2, L2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',atol,'RelTol',rtol);
C1_mn_s = @(m,n) C1_mn_s_int(m,n).*(1/(L2*w2));

C3_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,d2,z,x0).*exp(-1i.*(xi_m(m).*x +...
    k_n(n).*z));
C3_mn_s_int = @(m,n) integral3(@(x0,x,z)C3_mn_s_integrand(x0,x,z,m,n),-L2/2, L2/2,...
    -L2/2, L2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',atol,'RelTol',rtol);
C3_mn_s = @(m,n) C3_mn_s_int(m,n).*(1/(L2*w2));

lambda =  -0.5*v_y*mew_0*sigma;
gamma_mn = @(m,n) sqrt(k_mn(m,n)^2 - 1i*mew_0*sigma*(xi_m(m).*v_x + k_n(n).*v_z));
beta_mn = @(m,n) sqrt(lambda.^2 + gamma_mn(m,n).^2);

U_mn = @(m,n) (lambda.^2 - (beta_mn(m,n) + k_mn(m,n)).^2).*exp(2*beta_mn(m,n)*t2) - ...
    (lambda.^2 - (beta_mn(m,n) - k_mn(m,n)).^2);
R1_mn = @(m,n) (lambda + beta_mn(m,n) - k_mn(m,n)).*(lambda - beta_mn(m,n) - ...
    k_mn(m,n)).*(1 - exp(2*beta_mn(m,n).*t2))./U_mn(m,n);
R3_mn = @(m,n) (lambda + beta_mn(m,n) + k_mn(m,n)).*(lambda - beta_mn(m,n) + ...
    k_mn(m,n)).*(1 - exp(2*beta_mn(m,n).*t2))./U_mn(m,n);
T_mn = @(m,n,y) -4*beta_mn(m,n).*k_mn(m,n).*exp(beta_mn(m,n).*t2).*exp(lambda.*...
    (t2 + 2*y))./U_mn(m,n);

C1_mn_r = @(m,n)R1_mn(m,n).*C1_mn_s(m,n) + T_mn(m,n,-d1).*C3_mn_s(m,n);
C3_mn_r = @(m,n)R3_mn(m,n).*C3_mn_s(m,n) + T_mn(m,n,d2).*C1_mn_s(m,n);

f_mn_plus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) + conj(C3_mn_s(m,n)).*C3_mn_r(m,n);
f_mn_minus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) - conj(C3_mn_s(m,n)).*C3_mn_r(m,n);

% lift partial sums
S1 = 0;
S2 = 0;
% drag partial sums
D1 = 0;
D2 = 0;

h = waitbar(0,'Loading...','Name','Are we there yet?');

mhigh = 1e0;
mhigh = mHigh; % param switch
nhigh = 1e0;
nhigh = nHigh; % param switch
steps = 2*mhigh*2*nhigh;

for step = 1:steps
    % computations take place here
    for m = -mhigh:1:mhigh
        for n = -nhigh:1:nhigh
            if(m~=0 || n~=0) % m == 0 && n == 0 -> NaN
                p = -real(f_mn_minus(m,n));
                q = real((xi_m(m)+k_n(n))/k_mn(m,n)*f_mn_plus(m,n));
                S1 = S1 + p;
                D1 = D1 + q;
                % check status waitbar
                waitbar(step/steps,h,sprintf('Loading...%.2f%%',step/steps*100))
            end;
        end
        S2 = S2 + S1;
        D2 = D2 + D1;
    end
end

amppertesla = L2*w2/mew_0;
Force_lift = S2*amppertesla
Force_drag = D2*amppertesla

delete(h)

end