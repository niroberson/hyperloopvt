% clear all; close all; 

function [Force_lift,Force_drag] = MagnetEquationsAlex(Vx,mHigh,nHigh,aTol,rTol,mRes,nRes,Values,Type)
% computes lift force and drag of a dual halbach array EDS device from
% 3-D velocities and specified computation bounds and resolution
Vy = 0;
Vz = 0;

if(strcmp(Values,'Initial'))
    % Magnet Parameters (m):
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
end

if(strcmp(Values,'Final'))
    % Magnet Parameters (m):
    tau = 0.3;    % pole pitch
    L1 = 1.2;     % length of array
    tau_m = 0.15; % length of single magnet
    t1 = 0.105;     % magnet thickness
    w1 = .45;      % width of single magnet
    Br = 1.28;    % magnet remanence
    q = 2;        % number of magnets in one pole pair
    P = 2;        % Number of pole pairs

    % Track Parameters:
    L2 = 2.4;       % length of plate
    t2 = 0.006;     % thickness of plate
    w2 = 1.2;       % width of aluminum plate
    sigma = 2.54*1e7; % conductivity of plate

    % Air-gap Parameters:
    d1 = 0.026;        % upper air gap
    d2 = 0.050;        % lower air gap
end

if(strcmp(Values,'Experimental'))
    % Magnet Parameters (m):
    tau = 0.1;    % pole pitch
    L1 = 0.4;     % length of array
    tau_m = 0.05; % length of single magnet
    t1 = 0.05;     % magnet thickness
    w1 = .1;      % width of single magnet
    Br = 1.1;    % magnet remanence
    q = 2;        % number of magnets in one pole pair
    P = 2;        % Number of pole pairs

    % Track Parameters:
    L2 = 2.4;       % length of plate
    %L2 = 0.8;
    t2 = 0.003;     % thickness of plate
    w2 = 1.2;       % width of aluminum plate
    sigma = 2.57*1e7; % conductivity of plate

    % Air-gap Parameters:
    d1 = 0.021;        % upper air gap
    d2 = 0.042;        % lower air gap
end

if(strcmp(Values,'Custom'))
    % Magnet Parameters (m):
    tau = 0.0254;    % pole pitch
    L1 = 0.0635;     % length of array
    tau_m = 0.0127; % length of single magnet
    t1 = 0.0127;     % magnet thickness
    w1 = 0.0127;      % width of single magnet
    Br = 1.48;    % magnet remanence
    q = 2;        % number of magnets in one pole pair
    P = 2.5;        % Number of pole pairs

    % Track Parameters:
    L2 = 2.4;       % length of plate
    t2 = 0.00047;     % thickness of plate
    w2 = 1.2;       % width of aluminum plate
    sigma = 2.57*1e7; % conductivity of plate

    % Air-gap Parameters:
    d1 = 0.005;        % upper air gap
    d2 = 0.005;        % lower air gap
end
    
mew_0 = 4*pi*1e-7; % permeability of free space
 
v_y = Vy; % param switch
v_z = Vz; % param switch
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
                               'AbsTol',aTol,'RelTol',rTol);
C1_mn_s = @(m,n) C1_mn_s_int(m,n).*(1/(L2*w2));

C3_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,d2,z,x0).*exp(-1i.*(xi_m(m).*x +...
    k_n(n).*z));
C3_mn_s_int = @(m,n) integral3(@(x0,x,z)C3_mn_s_integrand(x0,x,z,m,n),-L2/2, L2/2,...
    -L2/2, L2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',aTol,'RelTol',rTol);
C3_mn_s = @(m,n) C3_mn_s_int(m,n).*(1/(L2*w2));
if(strcmp(Type,'Single'))
    C3_mn_s = @(m,n) 0; %
end

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
    (t2 + 2.*y))./U_mn(m,n);

C1_mn_r = @(m,n)R1_mn(m,n).*C1_mn_s(m,n) + T_mn(m,n,-d1).*C3_mn_s(m,n);
C3_mn_r = @(m,n)R3_mn(m,n).*C3_mn_s(m,n) + T_mn(m,n,d2).*C1_mn_s(m,n);

f_mn_plus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) + conj(C3_mn_s(m,n)).*C3_mn_r(m,n); % EDIT THIS
f_mn_minus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) - conj(C3_mn_s(m,n)).*C3_mn_r(m,n);
if(strcmp(Type,'Single'))
    f_mn_plus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n);
    f_mn_minus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n);
end

% lift partial sums
S1 = 0;
S2 = 0;
% drag partial sums
D1 = 0;
D2 = 0;

%% Start Computations 

h = waitbar(0,'Loading...','Name','MagnetEquations');
i = 1;
%steps = mHigh*2/mRes;
%m = -mHigh:mRes:mHigh;
%[~,steps] = size(m);
m = 1:2:mHigh;
[~,steps] = size(m);

% computations take place here
for m = -mHigh:mRes:mHigh %m = -mHigh:mRes:mHigh
    for n = -nHigh:nRes:nHigh %n = -nHigh:nRes:nHigh
        if(m~=0 || n~=0) % m == 0 && n == 0 -> NaN
            if(strcmp(Type,'Lift'))
                p = real(-feval(f_mn_minus,m,n));
                S1 = S1 + p;
            elseif(strcmp(Type,'Drag'))
                q = real(1i.*((xi_m(m))./k_mn(m,n)).*f_mn_plus(m,n));
                D1 = D1 + q;
            elseif(strcmp(Type,'Both'))
                p = real(-feval(f_mn_minus,m,n));
                S1 = S1 + p;
                q = real(1i.*(xi_m(m))./k_mn(m,n).*f_mn_plus(m,n));
                D1 = D1 + q;
            end
        end
     end
     S2 = S2 + S1;
     D2 = D2 + D1;
     % check status waitbar
     waitbar(i/steps,h,sprintf('Loading...%.2f%%',i/steps*100))
     i = i + 1;
end

% Force Coefficient
amppertesla = L2*w2/mew_0;

if(strcmp(Type,'Lift'))
    Force_lift = S2*amppertesla;
    Force_drag = 0;
elseif(strcmp(Type,'Drag'))
    Force_drag = D2*amppertesla;
    Force_lift = 0;
elseif(strcmp(Type,'Both'))
    Force_lift = S2*amppertesla;
    Force_drag = D2*amppertesla;
end

delete(h)

end