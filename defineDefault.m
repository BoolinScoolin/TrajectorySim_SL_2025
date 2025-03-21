% Defines everything necessary for simulation

% Define Motor
motorFilename = "AeroTech_L1940X.eng";
[motorTime, thrust, motorMass] = motorReader(motorFilename);

% Define Rocket
rocket.diameter = 5.525;  % cross-sectional area [in]
rocket.diameter = rocket.diameter*0.0254;  % convert to [m]
rocket.cd = 0.854244315795898;  % vehicle drag coefficient
rocket.cd = 0.605;
rocket.mass_noMotor = 588.82;  % vehicle mass with no motors [oz]
rocket.mass_noMotor = rocket.mass_noMotor*0.0283495;  % convert to [kg]
rocket.mass_emptyMotor = rocket.mass_noMotor + motorMass(end);  % vehicle mass with motor casing installed [kg]

% Define Drogue
drogueParachute.diameter = 28;  % drogue parachute diameter [in]
drogueParachute.diameter = drogueParachute.diameter*0.0254;  % convert to [m]
drogueParachute.cd = 1.48757688130922;  % drogue parachute drag coefficient
drogueParachute.cd = 0.93;

% Define Main 
mainParachute.diameter = 96;  % drogue parachute diameter [in]
mainParachute.diameter = mainParachute.diameter*0.0254;  % convert to [m]
mainParachute.cd = 1.70984057199697;  % drogue parachute drag coefficient
mainParachute.cd = 2.2;
mainParachute.deploy = 540;  % main parachute deployment altitude [ft]
mainParachute.deploy = mainParachute.deploy*0.3048;  % convert to [m]
mainParachute.shockcord = 20;  % main parachute shock cord length [ft]
mainParachute.shockcord = mainParachute.shockcord*0.3048;

% Define Launch Rail
rail.cant = 7;  % rail cant [degrees]
rail.cant = deg2rad(rail.cant);  % convert to [radians]
rail.length = 144;  % rail length [in]
rail.length = rail.length*0.0254;  % convert to [m]