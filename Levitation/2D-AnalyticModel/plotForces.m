function plotForces(parameters,vres,vfinal,F_drag,F_lift,n,m,skin_depth,l,...
                    weight,skin,profile,d1,d2)


plot_setting = 'Four-Stilts';
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
    
    subplot(1,2,1);
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
        subplot(1,2,1);
        %[ax,p1,p2] = plotyy(v,F_drag/1000,...
        %                v,F_lift/1000,'plot','plot');
        plot(v,F_drag/1000)
        hold on
        plot(v,F_lift/1000)
        title('Lift and Drag Forces');
        xlabel('Velocity (m/s)');
        ylabel('Force (kN)');
        legend('Drag','Lift');
        axis([0 130 0 5])
%         xlabel(ax(1),'Velocity (m/s)')  % label x-axis
%         ylabel(ax(1),'Drag Force (kN)') % label left y-axis
%         ylabel(ax(2),'Lift Force (kN)') % label right y-axis
%         set(ax(1),'YLim',[0 8])
%         set(ax(1),'YTick',[0:1:8])
%         set(ax(2),'YLim',[0 8])
%         set(ax(2),'YTick',[0:1:8])
%         set(ax(1),'XLim',[0 135])
%         set(ax(1),'XTick',[0:15:135])
%         set(ax(2),'XLim',[0 135])
%         set(ax(2),'XTick',[0:15:135])
%         grid on;
%      
    end
    
    subplot(1,2,2);
    plot(v,n)
    hold on;
    plot(v,m)
    title('Lift/Drag and Lift/Weight Ratios');
    xlabel('Velocity (m/s)');
    ylabel('Ratio');
    legend('Lift/Drag', 'Lift/Weight');
%     ylabel(ax(1),'Lift/Drag'); % label left y-axis
%     ylabel(ax(2),'Lift/Weight'); % label left y-axis
%     set(ax(1),'XLim',[0 135])
%     set(ax(1),'XTick',[0:15:135])
%     set(ax(1),'YLim',[0 12])
%     set(ax(1),'YTick',[0:2:12])
%     set(ax(2),'YLim',[0 60])
%     set(ax(2),'YTick',[0:10:60])
%     set(ax(2),'XLim',[0 135])
%     set(ax(2),'XTick',[0:15:135])
    grid on;
    
    %subplot(2,2,3)
    %plot(v,o);
    %title('UsableLift/Weight Ratio');
    %xlabel('Velocity(m/s)');
    %grid on;
    
    %gap = (F_lift-weight)/1000;
    %subplot(2,2,4)
    %[ax,p1,p2]= plotyy(v,gap,v,gap);
    %set(ax(1),'XTick',[0:15:135])
    %set(ax(1),'XLim',[0 135])
    %set(ax(1),'YLim',[0 8])
    %set(ax(1),'YTick',[0:1:8])
    %set(ax(2),'YLim',[0 8])
    %set(ax(2),'YTick',[0:1:8])
    
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
    
%     if(strcmp(profile,'Single'))
%         set(ax(1),'YLim',[0 50])
%         set(ax(1),'YTick',[0:10:50])
%         set(ax(2),'YLim',[0 50])
%         set(ax(2),'YTick',[0:10:50])
%         set(ax(1),'XLim',[0 50])
%         set(ax(1),'XTick',[0:5:50]) 
%     end
%     
%     subplot(2,1,2);
%     plot(v,n);
%     title('Lift/Drag Ratio');
%     xlabel('Velocity (m/s)');
%     grid on;
    
elseif(strcmp(parameters,'Hyperloop-Brakes'))
    subplot(2,1,1);
%     [ax,p1,p2] = plotyy(v,(F_drag),...
%                         v,F_lift,'plot','plot');
%     title('Lift and Drag Forces');
%     xlabel(ax(1),'Velocity (m/s)') % label x-axis
%     ylabel(ax(1),'Drag Force (N)') % label left y-axis
%     ylabel(ax(2),'Lift Force (N)') % label right y-axis
%     set(ax(1),'YLim',[0 5000])
%     set(ax(1),'YTick',[0:1000:5000])
%     set(ax(2),'YLim',[0 5000])
%     set(ax(2),'YTick',[0:1000:5000])
%     set(ax(1),'XLim',[0 135])
%     set(ax(1),'XTick',[0:10:135])
    %TeXString = texlabel('d1 = 10mm, d2 = 15mm');
    %text(20,25,TeXString)
    plot(v,F_drag)
    hold on;
    plot(v,F_lift)
    xlabel('Velocity (m/s)');
    ylabel('Force (N)');
    legend('Drag','Normal');
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
elseif(strcmp(parameters,'Hyperloop-Hybrid'))
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
    plot(v,F_drag)
    hold on;
    plot(v,F_lift)
    xlabel('Velocity (m/s)');
    ylabel('Force (N)');
    legend('Drag','Normal');
    title('Lift and Drag Forces');
    grid on;
    
    subplot(2,1,2);
    plot(v,n);
    ylabel('Ratios');
    xlabel('Velocity (m/s)');
    grid on; 
    hold on
    
    plot(v,m)
    ylabel('Ratio');
    legend('Lift/Drag','Lift/Weight')
    
end

%% Plot Paper Replicas

if(strcmp(parameters,'3D-Final'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v_kmh,(F_drag)/1000,...
                        v_kmh,(F_lift)/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 5])
    set(ax(1),'YTick',[0:1:5])
    set(ax(2),'YLim',[0 50])
    set(ax(2),'YTick',[0:10:50])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
    
%     if(strcmp(profile,'Brakes'))
%         title('Lift and Drag Forces');
%         xlabel(ax(1),'Velocity (km/h)') % label x-axis
%         ylabel(ax(1),'Drag Force (kN)') % label left y-axis
%         ylabel(ax(2),'Lift Force (kN)') % label right y-axis
%         set(ax(1),'YLim',[0 1000])
%         set(ax(1),'YTick',[0:200:1000])
%         set(ax(2),'YLim',[0 100])
%         set(ax(2),'YTick',[0:20:100])
%         set(ax(1),'XLim',[0 150])
%         set(ax(1),'XTick',[0:30:150])
%         grid on;
%     end
    
    subplot(3,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
    subplot(3,1,3)
    plot(v_kmh,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
elseif(strcmp(parameters,'3D-Initial'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 500])
    set(ax(1),'YTick',[0:100:500])
    set(ax(2),'YLim',[0 5000])
    set(ax(2),'YTick',[0:1000:5000])
    set(ax(1),'XLim',[0 150])
    set(ax(1),'XTick',[0:30:150])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;

elseif(strcmp(parameters,'3D-Experimental'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,...
                        v_kmh,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 1500])
    set(ax(1),'YTick',[0:500:1500])
    set(ax(2),'YLim',[0 1500])
    set(ax(2),'YTick',[0:500:1500])
    set(ax(1),'XLim',[0 25])
    set(ax(1),'XTick',[0:5:25])
    grid on;

    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Fig4'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,...
                        v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 140])
    set(ax(1),'YTick',[0:20:140])
    set(ax(2),'YLim',[0 1.4])
    set(ax(2),'YTick',[0:0.2:1.4])
    set(ax(1),'XLim',[0 200])
    set(ax(1),'XTick',[0:50:200])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Fig7'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 140])
    set(ax(1),'YTick',[0:20:140])
    set(ax(2),'YLim',[0 1.4])
    set(ax(2),'YTick',[0:0.2:1.4])
    set(ax(1),'XLim',[0 200])
    set(ax(1),'XTick',[0:50:200])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Second-2D'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,...
                        v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 2])
    set(ax(1),'YTick',[0:0.5:2])
    set(ax(2),'YLim',[0 6])
    set(ax(2),'YTick',[0:1:6])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(3,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
    subplot(3,1,3)
    plot(v_kmh,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
elseif(strcmp(parameters,'Third-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 1])
    set(ax(1),'YTick',[0:0.2:1])
    set(ax(2),'YLim',[0 3])
    set(ax(2),'YTick',[0:0.5:3])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Fourth-2D'))
    subplot(2,1,1);
    [ax,p1,p2] = plotyy(v_kmh,F_drag/1000,v_kmh,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (km/h)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 2])
    set(ax(1),'YTick',[0:0.5:2])
    set(ax(2),'YLim',[0 2])
    set(ax(2),'YTick',[0:0.5:2])
    set(ax(1),'XLim',[0 250])
    set(ax(1),'XTick',[0:50:250])
    grid on;
    
    subplot(2,1,2);
    plot(v_kmh,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (km/h)');
    grid on;
    
elseif(strcmp(parameters,'Magplane'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag/1000,v,F_lift/1000,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (kN)') % label left y-axis
    ylabel(ax(2),'Lift Force (kN)') % label right y-axis
    set(ax(1),'YLim',[0 100])
    set(ax(1),'YTick',[0:10:100])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:10:100])
    set(ax(1),'XLim',[0 60])
    set(ax(1),'XTick',[0:10:60])
    grid on;
    
    subplot(3,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
    subplot(3,1,3)
    plot(v,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');

elseif(strcmp(parameters,'Brakes-Paper'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 100])
    set(ax(1),'YTick',[0:20:100])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:20:100])
    set(ax(1),'XLim',[0 40])
    set(ax(1),'XTick',[0:5.5:40])
    grid on;
    
    subplot(3,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
    subplot(3,1,3)
    plot(v,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
elseif(strcmp(parameters,'Halbach-Brakes'))
    subplot(3,1,1);
    [ax,p1,p2] = plotyy(v,F_drag,v,F_lift,'plot','plot');
    title('Lift and Drag Forces');
    xlabel(ax(1),'Velocity (m/s)') % label x-axis
    ylabel(ax(1),'Drag Force (N)') % label left y-axis
    ylabel(ax(2),'Lift Force (N)') % label right y-axis
    set(ax(1),'YLim',[0 35])
    set(ax(1),'YTick',[0:5:35])
    set(ax(2),'YLim',[0 100])
    set(ax(2),'YTick',[0:20:100])
    set(ax(1),'XLim',[0 70])
    set(ax(1),'XTick',[0:14:70])
    grid on;
    
    subplot(3,1,2);
    plot(v,n);
    title('Lift/Drag Ratio');
    xlabel('Velocity (m/s)');
    grid on;
    
    subplot(3,1,3)
    plot(v,m);
    title('Lift/Weight Ratio');
    xlabel('Velocity(m/s)');
    
elseif(strcmp(parameters,'Test-Rig2'))
    figure, hold on;
    %[ax,p1,p2] = plotyy(v,F_drag,v,F_lift,'plot','plot');
    if strcmp(profile,'Single')
        title('Repulsion and Drag Forces - Levitation');
        str = sprintf('Air Gap: %0.1f (mm)',d1*1000);
    elseif strcmp(profile,'Double')
        title('Repulsion and Drag Forces - Lateral Stability');
        str = sprintf('Air Gap: %0.1f (mm), %0.1f (mm)',d1*1000,d2*1000);
    elseif strcmp(profile,'Brakes')
        title('Repulsion and Drag Forces - Braking');
        str = sprintf('Air Gap: %0.1f (mm), %0.1f (mm)',d1*1000,d2*1000);
        F_lift = -F_lift;
    end
%     xlabel(ax(1),'Velocity (m/s)') % label x-axis
%     ylabel(ax(1),'Drag Force (N)') % label left y-axis
%     ylabel(ax(2),'Lift Force (N)') % label right y-axis
%     %set(ax(1),'YLim',[0 5000])
%     %set(ax(1),'YTick',[0:1000:5000])
%     %set(ax(2),'YLim',[0 5000])
%     %set(ax(2),'YTick',[0:1000:5000])
%     set(ax(1),'YLim',[0 400])
%     set(ax(1),'YTick',[0:50:400])
%     set(ax(2),'YLim',[0 400])
%     set(ax(2),'YTick',[0:50:400])
%     set(ax(1),'XLim',[0 25])
%     set(ax(1),'XTick',[0:5:25])
    dim = [0.2 0.5 0.6 0.4];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
    plot(v,F_drag);
    plot(v,F_lift);
    xlabel('Velocity (m/s)');
    ylabel('Force (N)');
    legend('Drag','Lift');
    grid on;
    
%     subplot(3,1,2);
%     plot(v,n);
%     title('Lift/Drag Ratio');
%     xlabel('Velocity (m/s)');
%     axis([0 25 0 4])
%     grid on;
%     
%     subplot(3,1,3)
%     plot(v,m);
%     title('Lift/Weight Ratio');
%     xlabel('Velocity(m/s)');
%     axis([0 25 0 12])
    
end

if(strcmp(skin,'plot'))
    figure('Name','Skin Depth');
    plot(v,skin_depth*1000)
    title('Skin Depth');
    xlabel('Velocity (m)');
    ylabel('Skin Depth (mm)');
    axis([0 50 0 35])
    hold on
    plot([0,50],[l*1000,l*1000]);
end

%figure;

F_lift;
Mass_pod = 400;
F_pod = Mass_pod*9.81;
F_lift - F_pod;
%plot(v,F_drag - F_pod)
%plot(v,F_lift - F_pod)
%axis([0 20 0 4000])
%title('Levitation Force - Pod Force (including magnets) ');



