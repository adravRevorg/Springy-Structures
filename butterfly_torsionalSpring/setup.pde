void setup(){
  size(500,600,P3D);
  //fullScreen(P3D);
  
  background(0);stroke(255);fill(255);
  img = loadImage("plants.png");
  wing = loadImage("w.jpg");
  init();
  
  
}


void init(){
 
    x[1] = new PVector(width/2,height/2-200, -200);
    x[0] = new PVector(width/2,height/2, -200);
    x[2] = new PVector(width/4,height/4-100, -150);
    x[3] = new PVector(3*width/4,height/4-100, -150);
    scale(1, -1);

    x01 = PVector.sub(x[1],x[0]);
    
    x02 = PVector.sub(x[2],x[0]);
    x03 = PVector.sub(x[3],x[0]);
    
    for(int i=0;i<=3;i++){
      v[i] = new PVector(0,0,0);
      f[i] = new PVector(0,0,0);
    }
      draw_butterfly();
      strokeWeight(5);
    point(x01.x,x01.y,x01.z);strokeWeight(1);
    restAngle = 0.15;
    calculate();
    lengthL = rl.mag();
    lengthR = rr.mag();
    rlP = PVector.mult(x01_,d02);
    rrP = PVector.mult(x01_,d03);
    
    
    radL = PVector.sub(x[2],x[1]);
    radR = PVector.sub(x[3],x[1]);
    
    
}

void calculateRestAngle(){
  
    x01_ = x01.copy();
    x01_.normalize();
    
    rl = PVector.sub(x02,PVector.mult(x01_,PVector.dot(x02,x01)));
    rr = PVector.sub(x03,PVector.mult(x01_, PVector.dot(x03,x01)));
    
    nl = x01.cross(x02);    nl_ = nl.copy();  nl_.normalize();
    nr = x03.cross(x01);    nr_ = nr.copy();  nr_.normalize();
    
    float sinTheta = PVector.dot(x01_, nr_.cross(nl_));
    float cosTheta = PVector.dot(nr_,nl_);
    
    
    //println(atan(sinTheta/cosTheta));
}
