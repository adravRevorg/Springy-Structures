void draw(){
  translate(width/2,height/2,-00);
  
  background(0);
  strokeWeight(2);
  stroke(255);
  
  //show state
  stroke(255,0,0);
  drawFigure1();
  scale(1,-1);
  stroke(0,255,0);
  drawFigure1();
  
  //updateState
  update_state();
  //saveFrame("frames/####.tif"); 
  
}
    
    
void drawFigure(){
  for(int i=0;i<row; i++){
    
    noFill();
    beginShape();
    
    curveVertex(x[i].x,x[i].y,x[i].z);
    int j,t=0;
    for(j=0; j<col; j++){
      t = i+ j*row;
      curveVertex(x[t].x,x[t].y,x[t].z);
    }
    
   // curveVertex(x[t].x,x[t].y,x[t].z);
    endShape();
  }
}

void drawFigure1(){
  for(int i=0;i<N; i++){
    int t = i;
    noFill();
    beginShape();
    curveVertex(x[i].x,x[i].y,x[i].z);
    for(int j=1; j<row && i<N; j++,i++){
      curveVertex(x[i].x,x[i].y,x[i].z);
    }
    curveVertex(x[t].x,x[t].y,x[t].z);
    curveVertex(x[t].x,x[t].y,x[t].z);
    endShape();
  }
}
