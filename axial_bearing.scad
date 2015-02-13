/*
 * Thrust ball bearings, single direction.
 *
 * Dimensions from http://www.skf.com/group/products/bearings-units-housings/ball-bearings/thrust-ball-bearings/single-direction/index.html
 */

include <MCAD/units.scad>
include <MCAD/bearing.scad>
include <scad-utils/morphology.scad>

// Example, uncomment to view
test_bearing();

module test_bearing(){
    axial_bearing(model=51112);
    axial_bearing(pos=[0,0,5*cm]);
}


// Dimensions index
OUTER_DIA_PILOT = 0;
BORE_DIA = 1;
RADIUS = 2;
HEIGHT = 3;
OUTER_DIA = 4;
BORE_DIA_CLEARENCE = 5;

// Axial bearing dimensions
// <model> = <number> ? [outer dia pilot, bore dia, radius, height, outer dia, bore dia clearence]
function AxialBearingDimensions(model) =
    model == "BA3" ? [7.8*mm, 3*mm, 1.2*mm, 3.5*mm, 8*mm, 3.2*mm]:
    model == 51112 ? [85*mm, 60*mm, 1.2*mm, 17*mm, 85*mm, 62*mm]:
		[7.8*mm, 3*mm, 1.2*mm, 3.5*mm, 8*mm, 3.2*mm]; // Default model BA 3

function bearingOuterDiameterTop(model) = AxialBearingDimensions(model)[OUTER_DIA_PILOT];
function bearingInnerDiameterTop(model) = AxialBearingDimensions(model)[BORE_DIA];
function bearingRadius(model) = AxialBearingDimensions(model)[RADIUS];
function bearingHeight(model) = AxialBearingDimensions(model)[HEIGHT];
function bearingOuterDiameterBotton(model) = AxialBearingDimensions(model)[OUTER_DIA];
function bearingInnerDiameterBotton(model) = AxialBearingDimensions(model)[BORE_DIA_CLEARENCE];

module axial_bearing(pos=[0,0,0], angle=[0,0,0], model="BA3", outline=false, material=Steel, sideMaterial=Brass) {

	// Use 27.5% of it total height for single direction bearing ring height
	ring_height = ((bearingHeight(model)/100)*27.5)*mm;

	translate(pos) rotate(angle) union() {

		// Top ring
		Ring([0,0,bearingHeight(model)-ring_height], bearingOuterDiameterTop(model), bearingInnerDiameterTop(model), ring_height, material, sideMaterial);

		// Botton ring
		Ring([0,0,0], bearingOuterDiameterBotton(model), bearingInnerDiameterBotton(model), ring_height, material, sideMaterial);
	}

	module Ring(pos, od, bd, h, material, holeMaterial) {
		color(material) {
			translate(pos)
        	difference() {
         	cylinder(r=od, h=h, $fs = 0.01);
         	color(holeMaterial)
            	translate([0,0,-10*epsilon])
              		cylinder(r=bd, h=h+20*epsilon, $fs = 0.01);
			}
		}
	}
}










