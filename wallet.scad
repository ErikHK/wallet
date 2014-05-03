include <roundCornersCube.scad>

//credit card width
cw = 53.98;

ch = 85.6;

w = 5;

module credit_card()
{
rCube(cw,ch,1.5,5);


}

module wallet()
{
rCube(cw+w*2, ch+w*2, 8, 6);


}


translate([0,0,20])
credit_card();

minkowski()
{
sphere(r=3);
wallet();
}