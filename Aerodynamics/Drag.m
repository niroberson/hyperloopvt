function Fd = Drag(pod_v)
tube = load_spec('tube');
pod = load_spec('pod');
p = tube.p; %Pa
T = tube.T; % (K) Equilibrium tube temperature % http://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/20150000699.pdf page 13
R = 287.058;  %individual gas constant (J/kg*K)
ro = p/(R*T); % kg/m^ 2

w = pod.Wmax; % m width of pod
h = pod.Hmax; % m height of pod
A = w*h; % m^2 Frontal Area

% Drag equation
Cd = pod.Cd;
Fd = 0.5*ro*pod_v^2*Cd*A; % N
end