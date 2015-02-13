include <MCAD/stepper.scad>
include <MCAD/units.scad>
include <MCAD/materials.scad>
include <MCAD/bearing.scad>

include <MCAD/nuts_and_bolts.scad>

//motor(Nema17);


color(Iron) {
	//translate([15*cm,0,0]) nutHole(8);
}

difference(){
	// Base
	difference() {
		cylinder(h=12*mm, r=10*cm);

		translate([0,0,-epsilon	]) difference() {
			cylinder(h=7*mm, r=9.5*cm);
			translate([0,0,-epsilon	]) cylinder(h=7*mm, r=1.5*cm);
		}
	}

	// Nut hole
	translate([0,0,-epsilon	]) nutHole(8);

	// Center hole
	translate([0,0,-1.5]) boltHole(8, length=15*mm);

}
bearing(pos=[0, 0, 12*mm], model=SkateBearing);

