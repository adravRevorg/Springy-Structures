void setup(){
  //size(900,700, P3D);
  //surface.setLocation(10,10);
  fullScreen(P3D);
  init();
  addCube();
  addTriangles();
  frameRate(30);
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
    v[i] = new PVector(0,6,0);
    a[i] = new PVector(0,10,0);
    
  }
  
  for(int i=0; i<N;i++){
    for(int j=0; j<N;j++){
      restL[i][j] = PVector.sub(x[i],x[j]).mag(); 
    }
  }
   
  ready = true;


}

void addCube(){
  
    float x1 = 300, x2 = 500, y1 = 500, y2 = 600, z1 = -300, z2 = -500;
    x[0] = new PVector(x1,y1,z1);
    x[1] = new PVector(x2,y1,z1);
    x[2] = new PVector(x2,y2,z1);
    x[3] = new PVector(x1,y2,z1);
    
    
    x[4] = new PVector(x1,y1,z2);
    x[5] = new PVector(x2,y1,z2);
    x[6] = new PVector(x2,y2,z2);
    x[7] = new PVector(x1,y2,z2);
    
    
    //add Plane
    p.x = (x1+x2)/2;
    p.y = y2+300;
    p.z = (z1+z2)/2;
    planeL = abs(x1+x2)/2;
    planeW = abs(z1+z2)/2;
    
    addFace();
    
    
    init1();
}

void addFace(){
  //Face
    float x1 = 300, x2 = 500, y1 = 500, y2 = 600, z1 = -300, z2 = -500;
    float ox = (x1+x2)/2, oz = (z1+z2)/2 ;
    float faceL = 200, faceW = 500;
    zOffset=0;
    //face[0] = new PVector(x1-300, 900, z2+50-zOffset);
    //face[1] = new PVector(x1+300,900,z2+50-zOffset);
    //face[2] = new PVector(x1+300, 900, z1-50-zOffset);
    //face[3] = new PVector(x1-300, 900, z1-50-zOffset);
    
    face[0] = new PVector(x1-300, 900, oz-50);
    face[1] = new PVector(x1+300,900,oz-50);
    face[2] = new PVector(x1+300, 900, oz+50);
    face[3] = new PVector(x1-300, 900, oz+50);
}

void moveFace(){
  for(int i=0;i<4;i++)
        face[i].z+=zOffset;
}


void addTriangles(){
  
  //Triangle vertices
  for(int i=0;i<=1; i++){
    pT[i] = new PVector[3];
    
  }
  for(int j=0;j<=2;j++)
    pT[0][j] = face[j];
  for(int j=0;j<=2;j++)
    pT[1][j] = face[j+1];
  
  //calculate normals
  for(int i=0;i<=1; i++){
    PVector edge1 = PVector.sub(pT[i][1],pT[i][0]);
    PVector edge2 = PVector.sub(pT[i][2],pT[i][0]);
    nT[i] = edge1.cross(edge2);
    nT[i].normalize();
    
    AT[i] = (PVector.sub(pT[i][2],pT[i][0])).cross(PVector.sub(pT[i][1],pT[i][0]));   //area
  }
  
}
