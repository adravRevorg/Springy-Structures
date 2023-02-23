
void keyPressed(){
  
  if (key=='e'){
    euler = !euler;
    return;}
  
  float x1 = width*0.4, x2 = width*0.6, y1 = 100, y2 = 300, z1 = -300, z2 = -500;
  
  float yoff = 0;
  
  if (key=='y')
      yoff = 100;
  x[0] = new PVector(x1,y1,z1);
  x[1] = new PVector(x2,y1-yoff,z1);
  x[2] = new PVector(x2,y2-yoff,z1);
  x[3] = new PVector(x1,y2,z1);
  
  
  x[4] = new PVector(x1,y1,z2);
  x[5] = new PVector(x2,y1-yoff,z2);
  x[6] = new PVector(x2,y2-yoff,z2);
  x[7] = new PVector(x1,y2,z2);
  
  
  //add Plane
  p.x = (x1+x2)/2;
  p.y = y2+300;
  p.z = (z1+z2)/2;
  planeL = 1000;
  planeW = 700;
  
  //Face
  float ox = (x1+x2)/2 + 50, oz = (z1+z2)/2 - 300;
  float faceL = 400, faceW = 500;
  face[0] = new PVector(x1-300, 900, z2+50);
  face[1] = new PVector(x1+300,900,z2+50);
  face[2] = new PVector(x1+300, 900, z1-50);
  face[3] = new PVector(x1-300, 900, z1-50);
  
  init1();
   
      
}

void mousePressed(){
  if (ready){
    x[1].add(new PVector(random(20),random(-20,0),-10));
    x[5].add(new PVector(random(20),random(-20,0),-100));
  }
   
}
