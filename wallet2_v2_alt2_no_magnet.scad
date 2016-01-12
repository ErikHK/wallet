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
hg = .25+.2;

//give between hinge and wallet
give = -.2;

//distance between cylinders in hinge

dc = 8.5+1;

//hinge radius1
hr1 = 3.4+.5;

hr2 = 1;

//cylinder height
ch = 5;

//total hinge distance
th = dc+ch*2;


//distance between hinges
dh = th;

//wall thickness
wth = 2;

//bottom thickness
bth = 1.25;

//magnet hole radius
mhr = 5.7;

//magnet wall thickness
mwth = 2;

//magnet hole height
mhh = 4.4+1;

//distance between origin
//and end of wallet
dbow = -hr1*sqrt(2)-give-w;

//difference in height between top and bottom
diff = .5;


hh = hr1*sqrt(2)-wfogh-wth;

totheight=hr1*sqrt(2)+diff;

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

//translate([th*2.5, w+mhr, 0]) mirror([1,0,0]) magnet_holder();

difference()
{
union()
{

rCube(th*5,w,hr1*sqrt(2)+diff,r);

//translate([0,0,0])
cube([th*5,4,hr1*sqrt(2)]);

}

translate([wth,wth,bth])
rCube(th*5+r-wth*4,w-wth*2,hr1*2,r);


translate([-.1,w/2,R+wth+diff]) rotate([0,90,0]) cylinder(r=R, h=wth+1, $fn=200);


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
translate([0,(w-wth)/2,-R+hr1*sqrt(2)+wth+.5]) //OBS!!!!!!!!!!!!!!!!!!!!!
rotate([0,90,0])
cylinder(r=R, h=wth, $fn=200);

translate([0,-R/2,hr1*sqrt(2)-diff])
cube([20,R*2,20]);
}

difference()
{
union()
{
rCube(th*5,w,hr1*sqrt(2)-diff,r);



//translate([th*2.5,w+mhr,0])
//magnet_holder(diff=0);

}

translate([wth,wth,bth])
rCube(th*5-r,w-wth*2,hr1*2,r);

}
}


module magnet_holder_plug()
{
rr = mhr-.1;
cylinder(r=rr, h=.8);
pth = .5;

module fastener()
{
 translate([-1.9/2,rr-.1,1])
  rotate([0,90,0])
  cylinder(r=1,h=1.9, $fn=4);
}

module pins()
{


  
  difference()
  {
  union()
  {
  cylinder(r=rr, h=1);
  

  //fasteners
  fastener();
  rotate([0,0,90])
  fastener();
  rotate([0,0,180])
  fastener();
  rotate([0,0,-90])
  fastener();
  
  }
  
  translate([0,0,.001])
  cylinder(r=rr-pth, h=1);

  translate([0,0,1])
  cylinder(r=rr+2,h=10);

  rotate([0,0,-45])
  translate([-.5,-rr-2,0])
  cube([1,rr*2+4,1.1]);

  rotate([0,0,45])
  translate([-.5,-rr-2,0])
  cube([1,rr*2+4,1.1]);



  }
}

translate([0,0,.8])
pins();

}



module magnet_holder(diff=0)
{

//magnet!
//translate([0,0,hr1*sqrt(2)-mwth/2-2.6])
//cylinder(r=5, h=2.6);

difference()
{
union()
{
cylinder(r=mhr+mwth, h=hr1*sqrt(2)+diff);

translate([-mhr-mwth,-mhr-mwth,0])
cube([(mhr+mwth)*2,mhr+mwth,hr1*sqrt(2)+diff]);
}

translate([0,0,-.01-diff])
cylinder(r=mhr, h=hr1*sqrt(2)-mwth/2+diff);

//translate([-mhr*2,0,0])
//cube([20,20,20]);


translate([0,0,1])
{
rotate([0,0,90])
translate([-1,-mhr+.1,1])
rotate([0,90,0])
cylinder(r=.5, h=2, $fn=4);

rotate([0,0,-90])
translate([-1,-mhr+.1,1])
rotate([0,90,0])
cylinder(r=.5, h=2, $fn=4);


rotate([0,0,0])
translate([-1,-mhr+.1,1])
rotate([0,90,0])
cylinder(r=.5, h=2, $fn=4);

rotate([0,0,180])
translate([-1,-mhr+.1,1])
rotate([0,90,0])
cylinder(r=.5, h=2, $fn=4);

}



}

}


module magnet_holder_2()
{

//magnet!
//translate([0,0,hr1*sqrt(2)-mwth/2-2.6])
//cylinder(r=5, h=2.6);

difference()
{
union()
{
cylinder(r=mhr+mwth, h=hr1*sqrt(2));

translate([-mhr-mwth,-mhr-mwth,0])
cube([(mhr+mwth)*2,mhr+mwth,hr1*sqrt(2)]);
}

translate([0,0,-.01])
cylinder(r=mhr, h=hr1*sqrt(2)-mwth/2);

//translate([-mhr*2,0,0])
//cube([20,20,20]);





}

}


//translate([-th,-hr1*sqrt(2)+give-w+hg-5,-hr1*sqrt(2)])
//magnet_holder();



module wallet()
{

//bottom!
module bottom_h()
{
hinge_m(right=false);
translate([-th*2,0,0])
hinge_m();
translate([-th*4,0,0])
hinge_m(left=false, right=true);
translate([-th*4,-hr1*sqrt(2)-give,-hr1*sqrt(2)])
mirror([0,1,0])
bottom();


translate([-17,-w-11.3,-.5])
rotate([-90,0,90])
clip(give=.2);

}

bottom_h();




module top_h()
{
mirror([0,1,0])
{
hinge_f();
translate([-th*2,0,0])
hinge_f();
}

translate([-th*4,hr1*sqrt(2)+give,-hr1*sqrt(2)])
top();


translate([-40,w -(-hr1*sqrt(2)-give)+totheight,-.5])
rotate([-90,0,-90])
clip(give=.2);

}

rotate([180,0,0])
top_h();

}

wallet();


/*
translate([20,0,0])
magnet_holder();

magnet_holder_plug();
*/


module clip(dd=1, len=10, give=0)
{

module top()
{
  cylinder(d=totheight-dd, h=.01);
  translate([0,0,.5])
  sphere(d=4, $fn=12);
}

translate([0,0,0])
{
  //rotate([0,90,0])
  //{
    translate([totheight/2+dd/2,-totheight/2+dd/2+give,0])
    {
    cylinder(d=totheight-dd, h=len);
    translate([-totheight/2+dd/2,0,0])
    cube([totheight-dd,totheight/2-dd/2-give,len]);

    hull()
    {
    translate([0,0,len])
    top();
    }
    }

    translate([dd,0,0])
	 linear_extrude(height=len)
    polygon(points=[[0,0], [totheight-dd,0], [totheight-dd,totheight-dd]], paths=[[0,1,2]]);
    
    //translate([0,0,15])
    //cylinder(d1=5, d2=3, h=2);
  //}
}
}

