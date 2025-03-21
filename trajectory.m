% 3d plot
figure
plot3(x_ft,y_ft,z_ft,'LineWidth',2)
xlabel('x [ft]')
ylabel('y [ft]')
zlabel('z [ft]')
axis equal
grid on

minDisplacement = min([min(x) min(y) min(z)]);  % find min displacement direction
maxDisplacement = max([max(x) max(y) max(z)]);  % find max displacement direction
axis([0 maxDisplacement 0 maxDisplacement 0 maxDisplacement])  % force plot to be a cube

view([0 -1 0])