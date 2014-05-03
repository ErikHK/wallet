$fn = 40;
use <wallet.scad>

//credit_card();

//hinge give
hg = .2;

//give between hinge and wallet
give = .5;

//distance between cylinders in hinge

dc = 8;

//hinge radius1
hr1 = 5;

hr2 = 2;

//cylinder height
ch = 5;

//total hinge distance
th = dc+ch*2;


//distance between hinges
dh = th;



module hinge_m()
{
r1 = hr1;
r2 = hr2;


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


translate([-th-dh,0,0])
rotate([0,90,0])
cylinder(r=hr1, h=dh);
for(i=[0:2])
{
hinge_m();
translate([i*(th+dh),0,0])
rotate([0,90,0])
cylinder(r=hr1, h=dh);
translate([i*(ch*2+dc+dh),0,0])
hinge_m();

}

//cube([2,20,1]);

//rotate([0,0,-90])
//credit_card();

translate([0,0,-hr1])
hinge_f();