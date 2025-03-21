% Lateral Displacement vs Altitude
figure
plot(sqrt(x_ft.^2+y_ft.^2),z_ft,'o')  % Solver
hold on
xlabel('Lateral Displacement [ft]')
ylabel('Altitude [ft]')

legend('Solver')