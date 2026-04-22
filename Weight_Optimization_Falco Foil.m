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
C_D_o = 0.025;                       % Parasatic Drag
e = 0.8;                             % Oswald Efficiency
b = 44;                              % Span 
c = 5;                               % Chord
AR = b/c;                            % Aspect Ratio
k = 1 / (pi*AR*e);                   % Drag Polar Factor

% Effeciency Calculation for Plot Dataset
W = 1:1:50000;                       % Weight List
C_L = (2 .* W) / (rho * V^2 * S);    % Coefficient of Lift
C_D = C_D_o + k * C_L.^2;            % Coefficient of Drag
E = C_L ./ C_D;                      % Effeciency
[maxE,index] = max(E);               % Max Effeciency

% Effeciency Calculation for MTOW and MWTOW Points on Plot
C_L_MTOW = (2 * MTOW) / (rho * V^2 * S); 
C_D_MTOW = C_D_o + k * C_L_MTOW^2;  
E_MTOW = C_L_MTOW / C_D_MTOW;

C_L_MWTOW = (2 * MWTOW) / (rho * V^2 * S); 
C_D_MWTOW = C_D_o + k * C_L_MWTOW^2;  
E_MWTOW = C_L_MWTOW / C_D_MWTOW;

% Effeciency Plot
subplot(1, 3, 1)
set(gcf, 'Color', [1 1 1])

plot(W,E,LineWidth=2.0)
title("Efficiency vs Weight",'Color','k')
xlabel("Weight (lbs)",'Color','k')
ylabel("Efficiency",'Color','k')

hold on
plot(MTOW,E_MTOW, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,E_MWTOW,"X",'MarkerSize', 20, LineWidth=2.0)
plot(W(index),maxE,"X",'MarkerSize', 20, LineWidth=2.0)

ax1 = gca; 
ax1.XAxis(1).Color = 'k'; 
ax1.YAxis(1).Color = 'k'; 
legend("Efficiency Curve","MTOW","MWTOW","Maximum Effeciency")

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
plot(W,C_D,LineWidth=2.0)
title("Coefficient of Drag vs Weight",'Color','k')
xlabel("Weight (lbs)",'Color','k')
ylabel("Coefficient of Drag",'Color','k')

hold on
plot(MTOW,C_D_MTOW, "X", 'MarkerSize', 20, LineWidth=2.0)
plot(MWTOW,C_D_MWTOW,"X",'MarkerSize', 20, LineWidth=2.0)

ax3 = gca; 
ax3.XAxis(1).Color = 'k'; 
ax3.YAxis(1).Color = 'k'; 
legend("CD Curve","MTOW","MWTOW")
