function wind = defineWind(wx,wy,wz,tspan)
% defineWind - defines array of wind speeds. Weighting factors
%   should be mean wind speeds in respective direction (I think?).
%   Surely theres a better way to do this using statistics/sensors.
%
% Input Arguments:
%   wx - wind weight factor in x-dir
%     float
%   wy - wind weight factor in y-dir
%     float
%   wz - wind weight factor in z-dir
%     float
%   tspan - max time span of flight simulation
%     vector
% Output Arguments
%   wind - wind speeds
%          columns 1,2,3 -> computed wind in x,y,z respectively
%          column 4 = tspan
%     length(tspan) x 4 array

w = zeros(range(tspan),4);
w(:,1) = rand(range(tspan),1).*(w(:,1) + wx);
w(:,2) = rand(range(tspan),1).*(w(:,2) + wy);
w(:,3) = rand(range(tspan),1).*(w(:,3) + wz);

wind = imresize(w, [length(tspan), 3], 'bilinear'); % Resizes to match tspan size

wind(:,4) = tspan;  % make fourth column tspan
