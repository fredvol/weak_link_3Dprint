/* Open SCAD Name.:Weak link
*
*  Creation Date..: 21/06/2021
*  Discription....: PLA weak link
*  Author.........: fred
*
*  Version 1, 21/06/2021 : initial 

*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*/ 

/*------------------Customizer View-------------------*/
// preview[view:north, tilt:top]


/*---------------------Parameters---------------------*/
// Parameters in the execute section
//
nb_weak_link = 3 ;
distance_object_mm = 2 ;


internal_gap_mm = 5.9;
length_mm = 50;
height_mm = 4 ;
wall_thickness_mm = 5;

/*-----------------------Execute----------------------*/
echo("Weak link section ",wall_thickness_mm * height_mm* 2, "mm2");
distance_mm = internal_gap_mm + ( 2* wall_thickness_mm) + distance_object_mm;

linear_array( occurance=nb_weak_link, distance=distance_mm)  weak_link( internal_gap_mm , length_mm , height_mm , wall_thickness_mm );

/*-----------------------Modules----------------------*/

module linear_array( occurance, distance ) {
    for ( i= [1:1:occurance])  {
        translate([distance*i,0,0,]) 
        children();
    }
}

module weak_link( internal_gap , length , height , wall ){

    dia=internal_gap +( 2* wall);
    center = true;
        
    difference() {
            
            union() {
                //create base oblong structure
                cube([dia,length,height], center);
                translate ([0,length/2,0]) {cylinder(height,dia/2,dia/2,$fn=60, center);
                }
                translate ([0,-length/2,0]) {cylinder(height,dia/2,dia/2,$fn=60, center);
                }
            } //end union
            
            union() {
                //create base oblong structure
                cube([dia-(wall*2),length,height+1], center);
                translate ([0,length/2,0]) {cylinder(height+1,dia/2-wall,dia/2-wall,$fn=60, center);
                }
                translate ([0,-length/2,0]) {cylinder(height+1,dia/2-wall,dia/2-wall,$fn=60, center);
                }
            } //end union
        } //end differance


    } //End module

/*----------------------End Code----------------------*/