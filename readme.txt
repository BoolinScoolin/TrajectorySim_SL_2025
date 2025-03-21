Computes flight profile of launch vehicle assuming point mass & zero AoA

How to use:

Generating Data
---------------------------------------------------------
run "defineCustom" to define all necessary parameters

run "defineDefault" to set all necessary parameters to a default setting
	useful to change defineDefault to match your current vehicle

run "main" to calculate in flight parameters


Visualizing Data
---------------------------------------------------------
run "altitude" to view time vs altitude plot
run "lateralDisplacement" to view altitude vs lateral displacement
run "trajectory" to view 3d trajectory
run "finFlutter" to perform fin flutter analysis

Finders
---------------------------------------------------------
finders vary a parameter to try and match a specific apogee altitude
User should input said apogee altitude into the cdFinder or cantFinder script
cdFinder - intended to determine real Cd of launch vehicle based on experimental data
cantFinder - intended to determine ideal launch angle to reach specific apogee on launch day

wind and defineWind are not fully working yet. I'd suggest keeping the wind section in main as is to avoid erroneous results.

