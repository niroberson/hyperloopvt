clc;
clear all;

%Pr = 1.0342*10^7;
At = pi*(0.0045^2);
%At = 0.00006362;
k = 1.4;
R = 297;
Tt = 250;


figure, hold on
for i = 500:500:3000

       Pr = i*6894.76;

%       mdot = ((At*Pr)/sqrt(Tt))*(sqrt(k/R))*(((k+1)/2)^((k+1)/(2*(k-1))))

       Z_e = 1;
       rho0 = Pr/(Z_e*R*Tt);
       rhot = rho0*(2/(k+1))^(1/(k-1));
       Vt = sqrt(2*k/(k+1)*R*Tt); % = sqrt(k*R*Tt)
       mdott = rhot*At*Vt; % kg/s
       
     plot(Pr, mdott, 'o')
                    
end



