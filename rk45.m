function [t, A] = rk45(diffyq, t0, tf, ic, allowedErr)
% Uses 4th order runga-kutta numerical integration on given system of
% differential equations
%
% Input Arguments
%   diffyq  -   vector of length N containing system of first order 
%               differential equations expressed as vector
%   t0      -
%   tf      -
%   ic      -   vector of length N containing an initial condition for 
%               each of the differential equations
%
% Output Arguments
%   A       -   M by N Array containing the integrated values
%
% Colin Riba

% Runge-Kutta-Fehlberg Butcher Tableu (Wikipedia)
c2 = 1/4;
c3 = 3/8;
c4 = 12/13;
c5 = 1;
c6 = 1/2;

a21 = 1/4;
a31 = 3/32; a32 = 9/32;
a41 = 1932/2197; a42 = -7200/2197; a43 = 7296/2197;
a51 = 439/216; a52 = -8; a53 = 3680/513; a54 = -845/4104;
a61 = -8/27; a62 = 2; a63 = -3544/2565; a64 = 1859/4104; a65 = -11/40;

b1 = 16/135; b2 = 0; b3 = 6656/12825; b4 = 28561/56430; b5 = -9/50; b6 = 2/55;
b1s = 25/216; b2s = 0; b3s = 1408/2565; b4s = 2197/4104; b5s = -1/5; b6s = 0;

% Apply initial conditions
A(1,:) = ic;
t(1) = t0;

% Set initial stepsize
h = (tf-t0)/1000;  % try 1000 intervals

counter = 0;
ii = 1;
while t(ii) < tf
    % Extract initial condition
    r_vec = A(ii,:);
    if r_vec(5) < 1 && r_vec(6) < 0  % Landing event
        return;
    end

    for jj = 1:1:2
        % Compute k-values
        k1 = diffyq(t(ii),r_vec)';  % t,r_vec,mu,n,T
        k2 = diffyq(t(ii)+c2*h,r_vec + h*(a21*k1))';
        k3 = diffyq(t(ii)+c3*h,r_vec + h*(a31*k1+a32*k2))';
        k4 = diffyq(t(ii)+c4*h,r_vec + h*(a41*k1+a42*k2+a43*k3))';
        k5 = diffyq(t(ii)+c5*h,r_vec + h*(a51*k1+a52*k2+a53*k3+a54*k4))';
        k6 = diffyq(t(ii)+c6*h,r_vec + h*(a61*k1+a62*k2+a63*k3+a64*k4+a65*k5))';
    
        % Compute error
        approxErr = max(abs(h*( (b1-b1s)*k1 + (b2-b2s)*k2 + (b3-b3s)*k3 + (b4-b4s)*k4 + (b5-b5s)*k5 + (b6-b6s)*k6 )));

        % Set change
        A(ii+1,:) = A(ii,:) + h*(b1*k1+b2*k2+b3*k3+b4*k4+b5*k5+b6*k6);
        t(ii+1,1) = t(ii,1) + h;

        % Adjust step size
        h = min(2*h, 0.9*h*(allowedErr/approxErr)^(1/5));

        % Check error
        if approxErr < allowedErr
            counter = counter + 1;
            break
        end
    end
    ii = ii + 1;
end
return