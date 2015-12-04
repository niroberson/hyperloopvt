% Script to perform aerodynamic analysis on CFD of a Hyperloop Pod

% Pod 2d prof
wp = 162.6;
hp = 91.4;

% Get a larger domain of the channel
hc = hp*6;
wc = hc*5;

% Actual domain size
wca = 3000;
hca = 500;
AR = wca / hca;

% Mesh 1
nh1 = 32;
nw1 = nh1*AR; 

% Mesh2
GR = 2;
nh2 = nh1*GR;
nw2 = nw1*GR;

% Mesh 3
nh3 = nh2*GR;
nw3 = nw2*GR;

% Fluent parameters
% Calculate the timestep
CFL = 1;
v = 223.52 ; %m/s % (500 MPH)

% Mesh1
h_min1 = 8.984070e-02;
del_t1 = CFL*sqrt(h_min1)/v;

% Mesh2
h_min2 = 4.121388e-02;
del_t2 = CFL*sqrt(h_min2)/v;

%Mesh3
h_min3 = 1.972654e-02;
del_t3 = CFL*sqrt(h_min3)/v;

% Mesh 4
h_min4 = 9.645519e-03;
del_t4 = CFL*sqrt(h_min4)/v;

A_front = (500-337.146)*(285.96-194.52);
A_front = A_front*0.75;

% Plot drag for each mesh
figure, hold on

% Read in Mesh1 Cd history
cd1 = importdata('cd-1-history');
plot(cd1.data(:,1), cd1.data(:,2), 'bl')

% Read in Mesh2 Cd History
cd2 = importdata('cd-2-history');
plot(cd2.data(:,1), cd2.data(:,2), 'r')

% Read in Mesh3 Cd History
cd3 = importdata('cd-3-history');
plot(cd3.data(:,1), cd3.data(:,2), 'gr')

% Read in Mesh4 Cd History
cd4 = importdata('cd-4-history');
plot(cd4.data(:,1), cd4.data(:,2), 'm')

% Find h1 h2 h3
h1 = hc*wc/(nh1*nw1);
h2 = hc*wc/(nh2*nw2);
h3 = hc*wc/(nh3*nw3);

% % Perform Grid Convergence Study
% GCI21_vec = [];
% GCI32_vec = [];
% 
% for i=1:1:numel(cd1.data(:,1))
%     phi1 = cd1.data(i,2);
%     phi2 = cd2.data(i,2);
%     phi3 = cd3.data(i,2);
%     [GCI21, GCI32, e_ext21, e_ext32] = grid_analysis(h_min3, h_min2, h_min1, phi3, phi2, phi1);
%     GCI21_vec(end+1) = GCI21;
%     GCI32_vec(end+1) = GCI32;
% end
% 
% figure, hold on
% % Plot the velocity profiles
% plot(cd3.data(:,1), cd3.data(:,2), 'gr')
% % Add the GCI values as error bars
% errorbar(cd3.data(:,1), cd3.data(:,2), GCI21_vec)
