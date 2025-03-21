% Plots Altitude vs Time
plot(t,z_ft,'.')  % Solver
hold on
grid on
xlabel('Time [s]', 'Interpreter', 'latex')
ylabel('Altitude [ft]', 'Interpreter', 'latex')

legend('Solver')