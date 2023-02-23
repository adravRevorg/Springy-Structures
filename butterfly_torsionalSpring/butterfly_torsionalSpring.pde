//Let's make a butterly 




//Butterfly location, velocity, force of each vertex
PVector[] x = new PVector[4];  //x0,x1,x2,x3
PVector[] v = new PVector[4];
PVector[] f = new PVector[4];


PVector x01, x01_; // aka h to represent the central non-moving part of butterfly i.e. the hinge edge
PVector x02;
PVector x03;

PVector h_;  // h_ : to represent the central non-moving part of butterfly i.e. the hinge edge

PVector rl, rr;      //vectors to represent perpendiculars from hinge edge to the left and right vertices
PVector nl, nr;      //the normals to the wings
PVector nl_, nr_;

float d02,d03;


float restAngle;
float currAngle;    //the current angle between the wings

float lengthL, lengthR;
PVector rlP, rrP;
PVector radL,radR;


//Spring constant
float k = 10;
float kL = 100;
float damping = 0.0;

PImage wing;
PImage img;
