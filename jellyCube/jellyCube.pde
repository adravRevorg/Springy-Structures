//Point masses
int N=8; //no of point masses/vertices
PVector[] x;
PVector[] v;
PVector[] a;

PVector[] x0, v0;

float[][] restL ;


float k = 0.01;
float damping = 0.01;
float h=3; //h=1 



//Type of integration
boolean euler = false;
//RK4 Stuff
PVector[][] RK_v = new PVector[N][4];
PVector[][] RK_a = new PVector[N][4];
PVector[][] S_x = new PVector[N][4];
PVector[][] S_v = new PVector[N][4];

//INteractivity
boolean ready = false;





float g = 0.01;
PVector G = new PVector(0,g,0);


//Collision related stuff 
PVector n = new PVector(0,-1,0);
//Circle 
PVector circle;
float radius;

//Infinite Plane
PVector p = new PVector(0,900,0);
float planeW , planeL;

//Face
PVector[] face = new PVector[4];
float faceL, faceW;

//Triangle's vertices
PVector[] pT = new PVector[3];
PVector A;   //area vector


//Environmental Parameters
float e = 1;    //elasticity
float cf = 0.2;   //coefficient of friction
float ar = 0;//2 ;     //air resistance
float d = 0.5;       //air resistance  (new)
PVector vwind = new PVector(0,0,0);   //wind

boolean edgeCollision = false;
boolean vertexCollision = false;

PImage bg;
//Stable Values
//float k = 0.11;
//float damping = 0.1;
//float h=0.5;
//float g = 0.11;


//Bounce 
//float k = 0.11;
//float damping = 0.01;
//float h=3;
