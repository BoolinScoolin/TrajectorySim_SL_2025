function [value, isterminal, direction] = apogeeEvent(~, u)
% landingEvent - ODE solver event to detect landing
    value = atan2( u(4) , u(2) ) + 0.1;  % calculate pitch for 0 AoA
    isterminal = 1; % stop the integration when value = 0
    direction = -1; % only detect value = 0 when altitude is decreasing
end