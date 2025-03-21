% Generates plots using matplotlib.pyplot
%
% plots each dependent variable on y-axis against corresponding indendent
% variable using
%   cell vectors
%
% label_var is corresponding legend entries. If they're all empty strings,
% no legend is generated.
%   string
%
% axis_label_var{1} - x-axis label 
%   string
% axis_label_var{2} - y-axis labe
%   string

clear dependentVariable;
clear independentVariable;

%% Inputs
% Variables
independentVariable{1} = ork_unballasted(1:500,1);
dependentVariable{1} = ork_unballasted(1:500,5)+0.23;
label_var{1} = 'Openrocket (Unballasted)';

independentVariable{2} = ork_ballasted(1:500,1);
dependentVariable{2} = ork_ballasted(1:500,5)+0.23;
label_var{2} = 'Openrocket (Ballasted)';

% Axis labels
axis_label_var{1} = 'Time [s]';
axis_label_var{2} = 'Static Margin';

%% Plotting
addpath('C:\Users\colin\Documents\USLI\TrajectorySim\plotter')
pythonPlotter(independentVariable, dependentVariable, label_var, axis_label_var, n)
rmpath('C:\Users\colin\Documents\USLI\TrajectorySim\plotter')