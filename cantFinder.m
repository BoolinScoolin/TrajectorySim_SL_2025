% Varies Cant to reach desired apogee
desiredApogee = 4700;  % ft
tic
options = optimset('TolFun', 1e-4);
idealCant = fzero(@(cant) cantRootFindingInput(cant, motorFilename, rocket, mainParachute, drogueParachute, rail, wind, tspan, ic) - desiredApogee, [0 deg2rad(10)], options);
rad2deg(idealCant)
toc

% Update using cost function