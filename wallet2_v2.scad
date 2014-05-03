$fn = 40;
use <wallet.scad>

//credit_card();

//hinge give
hg = .3;

//give between hinge and wallet
give = .8;

//distance between cylinders in hinge

dc = 8.5;

//hinge radius1
hr1 = 3;

hr2 = 1;

//cylinder height
ch = 5;

//total hinge distance
th = dc+ch*2;


//distance between hinges
dh = th;

//bottom walls' thickness
bw = 2;

//magnet hole radius
mhr = 5.7;

//magnet hole height
mhh = 4.4+1;


module hinge_m()
{
r1 = hr1;
r2 = hr2;


test = hr1+.414*hr1*2;

/*
translate([0,-test,-hr1])

rotate([45,0,0])
cube([th,hr1,hr1]);
*/
support();

translate([0,-test,-hr1])
cube([th, test, hr1*2]);


rotate([0,-90,0])
cylinder(r1=r1, r2=r2, h=ch);

translate([-ch*2-dc,0,0])
rotate([0,90,0])
cylinder(r1=r1, r2=r2, h=ch);
}


module support()
{
test = hr1+.414*hr1*2;


translate([0,-test,-hr1])

rotate([45,0,0])
cube([th,hr1,hr1]);


}


module hinge_f()
{

test = hr1+.414*hr1*2;


difference()
{
union()
{



rotate([45,0,0])
translate([-th,hr1+.5+.5,-hr1*2+2.415])

//translate([0,0,hr1])
cube([th,hr1,hr1]);


//translate([0,0,hr1])
//support();

translate([-th,0,0])
cube([th,hr1+2*(sqrt(2)-1)*hr1,hr1*2]);

translate([-th,0,hr1])
rotate([0,90,0])
cylinder(r=hr1,h=th);
}

translate([.01,0,hr1])
rotate([0,-90,0])
cylinder(r1=hr1+hg, r2=hr2+hg,h=ch+hg);


translate([-th-.01,0,hr1])
rotate([0,90,0])
cylinder(r1=hr1+hg, r2=hr2+hg,h=ch+hg);
}
}

//space for money and junk
module bottom()
{
//sliders!


translate([12,16,2])

rotate([90,0,180])
linear_extrude(height=4)
polygon(points=[[10,4], [10,0], [0,0]]);

//roof!
translate([70.5,0,5.25])
cube([20,58,.75]);


translate([12,40,2])

rotate([90,0,180])
linear_extrude(height=4)
polygon(points=[[10,4], [10,0], [0,0]]);




difference()
{
union()
{

rCube(th*5,60,hr1*2,4);

translate([0,0,0])
cube([th*5,4,hr1*2]);



//magnet holder 2
translate([th*2.5,65.7,5.1])
cylinder(r=5.69, h=.85);

difference()
{

translate([th*2.5,63,0])
cylinder(r=10, h=hr1*2);


translate([th*2.5,65.7,1.5])
cylinder(r=mhr, h=mhh);
}

}

translate([2,2,2])
rCube(th*5-4,60-4,hr1*2,4);
}


/*
//magnet holder
translate([2,58,0])
quarter_cylinder(r=15, h=10);

translate([6,54,0])
cylinder(r=5, h=20);
*/
}


//space for cards
module top()
{
difference()
{
union()
{
rCube(th*5,60,hr1*2,4);

//magnet holder 2

translate([th*2.5,65.7,5.1])
cylinder(r=5.69, h=.85);


difference()
{
translate([th*2.5,63,0])
cylinder(r=10, h=hr1*2);

translate([th*2.5,65.7,1.5])
cylinder(r=mhr, h=mhh);
}
}

//credit card slots!

/*
translate([95,2.5,1])
rotate([0,0,90])

scale([1.00235,1.1,1.25])
credit_card();
*/

translate([95+6,2.5,2])
rotate([0,0,90])

scale([1.00235,1.1,1.24])
credit_card();



}
}

module quarter_cylinder(r=1, h=1)
{
difference()
{
cylinder(r=r, h=h);
translate([-r,0,0])
cube([r*2,r,r]);

translate([-r,-r,0])
cube([r,r*2,r]);

}
}



//FULHACK ALERT
translate([0,give,hr1])
rotate([45,0,0])
translate([-th-dh,0,0])
{
rotate([0,90,0])
cylinder(r=hr1, h=dh);



translate([0,-hr1-hr1*.414*2,-hr1])
cube([th, hr1+.414*2*hr1, hr1*2]);


support();
}





translate([0,give,hr1])
rotate([45,0,0])

for(i=[0:1])
{
hinge_m();
translate([i*(th+dh),0,0])
rotate([0,90,0])
cylinder(r=hr1, h=dh);
translate([i*(ch*2+dc+dh),0,0])
hinge_m();

}

//cube([2,20,1]);


/*
translate([-th*2+2,-hr1-give-3,10])
rotate([0,0,-90])
credit_card();
*/


translate([0,give,hr1])
rotate([-45,0,0])
translate([0,0,-hr1])

{
for(i=[0:1])
{
translate([i*th*2,0,0])
hinge_f();

}
 

}


translate([-th*2,-hr1-give,-hr1])
mirror([0,1,0])
bottom();


translate([-th*2,hr1+give+give+give,-hr1])
top();



/*
rotate([45,0,0])
hinge_m();

rotate([-45,0,0])
translate([0,0,-hr1])
hinge_f();
*/


/*
translate([0,0,50])
hinge_m();
*/