%Checks if titledlayout already exist and if it doesn't make it. 
%Using titledlayout means you can adjust spacing between subplots so they don't
%overlap. Using just subplots means you can't adjust the spacing without
%manually inputting there location 

Layout = findobj(gcf, 'Type', 'tiledlayout');
if isempty(Layout)
    tiledlayout(4, 6, 'TileSpacing', 'compact', 'Padding', 'compact');
end

%time in myr
time = state.time(:,1) /1e6 ;

% Set x-axis limit for each subplot
Start_Time = [-4e3 0] ;

% Plot each subplot - reduces the lines of code as many things in common 
for i = 1:22
    ax = nexttile(i);
    
    box on;
    
    switch i
        case 1
            % Plot Atmospheric O2
            semilogy(time, state.O2_A/3.7e19, 'LineWidth', 1.5);
            title('Atmospheric O2 PAL');
            ylabel("O2 (PAL)");
            hold on 

        case 2
            % Plot Oxidative Weather
            semilogy(time, state.Atmos_Weather, 'LineWidth', 1.5);
            title('Oxidative Weathering');
            ylabel("Weathering (mol/yr)");
            hold on 

        case 3
            % Plot Reduced Gas flux 
            semilogy(time, state.FrgfO2, 'LineWidth', 1.5);
            title('Reduced Gas Flux');
            ylabel("Gas flux (mol/yr)");
            hold on 

        case 4
            % Plot Deep ocean O2
            semilogy(time, state.O2_DP/2.21e17, 'LineWidth', 1.5);
            title('Deep Ocean O2 POL');
            ylabel(" O2 (POL)");
            hold on 

        case 5 
            % Plot River Phosphorous 
            semilogy(time,state.SRP_River,'LineWidth',1.5);
            title('River Phosphorous');
            ylabel(" P (mol/yr)");
            hold on 

         case 6
            % Total Phos Deep
            semilogy(time,state.SRP_DP,'LineWidth',1.5);
            title('P Deep');
            ylabel(" P (mol/yr)");
            hold on

        case 7
            % Total Reactive Phosphorus Burial
            hold on 
            %p1 = semilogy(time,state.Prox_Preac_Burial,'LineWidth',1.5, 'color','#b51963');
            %p2 = semilogy(time,state.Dist_Preac_Burial,'LineWidth',1.5,'color','#5ba300');
            p3 = semilogy(time,state.Deep_Preac_Burial,'LineWidth',1.5);
            title({'Phosphorus'; 'Burial'});
            ylabel(" P (mol/yr)");
            hold on
           
    
        case 8 
            % C:P de
            hold on
            %plot(time,state.CP_Prox,'LineWidth',1.5,'color','#b51963');
            %plot(time,state.CP_Dist,'LineWidth',1.5,'color','#5ba300');
            plot(time,state.CP_Deep,'LineWidth',1.5);
            title('C:P');
            ylabel("C:P");
            hold on 
           
        case 9 
            % Fraction of anoxia distal
            plot(time,state.fanoxicdist,'LineWidth',1.5);
            title('Fraction of Anoxia Distal ');
            ylabel("Fraction of Anoxia Distal")
            hold on 
        case 10 
            % Fraction of anoxia proximal
            plot(time,state.fanoxicprox,'LineWidth',1.5);
            title('Fraction of Anoxia Proximal ');
            ylabel("Fraction of Anoxia Proximal")
            hold on
             
         case 11
            % Plot C:P Anoxia
            plot(time, state.CPanoxic, 'LineWidth', 1.5);
            title('C:P Anoxia Deep');
            ylabel("C:P");
            hold on 

        case 12
            % Plot Inorganic Carbon Reservoir
            semilogy(time,state.IC_Reservoir,'LineWidth',1.5);
            title({'Inorganic'; 'carbon'});
            ylabel("Inorganic Carbon (mol/yr)");
            hold on 

        case 13 
            % Plot Inorganic Carbon isotope 
            plot(time,state.IC_Isotope,'LineWidth',1.5);
            title({'Inorganic'; 'carbon isotope'});
            ylabel("Carbon (mol/yr)");
            hold on 

        case 14 
            % Plot total organic carbon
            semilogy(time,state.forg,'LineWidth',1.5);
            title({'Fraction of burial' ;'that is organic'});
            ylabel("Fraction of burial");
            hold on 

        case 15 
            % Plot Total organic carbon burial
            semilogy(time,state.Fmocb,'LineWidth',1.5);
            title({'Total Organic carbon' ; 'Burial'});
            ylabel("Carbon Burial (mol/yr)");
            hold on 

        case 16 
            % Total POC burial
            semilogy(time,state.Total_POC_Burial,'LineWidth',1.5);
            title('Total POC burial');
            ylabel("POC burial (mol/yr)");
            hold on 

        case 17
            % Plot Atmospheric CO2
            semilogy(time,state.CO2atm,'LineWidth',1.5)
            title('Atmospheric CO2');
            ylabel("CO2 (atm)");
            hold on 

        case 18
            % Exposed continental landmass
            plot(time,state.EXPOSED,'LineWidth',1.5);
            title({'Exposed continental' ; 'landmass'});
            ylabel("Exposed landmass");
            hold on 

        case 19         
            % Carbonate carbon reservoir relative to present
            semilogy(time,state.Carbonate_Reservoir,'LineWidth',1.5);
            title({'Carbonate carbon reservoir'; 'relative to present'});
            ylabel({"Carbonate reservoir"; "relative to present"});
            hold on 

        case 20 
            % Plot Degassing rate relative to present
            plot(time,state.Degas_Rate,'LineWidth',1.5);
            title({'Degassing rate' ;'relative to present'});
            ylabel({"Rate relative"; "to present"});
            hold on 

        case 21
            % Plot Temperature
            plot(time,state.GAST-273,'LineWidth',1.5);
            title({'Global average'; 'surface temperature'});
            ylabel("Temperature (C)");
            hold on 

        case 22
            % Plot land plant weathering enhancement
            plot(time, state.fbiota, 'LineWidth', 1.5);
            title({'Land Plant'; 'Weathering Enhancement'});
            ylabel({"Land plant"; "enhancement"});
            hold on 
        
         % case 23
         %     plot C_Burial Line
         %     plot(time, state.C_Burial,'LineWidth',1.5)
         %     title('C Burial')
         %     ylabel('C Burial enhancement')
         %     hold on

    end
    
    ax.LineWidth = 0.75;
    ax.TickLength = [0.02, 0.02];
    xlim(Start_Time) %x axis limit - common for all plots

    % Only add x-axis labels on the bottom row 
    if i <= 15 % All plots except the last row
        ax.XTickLabel = []; % Hide x-tick labels for non-bottom-row subplots
    else
        xlabel('Time (Ma)', 'FontSize', 8); % Only show x-label on bottom row
    end
end

% ax_legend = nexttile(22, [1 1]); % Position the legend in the 22nd tile
% lgd = legend(ax_legend, [p1, p2, p3], {'Proximal', 'Distal', 'Deep'}, 'Location', 'best');
% lgd.FontSize = 12;
% lgd.Title.String = 'Legend' ;
% ldg.Title.Fontweight = 'bold';
% axis off;

% figure 
% plot(time, state.O2_DP/2.21e17, 'LineWidth', 1.5);
% title('Deep Ocean O2 POL');
% ylabel(" O2 (POL)");
% xlabel("Time (Ma)")
% xlim(Start_Time)
% hold on 