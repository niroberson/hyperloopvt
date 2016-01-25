T = 300;
k = 1.4;
R = 287;
v_pod = 300;

M = v_pod/sqrt(k*R*T)
% KL = Abypass/Atube
KL = ((k-1)/(k+1))^(1/2)*((2*k)/(k+1))^(1/(k-1))*(1+(2/(k-1))*(1/M^2))^(1/2)*(1-(k-1)/(2*k)*1/M^2)^(1/(k-1));

Atube = (1.79324/2)^2;
Abypass = KL*Atube