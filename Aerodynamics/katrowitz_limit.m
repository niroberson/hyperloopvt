Atube = 2.2217; %m^2 3443.71; % in^2
Abypass = @(Mpod) Mpod.*Atube.*(1.2005./(1+0.2005.*Mpod.^2)).^(-2.9938);
Mpod = 0:0.01:1;
Ttube = 300;
Rair = 287;
kair = 1.4;
c = sqrt(kair*Rair*Ttube);
Abypass1 = Abypass(Mpod);
Apod = Atube - Abypass1;
figure, plot(Mpod*c, Apod/Atube)
xlabel('Pod Velocity (m/s)')
ylabel('Area of Pod / Area of Tube')