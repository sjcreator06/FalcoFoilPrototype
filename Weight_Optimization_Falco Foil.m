%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%_______________Weight Optimization______________%

% Find optimal weight to optimize induced drag and aerodynamic effeciency. 

%              © 2026 Falco Foil
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Wing Parameters
MTOW = 8600;                         % Maximum Takeoff Weight (MTOW)
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

% Effeciency Calculation
W = 1:1:50000;                       % Weight List
C_L = (2 .* W) / (rho * V^2 * S);    % Coefficient of Lift
C_D = C_D_o + k * C_L.^2;            % Coefficient of Drag
E = C_L ./ C_D;                      % Effeciency

% Effeciency Plot
subplot(1, 3, 1)
plot(W,E,LineWidth=2.0)
title("Efficiency vs Weight")
xlabel("Weight (lbs)")
ylabel("Efficiency")

hold on
MTOWList = MTOW*ones(1,length(W));
MTOW_Vertical = linspace(0,15,length(W));
plot(MTOWList,MTOW_Vertical,LineWidth=2.0)

legend("Efficiency Curve","MTOW")

% Coefficient of Lift Plot
subplot(1, 3, 2)
plot(W,C_L,LineWidth=2.0)
title("Coefficient of Lift vs Weight")
xlabel("Weight (lbs)")
ylabel("Coefficient of Lift")

hold on
MTOWList = MTOW*ones(1,length(W));
MTOW_Vertical = linspace(0,2.5,length(W));
plot(MTOWList,MTOW_Vertical,LineWidth=2.0)

legend("CL Curve","MTOW")

% Coefficient of Drag Plot
subplot(1, 3, 3)
plot(W,C_D,LineWidth=2.0)
title("Coefficient of Drag vs Weight")
xlabel("Weight (lbs)")
ylabel("Coefficient of Drag")

hold on
MTOWList = MTOW*ones(1,length(W));
MTOW_Vertical = linspace(0,0.25,length(W));
plot(MTOWList,MTOW_Vertical,LineWidth=2.0)

legend("CD Curve","MTOW")