% Varies CD to try and match the provided apogee realApogee

tic
realApogee = 4119.22;  % ft
fsolve(@(cd) cdRootFindingInput(cd, motorFilename, rocket, mainParachute, drogueParachute, rail, wind, tspan, ic) - realApogee, rocket.cd)
toc

% Update this to use cost function