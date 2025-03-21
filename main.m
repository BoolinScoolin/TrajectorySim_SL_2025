% max time span of flight simulation
tspan = linspace(0, 110, 1000)';

% Atmosphere
latitude = 34.7;  % geocentric latitude of launch [deg]
longitude = -86.6;  % Earth-centered longitude of launch [deg]
localtime = 14;  % hour of launch (24 hour clock, EST)
atm = defineAtmosphere(latitude, longitude, localtime);  % 

% wind
wind = defineWind(0,0,0,tspan);

% Initial Conditions
ic = [0 0 0 0 1.2446 0]';  % [x-position x-velocity y-position y-velocity z-position z-velocity ]'  
% (technically the center of mass is above ground level)

% Solver
try
options = odeset('RelTol', 1e-4, 'Events', @landingEvent);
tic
[t, u] = ode113(@(t,u) odeOfMotion(t,u,motorFilename,rocket,mainParachute,drogueParachute,rail.cant,rail.length,wind,atm) , tspan, ic, options);
%[t, u] = rk45(@(t,u) odeOfMotion(t,u,motorFilename,rocket,mainParachute,drogueParachute,rail.cant,rail.length,wind,atm), tspan(1), tspan(end), ic, 1e-8);
%[t, u] = rk4(@(t,u) odeOfMotion(t,u,motorFilename,rocket,mainParachute,drogueParachute,rail.cant,rail.length,wind,atm), tspan(1), tspan(end), ic, 0.01);
toc
catch
    error("Try running ""define""")
end

%% Organize Data
% Extract varibles
x = u(:,1);  % x distance  ( x is initial launch direction )
vx = u(:,2);  % x velocity
y = u(:,3);  % y distance  ( right of initial launch direction)
vy = u(:,4);  % y velocity
z = u(:,5);  % altitude
vz = u(:,6);  % z velocity
v = sqrt(vx.^2+vy.^2+vz.^2);  % total velocity

% convert to [ft]
x_ft = x*3.28084;  % x distance  ( x is initial launch direction )
vx_ft = vx*3.28084;  % x velocity
y_ft = y*3.28084;  % y distance  ( right of initial launch direction)
vy_ft = vy*3.28084;  % y velocity
z_ft = z*3.28084;  % altitude
vz_ft = vz*3.28084;  % z velocity
v_ft = sqrt(vx.^2+vy.^2+vz.^2)*3.28084;  % total velocity

% Calculate pitch and yaw values
pitch = atan2( vz , sqrt( vx.^2 + vy.^2 ) );  % calculate pitch for 0 AoA
yaw = atan2( vy , vx );

% Apogee Index
apogeeIndex = find(pitch < 0 & t > motorTime(end), 1);
apogeeTime = t(apogeeIndex);

mainIndex = find(z<mainParachute.deploy & vz < 0, 1);
mainTime = t(mainIndex);

% Compute atmospheric data from API
[temperature, pressure, density] = atmosphere(z, atm);
speedOfSound = sqrt(1.4*287*temperature);
Mach = v./speedOfSound;