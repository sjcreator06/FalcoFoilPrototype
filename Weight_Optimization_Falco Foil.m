%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%_______________Weight Optimization______________%

% Find optimal weight to optimize induced drag and aerodynamic effeciency. 

%              © 2026 Falco Foil
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wing Parameters
MTOW = 8600;                         % Maximum Takeoff Weight (MTOW)
MWTOW = 11000;                       % Metamorphic Wing Takeoff Weight (MWTOW)
rho = 0.0012;                        % slug/ft^3 (Using Atmospheric Model at Crusie Altitude)
S = 225;                             % ft^2
V = 418;                             % ft/s

% Drag Polar Parameters
C_D_o_23018 = 0.007;                 % Parasatic Drag for NACA 23018
C_D_o_4418 = 0.006;                  % Parasatic Drag for NACA 4418
e = 0.8;                             % Oswald Efficiency
b = 44;                              % Span 
c = 5;                               % Chord
AR = b/c;                            % Aspect Ratio
k = 1 / (pi*AR*e);                   % Drag Polar Factor

% Effeciency Calculation for Plot Dataset
W = 1:1:50000;                         % Weight List
C_L = (2 .* W) / (rho * V^2 * S);      % Coefficient of Lift
C_D_23018 = C_D_o_23018 + k * C_L.^2;  % Coefficient of Drag for NACA 23018
C_D_4418 = C_D_o_4418 + k * C_L.^2;    % Coefficient of Drag for NACA 4418
E_23018 = C_L ./ C_D_23018;            % Effeciency for NACA 23018
E_4418 = C_L ./ C_D_4418;              % Effeciency for NACA 4418
[maxE_23018,index23018] = max(E);      % Max Effeciency for NACA 23018
[maxE_4418,index4418] = max(E);        % Max Effeciency for NACA 23018

% Effeciency Calculation for MTOW and MWTOW Points on Plot
C_L_MTOW = (2 * MTOW) / (rho * V^2 * S); 
C_D_MTOW_23018 = C_D_o_23018 + k * C_L_MTOW^2;  
E_MTOW_23018 = C_L_MTOW / C_D_MTOW_23018;               
C_D_MTOW_4418 = C_D_o_4418 + k * C_L_MTOW^2;  
E_MTOW_4418 = C_L_MTOW / C_D_MTOW_4418;

C_L_MWTOW = (2 * MWTOW) / (rho * V^2 * S); 
C_D_MWTOW_23018 = C_D_o_23018 + k * C_L_MWTOW^2;  
E_MWTOW_23018 = C_L_MWTOW / C_D_MWTOW_23018;
C_D_MWTOW_4418= C_D_o_4418 + k * C_L_MWTOW^2;  
E_MWTOW_4418 = C_L_MWTOW / C_D_MWTOW_4418;

% Effeciency Plot
subplot(1, 3, 1)
set(gcf, 'Color', [1 1 1])

plot(W,E_23018,LineWidth=2.0)
title("Efficiency vs Weight",'Color','k')
xlabel("Weight (lbs)",'Color','k')
ylabel("Efficiency",'Color','k')

hold on
plot(W,E_4418,LineWidth=2.0)

plot(MTOW,E_MTOW_23018, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,E_MWTOW_23018,"X",'MarkerSize', 20, LineWidth=2.0)
plot(W(index23018),maxE_23018,"X",'MarkerSize', 20, LineWidth=2.0)

plot(MTOW,E_MTOW_4418, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,E_MWTOW_4418,"X",'MarkerSize', 20, LineWidth=2.0)
plot(W(index4418),maxE_4418,"X",'MarkerSize', 20, LineWidth=2.0)

ax1 = gca; 
ax1.XAxis(1).Color = 'k'; 
ax1.YAxis(1).Color = 'k'; 
legend("23018 E Curve","4418 E Curve", ...
    "23018 MTOW","23018 MWTOW","23018 Maximum Effeciency", ...
    "4418 MTOW","4418 MWTOW","23018 Maximum Effeciency")

% Coefficient of Lift Plot
subplot(1, 3, 2)
plot(W,C_L,LineWidth=2.0)
title("Coefficient of Lift vs Weight",'Color','k')
xlabel("Weight (lbs)",'Color','k')
ylabel("Coefficient of Lift",'Color','k')
        
hold on
plot(MTOW,C_L_MTOW, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,C_L_MWTOW,"X",'MarkerSize', 20, LineWidth=2.0)

ax2 = gca; 
ax2.XAxis(1).Color = 'k'; 
ax2.YAxis(1).Color = 'k'; 
legend("CL Curve","MTOW","MWTOW")

% Coefficient of Drag Plot
subplot(1, 3, 3)
plot(W,C_D_23018,LineWidth=2.0)
title("Coefficient of Drag vs Weight",'Color','k')
xlabel("Weight (lbs)",'Color','k')
ylabel("Coefficient of Drag",'Color','k')

hold on
plot(W,C_D_4418,LineWidth=2.0)

plot(MTOW,C_D_MTOW_23018, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,C_D_MWTOW_23018,"X",'MarkerSize', 20, LineWidth=2.0)

plot(MTOW,C_D_MTOW_4418, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,C_D_MWTOW_4418,"X",'MarkerSize', 20, LineWidth=2.0)

ax3 = gca; 
ax3.XAxis(1).Color = 'k'; 
ax3.YAxis(1).Color = 'k'; 
legend("23018 CD Curve","4418 CD Curve","23018 MTOW","23018 MWTOW", ...
    "4418 MTOW","4418 MWTOW")
