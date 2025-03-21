function instantDrag = computeDrag(u, density, object)

objectArea = pi/4*object.diameter^2;  % Object Diameter [m^2]
instantDrag = 0.5*density*u^2*objectArea*object.cd;  % traditional drag formula