%% Design for Hyperloop
close all;
clear all;

%% Select Paramters to Run Simulation With

%parameters = 'Hyperloop-Doubles';
%parameters = 'Hyperloop-Stilts';
parameters = 'Hyperloop-Brakes';
%parameters = 'Hyperloop-Lateral';
%parameters = 'Test-Rig';

coeff = 'Set2';

%% Global Constants
Jc = 0;
Jm = 0;
u0 = 4*pi*1e-7; % permeability of free space
PodWeight = 4500; % Pod weight (N)

%% Setup Simulation

vres = 1;
size = vfinal/vres;

F_lift = zeros(1,size);
F_drag = zeros(1,size);
n = zeros(1,size);
m = zeros(1,size);
o = zeros(1,size);
skin_depth = zeros(1,size);
i = 1;

for v = 0.1:vres:vfinal
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                 = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                      P,l,rho_track,d1,d2,...
                                                      coeff,profile,Jc,Jm);
    F_lift(1,i) = Force_y;
    F_drag(1,i) = Force_z;
    n(1,i) = LtD;
    m(1,i) = LtW;
    skin_depth(1,i) = skinDepth;
    weight = PodWeight;
    o(1,i) = (F_lift(1,i)-weight)/weight;
    i = i + 1;
end

fprintf('MagWidth: %d MagHeight: %d MagThickness: %d MagWeightLbs: %d MagMass: %d NumMagnets: %d MagCost: %d \r',...
        width,h,(tau/2),weightEstimate_lbs,weightEstimate_kg,numMagnets,costEstimate)
    
v = 0.1:vres:vfinal;
v_kmh = v*3.6;
v_mph = v*2.2;

%% Hyperloop Related Plots
if(strcmp(parameters,'Hyperloop-Doubles'))
    Payload = F_lift(1,130) - PodWeight - MagnetWeight;
    
    subplot(2,2,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 800])
    set(ax(1),'YTick',[0:100:800])
    set(ax(2),'YLim',[0 8])
    set(ax(2),'YTick',[0:1:8])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    if(strcmp(geometry,'Single'))
        xlabel(ax(1),'Velocity (m/s)')  % label x-axis
        ylabel(ax(1),'Drag Force (N)') % label left y-axis
        ylabel(ax(2),'Lift Force (kN)') % label right y-axis
        set(ax(1),'YLim',[0 20])
        set(ax(1),'YTick',[0:5:20])
        set(ax(2),'YLim',[0 20])
        set(ax(2),'YTick',[0:5:20])
        set(ax(1),'XLim',[0 135])
        set(ax(1),'XTick',[0:15:135])
        set(ax(2),'XLim',[0 135])
        set(ax(2),'XTick',[0:15:135])
        grid on;
    end
    
    subplot(2,2,2);
    [ax,p1,p2] = plotyy(v,((F_lift-weight)/1000),[0.1,vfinal],[Payload/1000,Payload/1000]);
    title('Usable Lift Force');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Usable Lift Force (kN)') % label left y-axis
    ylabel(ax(2),'Payload (kN)') % label right y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 8])
    set(ax(1),'YTick',[0:1:8])
    set(ax(2),'YLim',[0 8])
    set(ax(2),'YTick',[0:1:8])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    TeXString = texlabel('Usable_Force = F_lift - MagnetWeight');
    text(35,4,TeXString)
    TeXString2 = texlabel('Payload = F_lift - PodWeight - MagnetWeight');
    text(35,1,TeXString2)
    grid on;
    
    subplot(2,2,3);
    [ax,p1,p2]= plotyy(v,n,v,m);
    title('Lift/Drag and Lift/Weight Ratios');
    xlabel('Velocity (m/s)');
    ylabel(ax(1),'Lift/Drag'); % label left y-axis
    ylabel(ax(2),'Lift/Weight'); % label left y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 60])
    set(ax(1),'YTick',[0:10:60])
    set(ax(2),'YLim',[0 30])
    set(ax(2),'YTick',[0:5:30])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,4)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
 elseif(strcmp(parameters,'Hyperloop-Stilts'))
    Payload = 0;% F_lift(1,130) - PodWeight - MagnetWeight;
    
    subplot(2,2,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)')  % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 600])
    set(ax(1),'YTick',[0:100:600])
    set(ax(2),'YLim',[0 3])
    set(ax(2),'YTick',[0:0.5:3])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    if(strcmp(plot_setting,'Four-Stilts'))
        subplot(2,2,1);
        [ax,p1,p2] = plotyy(v,F_drag/1000,...
                        v,F_lift/1000,'plot','plot');
        title('Lift and Drag Forces');
        xlabel(ax(1),'Velocity (m/s)')  % label x-axis
        ylabel(ax(1),'Drag Force (kN)') % label left y-axis
        ylabel(ax(2),'Lift Force (kN)') % label right y-axis
        set(ax(1),'YLim',[0 8])
        set(ax(1),'YTick',[0:1:8])
        set(ax(2),'YLim',[0 8])
        set(ax(2),'YTick',[0:1:8])
        set(ax(1),'XLim',[0 135])
        set(ax(1),'XTick',[0:15:135])
        set(ax(2),'XLim',[0 135])
        set(ax(2),'XTick',[0:15:135])
        grid on;
    end
    
    subplot(2,2,2);
    [ax,p1,p2]= plotyy(v,n,v,m);
    title('Lift/Drag and Lift/Weight Ratios');
    xlabel('Velocity (m/s)');
    ylabel(ax(1),'Lift/Drag'); % label left y-axis
    ylabel(ax(2),'Lift/Weight'); % label left y-axis
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'YLim',[0 12])
    set(ax(1),'YTick',[0:2:12])
    set(ax(2),'YLim',[0 60])
    set(ax(2),'YTick',[0:10:60])
    set(ax(2),'XLim',[0 135])
    set(ax(2),'XTick',[0:15:135])
    grid on;
    
    subplot(2,2,3)
    plot(v,o);
    title('UsableLift/Weight Ratio');
    xlabel('Velocity(m/s)');
    grid on;
    
    gap = (F_lift-weight)/1000;
    subplot(2,2,4)
    [ax,p1,p2]= plotyy(v,gap,v,gap);
    set(ax(1),'XTick',[0:15:135])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'YLim',[0 8])
    set(ax(1),'YTick',[0:1:8])
    set(ax(2),'YLim',[0 8])
    set(ax(2),'YTick',[0:1:8])
    
 elseif(strcmp(parameters,'Test-Rig'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 10])
    set(ax(1),'YTick',[0:1:10])
    set(ax(2),'YLim',[0 10])
    set(ax(2),'YTick',[0:1:10])
    set(ax(1),'XLim',[0 50])
    set(ax(1),'XTick',[0:5:50])
    set(ax(1),'XLim',[0 50])
    set(ax(1),'XTick',[0:5:50])
    
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    grid on;
    
    if(strcmp(geometry,'Single'))
        set(ax(1),'YLim',[0 50])
        set(ax(1),'YTick',[0:10:50])
        set(ax(2),'YLim',[0 50])
        set(ax(2),'YTick',[0:10:50])
        set(ax(1),'XLim',[0 50])
        set(ax(1),'XTick',[0:5:50]) 
    end
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,(F_drag),...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 5000])
    set(ax(1),'YTick',[0:1000:5000])
    set(ax(2),'YLim',[0 5000])
    set(ax(2),'YTick',[0:1000:5000])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:10:135])
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
elseif(strcmp(parameters,'Hyperloop-Lateral'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,...
                        v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 500])
    set(ax(1),'YTick',[0:100:500])
    set(ax(2),'YLim',[0 500])
    set(ax(2),'YTick',[0:100:500])
    set(ax(1),'XLim',[0 135])
    set(ax(1),'XTick',[0:10:135])
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on; 
    
end

%figure('Name','Skin Depth');
%plot(v,skin_depth)
%title('Skin Depth');
%xlabel('Velocity (m)');
%ylabel('Skin Depth (m)');

