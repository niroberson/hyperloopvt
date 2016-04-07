% this code performs the triple integral by, for every combination of x and
% z, evaluating Bsy_top and Bsy_bot (this in itself is an integral), then
% multiplying this by an exponential to get the C_mn integrand/partial sum
% and adding up all of these partial sums
function [C1_s_int, C3_s_int] = C_1_3_integrationsManual(B0, tau, z0, ytop, ybot, xi, k, L1, L2, w2)
% note: region 1 is top of conductive plate, region 3 is bottom of plate
% note: integrand and partial sum are used interchangeably
x0Res = (L1/2)/100;
xRes = (L2/2)/100;
zRes = (w2/2)/100;
C1_s_int = 0;
C3_s_int = 0;
Bsy_top = 0;
Bsy_bot = 0;
for z = -w2/2:zRes:w2/2
    for x = -L2/2:xRes:L2/2  
        % in this loop, Bsy for both ytop and ybot are evaluated
        for x0 = -L1/2:x0Res:L1/2
            % def of psi from eqn 15, plus z0 has minus signs, vice versa
            psi_top_plusz0 = (z-z0)/sqrt((x-x0)^2 + ytop^2 + (z-z0));
            psi_top_minusz0 = (z+z0)/sqrt((x-x0)^2 + ytop^2 + (z+z0)); 
            psi_bot_plusz0 = (z-z0)/sqrt((x-x0)^2 + ybot^2 + (z-z0));
            psi_bot_minusz0 = (z+z0)/sqrt((x-x0)^2 + ybot^2 + (z+z0));
            % calculating Bsy by partial sums from eqn 13
            By_integrand_top_I = B0*ytop/(2*pi)*(psi_top_plusz0 - ...
                psi_top_minusz0)*exp(1i*x0*pi/tau)/((x-x0)^2 + ytop^2)*x0Res; 
            By_integrand_bot_III = B0*ybot/(2*pi)*(psi_bot_plusz0 - ...
                psi_bot_minusz0)*exp(1i*x0*pi/tau)/((x-x0)^2 + ybot^2)*x0Res;
            % summing up partial sums
            Bsy_top = Bsy_top + By_integrand_top_I;
            Bsy_bot = Bsy_bot + By_integrand_bot_III;
        end % end of x0 integral
        % evaulate C1_s and C2_s partial sums
        C1_s_integrand = Bsy_top*exp(-1i*(xi*x + k*z))*xRes*zRes;
        C3_s_integrand = Bsy_bot*exp(-1i*(xi*x + k*z))*xRes*zRes;
        % clear Bsy_top/Bsy_bot for use in next x
        Bsy_top = 0;
        Bsy_bot = 0;
        C1_s_int = C1_s_int + C1_s_integrand;
        C3_s_int = C3_s_int + C3_s_integrand;
    end % end of x integral
end % end of z integral
end