function [t, A] = rk4(diffyq, t0, tf, ic, h)
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

% Initialize output dimensions
A = zeros(ceil((tf-t0)/h), length(ic));

% Initialize time dimensions
t = zeros(height(A),1);

% Apply initial conditions
A(1,:) = ic;
t(1) = t0;

for ii = 1:1:height(A)-1
    % Extract initial condition (for readability)
    r_vec = A(ii,:);
    if r_vec(5) < 1 && r_vec(6) < 0  % Landing event
        return;
    end
    
    % Compute k-values
    k1 = diffyq(t(ii),r_vec)';  % t,r_vec,mu,n,T
    k2 = diffyq(t(ii)+h/2,r_vec + h*k1/2)';
    k3 = diffyq(t(ii)+h/2,r_vec + h*k2/2)';
    k4 = diffyq(t(ii)+h,r_vec + h*k3)';

    % Compute change
    A(ii+1,:) = A(ii,:) + (h/6)*(k1+2*k2+2*k3+k4);
    t(ii+1,1) = t(ii,1) + h;
end