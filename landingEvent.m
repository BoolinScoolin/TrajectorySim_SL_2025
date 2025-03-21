function [value, isterminal, direction] = landingEvent(~, u)
% landingEvent - ODE solver event to detect landing
    value = u(5); % z-position
    isterminal = 1; % stop the integration when value = 0
    direction = -1; % only detect value = 0 when altitude is decreasing
end