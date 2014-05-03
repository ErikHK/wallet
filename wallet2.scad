$fn = 40;
use <wallet.scad>

//credit_card();

//hinge give
hg = .2;

//give between hinge and wallet
give = 1;

//distance between cylinders in hinge

dc = 8.5;

//hinge radius1
hr1 = 5;

hr2 = 2;

//cylinder height
ch = 5;

//total hinge distance
th = dc+ch*2;


//distance between hinges
dh = th;

//bottom walls' thickness
bw = 2;



module hinge_m()
{
r1 = hr1;
r2 = hr2;

translate([0,-hr1-give,-hr1])
cube([th, hr1+give, hr1*2]);


rotate([0,-90,0])
cylinder(r1=r1, r2=r2, h=ch);

translate([-ch*2-dc,0,0])
rotate([0,90,0])
cylinder(r1=r1, r2=r2, h=ch);
}

module hinge_f()
{
difference()
{
union()
{
translate([-th,0,0])
cube([th,hr1+give,hr1*2]);

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
difference()
{
union()
{
rCube(th*5,60,10,4);

translate([0,0,0])
cube([th*5,4,10]);



//magnet holder 2
difference()
{
translate([th*2.5,63,0])
cylinder(r=10, h=10);

translate([th*2.5,65,2])
cylinder(r=5, h=20);
}

}

translate([2,2,2])
rCube(th*5-4,60-4,10,4);
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
cube([th*5,10,10]);

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


translate([-th-dh,0,0])
{
rotate([0,90,0])
cylinder(r=hr1, h=dh);


translate([0,-hr1-give,-hr1])
cube([th, hr1+give, hr1*2]);
}


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


translate([-th*2+2,-hr1-give-3,10])
rotate([0,0,-90])
credit_card();



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


translate([-th*2,hr1+give,-hr1])
top();