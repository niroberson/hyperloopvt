function Fd = Drag(pod_v)
tube = load_spec('tube');
pod = load_spec('pod');
air = load_spec('air');
p = tube.p; %Pa
T = tube.T; % (K) Equilibrium tube temperature % http://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/20150000699.pdf page 13
R = air.R;  %individual gas constant (J/kg*K)
ro = p/(R*T); % kg/m^ 2 Air density

w = pod.Wmax; % m width of pod
h = pod.Hmax; % m height of pod
A = w*h; % m^2 Frontal Area

% Drag equation
Cd = 0.27;
Fd = 0.5*ro*pod_v^2*Cd*A; % N
end