clear all

% Magnet Parameters (m):
tau = 0.1;    % pole pitch
l1 = 0.4;     % length of array
tau_m = 0.05; %length of signle magnet
t1 = 0.1;     % magnet thickness
w1 = .05      % width of single magnet
Br = 1.28;    % magnet remanence
q = 2;        % number of magnets in one pole pair

% Track Parameters:
l2 = 0.8;       % length of plate
t2 = 0.006;     % thickness of plate
w2 = 1.2;       % width of aluminum plate
sigma = 2.54E7; % conductivity of plate

% Air-gap Parameters:
d1 = 0.026;        % upper air gap
d2 = 0.032;        % lower air gap
mew_0 = 4*pi*1E-7; % permeability of free space
 
%y = -d1;
%z = w1/4;
%x = 0.35;
%z0 = 0.2;

B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q)

trident = @(y, z0, x, x0, z) (z-z0)./sqrt((x-x0).^2 + y.^2 + (z-z0));
By_integrand = @(x, y, z, x0) (trident(y,w2/2,x,x0,z) - trident(y,(-w2/2),x,x0,z)).*exp(1i*x0.*pi./tau)./((x-x0).^2 + y.^2);

By_xyz = @(x, y, z) (B0.*y./(2*pi)).*integral(@(x0)By_integrand(x,y,z,x0),(-l2/2),l2/2);

m = 1;
n = 1;

xi_m = 2*pi*m./l2;
k_n = 2*pi*n./w2;
k_mn = sqrt((xi_m).^2 + (k_n).^2);

C1_mn_s_integrand = @(x,z) By_xyz(x,-d1,z);
C1_mn_s = integral2(C1_mn_s_integrand,-1,1,-1,1) % If you comment this out, evrything before this works.

% IGNORE EVERYTHING UNDER THIS
%(1/(l2*w2))
%C1_mn_s = (1/(l2*w2)).*integral2(

%C1_mn_s_integrand = @(x,z) By_xyz(x,-d1,z).*exp(1i.*(xi_m.*x + k_n.*z));
%q = C1_mn_s_integrand(1,2)

 
% lambda = -0.5*v_y*mew*sigma;
% gamma_mn = sqrt(k_mn^2 - 1i*mew*sigma*(xi_m*v_x + k_n*v_z));
% beta_mn = sqrt(lambda.^2 + gamma_mn.^2);
% 
% U_mn = (lambda.^2 - (beta_mn + k_mn).^2).*exp(2*beta_mn*t2) - (lambda.^2 - (beta+mn - k_mn).^2);
% R1_mn = (lambda + beta_mn - k_mn).*(lambda - beta_mn - k_mn).*(1 - exp(2*beta_mn.*t2))./U_mn;
% R3_mn = (lambda + beta_mn + k_mn).*(lambda - beta_mn + k_mn).*(1 - exp(2*beta_mn.*t2))./U_mn;
% T_mn = @(y) -4*beta_mn.*k_mn.*exp(beta_mn.*t2).*exp(lambda.*(t2 + 2*y)./U_mn;
% 
% C1_mn_s = 
% C1_mn_r = R1_mn.*C1_mn_s + T_mn(-d1).*C3_mn_s;
% C3_mn_r = R3_mna.*C3_mn_s + T_mn(d2).*C1_mn_s;


% index = 1;
% for x = 0:0.01:1
%     By(index) = By_xyz(x,-d1,w1/4);
%     index = index + 1;
% end
% plot(real(By))

%index = 1;
% for x = -1:0.01:1
%     trident = @(x0, z0) (z-z0)./sqrt((x-x0).^2 + y^2 + (z-z0));
%     By_int = @(x0) (trident(x0,w2/2) - trident(x0,(-w2/2))).*exp(1i*x0.*pi/tau)./((x-x0).^2 + y^2);
%     By_int2 = integral(By_int,-.2,.2);
%     By_xyz = B0*y*(By_int2)/(2*pi);
%     By(index) = By_xyz;
%     index = index + 1;
% end
% x = -1:0.01:1;
% plot(x,real(By))
% 



