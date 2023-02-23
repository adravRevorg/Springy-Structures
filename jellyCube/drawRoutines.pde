
void drawState(){
  
  strokeWeight(2);stroke(255);
  
  drawFace(0,1,2,3);
  drawFace(4,7,6,5);
  drawFace(1,5,6,2);
  drawFace(0,3,7,4);
  drawFace(0,4,5,1);
  drawFace(3,2,6,7);
  
  drawPlane();
  //drawBaseFace();
}


void drawFace(int a, int b, int c, int d){
  //background(0);
  
  int[] ver = {a,b,c,d};
  //noStroke();
  fill(150);
  beginShape();
  textureMode(NORMAL);
  texture(bg);
  
  int j=ver[0]; vertex(x[j].x,x[j].y,x[j].z, 0, 0);
  j=ver[1]; vertex(x[j].x,x[j].y,x[j].z, 1,0);
  j=ver[2]; vertex(x[j].x,x[j].y,x[j].z, 1,1);
  j=ver[3]; vertex(x[j].x,x[j].y,x[j].z, 0,1);
  endShape();
  
  
}

void drawFace1(int a, int b, int c, int d){
  //background(0);
  
  int[] ver = {a,b,c,d};
  //noStroke();
  fill(153,255,255);
  beginShape();
  for(int i=0;i<4;i++){
    int j = ver[i];
    vertex(x[j].x,x[j].y,x[j].z);
  }
  endShape();
  
  
}


void drawPlane(){
  fill(53,81,100);
  noStroke();
  PVector[] pts = new PVector[4];
  pts[0] = PVector.add(p, new PVector(-planeL,0,planeW));
  pts[1] = PVector.add(p, new PVector(-planeL,0,-planeW));
  pts[2] = PVector.add(p, new PVector(planeL,0,-planeW));
  pts[3] = PVector.add(p, new PVector(planeL,0,planeW));
  
  beginShape();
  int i=0;
  //vertex(pts[i].x,pts[i].y,pts[i].z);
  for(i=0;i<4;i++){
    vertex(pts[i].x,pts[i].y,pts[i].z);
  }
  i = 0;
  vertex(pts[i].x,pts[i].y,pts[i].z);
  endShape();
}

void drawBaseFace(){
  fill(50);
  beginShape();
  int i=0;
  for(i=0;i<=4;i++)
    vertex(face[i%4].x,face[i%4].y,face[i%4].z);
  endShape();
}
  
  
  
  
  
  
