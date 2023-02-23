void draw(){
  
  
  background(53,81,100);
  
  
  draw_butterfly();
  
  img.resize(600,int(height*0.5));
  image(img,-50,height*0.5);
  
  calculate();
  calculateForces();
  updateState();
  saveFrame("frames/####.tif");
}

void draw_butterfly(){
  
 
 //left wing
 
  
  textureMode(NORMAL);
  beginShape();
  texture(wing);
    
  vertex(x[0].x,x[0].y,x[0].z,0,0);
  vertex(x[2].x,x[2].y,x[2].z,1,0);
  vertex(x[1].x,x[1].y,x[1].z,1,1);
  vertex(x[0].x,x[0].y,x[0].z,0,1);
  
  endShape(); 
    
  //right wing
  
  textureMode(NORMAL);
  beginShape();
  texture(wing);
  vertex(x[0].x,x[0].y,x[0].z,0,0);
  
  vertex(x[1].x,x[1].y,x[1].z,1,0);
  vertex(x[3].x,x[3].y,x[3].z,1,1);
  vertex(x[0].x,x[0].y,x[0].z,0,1);
  endShape();
  stroke(255);
  for(int i=0; i<2;i++){
    for(int j=i+1; j<=3; j++){
          line(x[i].x,x[i].y,x[i].z,x[j].x,x[j].y,x[j].z);
    }
  }
  
}

//Going to explain each step, because trying to catch error is easier
void calculate(){
 
  x01 = PVector.sub(x[1],x[0]);      //from x0 to x1
  x02 = PVector.sub(x[2],x[0]);      //from x0 to x2
  x03 = PVector.sub(x[3],x[0]);      //from x0 to x3
    
  //h_ :
  x01_ = x01.copy();                 //x01 unit
  x01_.normalize();
  
  
  d02 = x02.dot(x01_);                //projection of x02 on hinge edge
  d03 = x03.dot(x01_);
  
  rl = PVector.sub(x02,PVector.mult(x01_,d02));   //perpendicular from x01 line to vertex x2 - basically shortest distance of vertex 2 from line x01
  rr = PVector.sub(x03,PVector.mult(x01_,d03));
  
  nl = x01.cross(x02);    nl_ = nl.copy();  nl_.normalize();  //nl_ : unit perpendicular vector to the plane of left wing
  nr = x03.cross(x01);    nr_ = nr.copy();  nr_.normalize();
  
  float sinTheta = PVector.dot(x01_, nl_.cross(nr_));
  float cosTheta = PVector.dot(nr_,nl_);
  currAngle = atan(sinTheta/cosTheta);
}


//Calculate forces acting on all the vertices
void calculateForces(){
  
  float dTheta = (currAngle - restAngle);
  
  //torsional spring
  f[2] = nl_.copy();
  
  f[2].setMag(k/rl.mag());
  f[2].mult(-dTheta);
  f[2].add(PVector.mult(v[2],-damping));
  
  
  //radial change
  PVector tempL = PVector.sub(x[2],x[1]);
  PVector change = PVector.sub(tempL,radL);
  PVector radF = PVector.mult(change, -kL);
  radF.limit(2);
  f[2].add(radF);
  
  
  f[3] = nr_.copy();
  f[3].setMag(k/rr.mag());
  f[3].mult(dTheta);
  f[3].add(PVector.mult(v[3],-damping));
  
  PVector tempR = PVector.sub(x[3],x[1]);
  PVector changeR = PVector.sub(tempR,radR);
  radF = PVector.mult(changeR, -kL);
  radF.limit(2);
  f[3].add(radF);
 
}
  
void updateState(){
  for(int i=2;i<=3;i++){
    
    v[i].add(f[i]);
    x[i].add(v[i]);
    
    
  }
    
}
