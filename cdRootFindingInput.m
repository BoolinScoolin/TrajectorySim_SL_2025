function apogee = cdRootFindingInput(cd, motorFilename, rocket, mainParachute, drogueParachute, rail, wind, tspan, ic)
% cdRootFindingInput: function used optimize apogee via controlling cd

rocket.cd = cd;

options = odeset('RelTol', 1e-4, 'Events', @apogeeEvent);
[~, u] = ode113(@(t,u) odeOfMotion(t,u,motorFilename,rocket,mainParachute,drogueParachute,rail.cant,rail.length,wind) , tspan, ic, options);

apogee = max(u(:,5));
apogee = apogee*3.28084;