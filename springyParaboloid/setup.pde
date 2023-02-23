void setup(){
  size(600,600,P3D);
  //fullScreen(P3D);
  background(0);
  init();
  
}

void init(){
  
  //assign point masses their position
  int y = 0;
  for(int i=0; i<N;){
    float theta = 0.0;
    for(theta=0; theta<TWO_PI && i<N; theta+=TWO_PI/row, i++){
      x[i] = new PVector(0,0,0);
      x[i].y = y;
      x[i].x = sqrt(y*200)*cos(theta); //if tube, just to sqrt(10000)*...
      x[i].z = sqrt(y*200)*sin(theta);
      angle[i] = theta;
      
      restY[i] = y;
      restH[i] = sqrt(y*200);
      
      v[i] = new PVector(0,0,0);
      a[i] = new PVector(0,0,0);
      
    }
    y+=10;
  }
}
