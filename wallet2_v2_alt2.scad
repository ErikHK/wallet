$fn = 40;
use <wallet.scad>


//rounding
r = 4;

//width
w = 60;

//bottom roof length
brl = 20;

//top roof length
trl = 50;

//won't fall out give width
wfogw = 3;

//won't fall out give height
wfogh = .4;

//hinge give
hg = .25;

//give between hinge and wallet
give = -.2;

//distance between cylinders in hinge

dc = 8.5+1;

//hinge radius1
hr1 = 3.4;

hr2 = 1;

//cylinder height
ch = 5;

//total hinge distance
th = dc+ch*2;


//distance between hinges
dh = th;

//wall thickness
wth = 2;

//magnet hole radius
mhr = 5.6;

//magnet hole height
mhh = 4.4+1;

//difference in height between top and bottom
diff = 0;


hh = hr1*sqrt(2)-wfogh-wth;
c = w - wth*2 - wfogw*2;
R = hh/2 + c*c/(8*hh);


module hinge_m(left=true, right=true)
{
r1 = hr1;
r2 = hr2;


rotate([0,90,0])
cylinder(r=hr1, h=th);


//cones
if(left){
rotate([0,-90,0])
cylinder(r1=r1, r2=r2, h=ch);
}

if(right){
translate([ch*2+dc,0,0])
rotate([0,90,0])
cylinder(r1=r1, r2=r2, h=ch);
}


rotate([135,0,0])
translate([0,-hr1,0])
cube([th,hr1*2,hr1]);



//support box
translate([0,-hr1*sqrt(2),-hr1*sqrt(2)])
cube([th,hr1*sqrt(2),hr1*sqrt(2)]);


//give box
translate([0,-give-hr1*sqrt(2),-hr1*sqrt(2)])
cube([th,give,hr1*sqrt(2)]);


}




module hinge_f()
{

difference()
{
union()
{

rotate([135,0,0])
translate([-th+hg,-hr1,0])
cube([th-hg*2,hr1*2,hr1]);


//support box
translate([-th+hg,-hr1*sqrt(2),-hr1*sqrt(2)])
cube([th-hg*2,hr1*sqrt(2),hr1*sqrt(2)]);

//give box
translate([-th+hg,-give-hr1*sqrt(2),-hr1*sqrt(2)])
cube([th-hg*2,give,hr1*sqrt(2)]);



translate([-th,0,0])
rotate([0,90,0])
cylinder(r=hr1,h=th);
}

translate([.01,0,0])
rotate([0,-90,0])
cylinder(r1=hr1+hg, r2=hr2+hg,h=ch+hg);


translate([-th-.01,0,0])
rotate([0,90,0])
cylinder(r1=hr1+hg, r2=hr2+hg,h=ch+hg);
}
}



//space for cards
module bottom()
{

//roof!
translate([th*5-brl,0,hr1*sqrt(2)-.75+diff])
{
rCube(brl,58,.75,r);
cube([brl-10,58,.75]);
}

//translate([0,w/2,R+wth]) rotate([0,90,0]) cylinder(r=R, h=wth, $fn=200);


difference()
{
union()
{

rCube(th*5,w,hr1*sqrt(2)+diff,r);

//translate([0,0,0])
cube([th*5,4,hr1*sqrt(2)]);

}

translate([wth,wth,wth])
rCube(th*5+r-wth*4,w-wth*2,hr1*2,r);


translate([-.1,w/2,R+wth]) rotate([0,90,0]) cylinder(r=R, h=wth+1, $fn=200);


}

}


//space for money
module top()
{

//roof!
translate([th*5-trl,0,hr1*sqrt(2)-.75-diff])
{
rCube(trl,58,.75,r);
cube([trl-10,58,.75]);

}

//so the cards won't fall out when shut!
//translate([0, wth+wfogw, 0])
//rCube(5,w-wth*2-wfogw*2,hr1*sqrt(2)*2-wfogh-wth,r);


intersection()
{
translate([0,(w-wth)/2,-R+hr1*sqrt(2)+wth])
rotate([0,90,0])
cylinder(r=R, h=wth, $fn=200);

translate([0,-R/2,hr1*sqrt(2)])
cube([20,R*2,20]);
}

difference()
{
union()
{
rCube(th*5,w,hr1*sqrt(2)-diff,r);

}

translate([wth,wth,wth])
rCube(th*5-r,w-wth*2,hr1*2,r);

}
}



module magnet_holder()
{
translate([0,0,0])
rCube(th*5,3,5,2);

}


//translate([-th,-hr1*sqrt(2)+give-w+hg-5,-hr1*sqrt(2)])
//magnet_holder();


mirror([0,0,0])
{
//HINGES!!!

hinge_m(right=false);
translate([-th*2,0,0])
hinge_m();
translate([-th*4,0,0])
hinge_m(left=false, right=true);



mirror([0,1,0])
{
hinge_f();
translate([-th*2,0,0])
hinge_f();
}

translate([-th*4,-hr1*sqrt(2)-give,-hr1*sqrt(2)])
mirror([0,1,0])
bottom();



translate([-th*4,hr1*sqrt(2)+give,-hr1*sqrt(2)])
top();
}