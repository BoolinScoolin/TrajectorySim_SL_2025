function [temperature, pressure, density] = atmosphere(altitudeAGL, atmosphericData)
% function [temperature, pressure] = atmosphere(altitudeAGL)
% Interpolates atmospheric temperature and pressure at input altitudes
% Inputs
%   altitude - n x 1 vector containing altitude values AGL [m]
% Outputs
%   temperature - n x 1 vector containing corresponding temperature values [degK]
%   pressure - n x 1 vector containing corresponding pressure values [Pa]

% Pulls elevation at coordinates
altitudeASL = altitudeAGL + atmosphericData.elevation;  % convert AGL to ASL

%% Model
temperature = 273.15 + interp1(atmosphericData.heights, atmosphericData.temperatures, altitudeASL, 'linear', 'extrap');
pressure = exp(interp1(atmosphericData.heights, log(atmosphericData.pressures), altitudeASL, 'linear', 'extrap'));
density = pressure ./ (287*temperature);


