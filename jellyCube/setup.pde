void setup(){
  size(1600,900, P3D);
  surface.setLocation(30,30);
  //fullScreen(P3D);
  textSize(50);
  init();
  bg = loadImage("w.jpg");
}

void init(){
  
  x = new PVector[N];
  v = new PVector[N];
  a = new PVector[N];
  
  x0 = new PVector[N];
  v0 = new PVector[N];
  
}

void init1(){
  
  restL = new float[N][N];
  
  for(int i=0; i<N; i++){
   // x[i] = new PVector(random(width),random(height));
    v[i] = new PVector(0,10,0);
    a[i] = new PVector(0,10,0);
    
  }
  
  for(int i=0; i<N;i++){
    for(int j=0; j<N;j++){
      restL[i][j] = PVector.sub(x[i],x[j]).mag(); 
    }
  }
  
  
   
  ready = true;


}
