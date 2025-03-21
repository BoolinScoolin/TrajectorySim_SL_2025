% Computes Fin Flutter velocity as defined by NACA Technical Note 4197
% (https://ntrs.nasa.gov/api/citations/19930085030/downloads/19930085030.pdf)
%
% Equation explored in Apogee Rockets "Peak of Flight" Issue 615
% (https://www.apogeerockets.com/education/downloads/Newsletter615.pdf)

% Initialize fin geometry

    % Input parameters
    c = 20.4;  % Root cord length [cm] (OpenRocket)
    tip_chord = 7.64;  % Fin tip chord length [cm] (OpenRocket)
    fin_h = 14.62;  % Fin height [cm] (OpenRocket)
    finThickness = 0.483;  % Fin thickness [cm] (OpenRocket)

    c = c/100;  % Convert to [m]
    tip_chord = tip_chord/100;  % Convert to [m]
    fin_h = fin_h/100;  % Convert to [m]
    finThickness = finThickness/100;  % Convert to [m]

    % Derived parameters
    s = (tip_chord+c)/2 * fin_h; % Fin area [m^2]
    A = fin_h^2/s;  % Fin aspect ratio
    lambda = tip_chord/c;  % fin taper ratio;

G = 4136854*1000;  % Fin shear modulus [Pa] (4136854 from https://www.apogeerockets.com/education/downloads/Newsletter615.pdf)

gamma = 1.4;  % ratio of specific heats (called 'kappa' in article)
R = 287;  % Specific gas constant [J kg^-1 K^-1]
p0 = 101325;  % ambient pressure at sea level standard
epsilon = 0.25;  % (distance of fin cg to fin quarter chord)/(full chord length)  (~0.25 for symmetric fin)
DN = 24*epsilon*gamma/pi*p0;

[temperature, pressure] = atmosphere(z(1:apogeeIndex));
speedOfSound = sqrt(gamma*R*temperature);

vf = speedOfSound .* sqrt((G)./( (DN*A^3)/((finThickness/c)^3*(A+2))*((lambda+1)/2)*(pressure/p0)));
Cvf = (vf - v(1:apogeeIndex))/max(vf);  % Normalized fin flutter velocity margin

%% Plot data using MATLAB
% plot(tspan(1:apogeeIndex),v(1:apogeeIndex), 'Color', '#F95300', 'LineWidth',2);
% hold on; grid on;
% plot(tspan(1:apogeeIndex), Cvf,'b','LineWidth',2)
% legend('Total Vehicle Velocity', 'Fin Flutter Velocity', 'Location', 'best', 'Interpreter', 'LaTeX')
% xlabel('Time $(\textnormal{s})$', 'Interpreter', 'LaTeX');
% ylabel('Velocity $\left(\frac{\textnormal{ft}}{\textnormal{s}}\right)$', 'Interpreter', 'LaTeX');

%% Plot data using matplotlib.pyplot
% Add pythonPlotter path
addpath('C:\Users\colin\Documents\USLI\TrajectorySim\plotter')

% Define pythonPlotter Inputs
indepVar{1} = tspan(1:apogeeIndex);
depVar{1} = Cvf(1:apogeeIndex);
axisLabel{1} = 'time [s]';
axisLabel{2} = 'Flutter Velocity Margin';
label_var{1} = '';

% Plot
pythonPlotter(indepVar, depVar, label_var, axisLabel)

% Remove pythonPlotter path
rmpath('C:\Users\colin\Documents\USLI\TrajectorySim\plotter')
