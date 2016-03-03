clear all;
close all;
clc;


R = 5:0.25:8;
m = 1.5:0.2:4;

[r,Me]=meshgrid(R,m);

for i = 1:length(R)
    for j = 1:length(m)
        try
            I(i,j)=Impulse_optimization(r(i,j),Me(i,j));
        catch MException
            I(i,j) = 0;
        end
    end
end

figure
contour(r,Me,I)
xlabel('Throat Radius')
ylabel('Exit Mach Number')


