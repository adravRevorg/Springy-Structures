//Credit : For UI controllers, I used an external library for Processing named controlP5

//Basic Spring


PVector anchor; //achor
float restL;    //rest length
float k = 0.005;    //spring coefficient
PVector v_anc = new PVector(0,0);

float damping =0.01;//999;
//state
PVector pos;
PVector v;
PVector a;
float h = 1;

void setup(){
  size(900,700);
  background(0);
  init();
  add_UI();
}

void draw(){
  background(0);
  stroke(255);
  line(pos.x,pos.y, anchor.x,anchor.y);
  fill(0,255,0);
  circle(pos.x,pos.y,30);
  fill(255,0,0);
  circle(anchor.x,anchor.y,30);
  updateState();
}

void updateStateOneBob(){
   
  a = PVector.sub(pos,anchor);
  if (abs(a.mag()-restL)<0.1)  return;
  v.add(a.mult(-k));
  pos.add(v);
  v.mult(damping);
}

void updateState1(){
   
  a = PVector.sub(pos,anchor);
  float dx = abs(a.mag()-restL);
  if (dx<0.3)  return;
  a.normalize();
  a.setMag(dx);
  a.mult(-k);
  v.add(a);
  pos.add(v);
  v_anc.add(a.mult(-1));
  anchor.add(v_anc);
  //v.mult(damping);
  //v_anc.mult(damping);
}

void updateState(){
  PVector disp = PVector.sub(pos,anchor);
  float dx = (disp.mag()-restL);
  //if (abs(dx)<0.05)  return;
  
  PVector f_spring = disp.copy();
  f_spring.setMag(dx);
  f_spring.mult(-k);
  PVector f_damping = PVector.mult(v,-damping);
  a = PVector.add(f_spring,f_damping);
  
  v.add(a);
  pos.add(v);
  //anchor (comment the following lines to fix one)
  f_spring.mult(-1);
  f_damping = PVector.mult(v_anc,-damping);
  a = PVector.add(f_spring,f_damping);
  v_anc.add(a);
  anchor.add(v_anc);
}

void mousePressed(){
  pos.add(0,random(-150,150));
}

void mouseDragged(){
  anchor = new PVector(mouseX,mouseY);
}
  

void init(){
  anchor = new PVector(width/2, height/2);
  restL = 300;
  pos = PVector.add(anchor,new PVector(0,restL));
  v = new PVector(0,0);
  a = new PVector(0,0);
}
