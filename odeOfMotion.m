function dudt = odeOfMotion(t,u,filename,rocket,mainParachute,drogueParachute, railCant, railLength, wind, atm)
% odeOfMotion incorporates 3-DoF system of equations describing the motion
% of powered rocket flight. Assumes zero-lift, zero angle-of-attack
% Input Arguments:
%   u = 4x1 column vector
%       u(1) = x position
%       u(2) = x velocity
%       u(3) = y position
%       u(4) = y velocity
%       u(5) = z position
%       u(6) = z velocity
%   t = time
% Output Arguments
%   dudt = 4x1 column vector
%       dudt(1) = x velocity
%       dudt(2) = x acceleration
%       dudt(3) = y velocity
%       dudt(4) = y acceleration
%       dudt(5) = z velocity
%       dudt(6) = z acceleration

%% Read motor data
[time, thrust, motorMass] = motorReader(filename);
totalMass =  motorMass + rocket.mass_noMotor;

%% Adjust Main Catch Altitude
% Parachute terminal velocity
terminalDrogue = sqrt(2*rocket.mass_emptyMotor*9.81/(1.225*pi/4*drogueParachute.diameter^2*drogueParachute.cd));
% Time between main recovery event and main parachute catching
tcatch = 1.25;  % [s]; based on video recording with 20 ft cord to avbay
% Approximate altitude that main catches
mainCatch = mainParachute.deploy - terminalDrogue*tcatch;
[~, ~, density] = atmosphere(u(5), atm);

%% Calculate Drag magnitude
totalVelocity = sqrt( u(2)^2 + u(4)^2 + u(6)^2 );  % magnitude of total vehicle velocity
if (u(6) < -0.1 && u(5) < mainCatch)
    D = computeDrag(totalVelocity, density, mainParachute);
elseif u(6) < -0.1
    D = computeDrag(totalVelocity, density, drogueParachute);
elseif u(6) > 0.1
    D = computeDrag(totalVelocity, density, rocket);
else
    D = 0;
end

%% Define gravity
g = 9.81;  % [m s^-2]
if u(5) < 2  % 2 is arbitrary small number to signify that its AGL
    g = 0;  % don't want the rocket to fall through the ground  
end

%% Interpolation
T = interp1(time, thrust, t, 'linear', 0);
m = interp1(time, totalMass, t, 'linear', 'extrap');
w = interp1(wind(:,4), wind(:, 1:3), t, 'linear', 0);

%% Payload Deployment
% Gonna hard code this one
payloadMass = 0*77.4*0.0283495;  % mass of deploying payload
deploymentAltitude = 375/3.28084;  % descending altitude of payload deployment
deploymentTime = 63.753 + 4;

if t > deploymentTime && u(6) < -0.1
    m = m - payloadMass;
end


%% System of Equations

dudt = zeros(6,1); % Initialize output size

dudt(1) = u(2) + w(1);

dudt(3) = u(4) + w(2);

dudt(5) = u(6) + w(3);

%% Pitch / Yaw
% (Derived Quantities)
launchRodHeight = railLength*cos(railCant);  % launch rod height

if u(5) > launchRodHeight || u(6) < -0.1  % check if 'above launch rail' or 'descending'
    pitch = atan2( dudt(5) , sqrt( dudt(1)^2 + dudt(3)^2 ) );  % calculate pitch for 0 AoA
    yaw = atan2( dudt(3) , dudt(1) );  % calculate yaw for 0 AoA
else  % on launch rail
    pitch = pi/2 - railCant;  % rail buttons keep angular orientation constant
    yaw = 0;
end

dudt(2) = (T-D)*cos(pitch)*cos(yaw)/m;

dudt(4) = (T-D)*cos(pitch)*sin(yaw)/m;

dudt(6) = (T-D)*sin(pitch)/m - g;