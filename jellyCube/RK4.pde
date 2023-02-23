void RK1( ){
 
  for(int i=0; i<N;i++){ 
    S_x[i][0] = x[i].copy();
    S_v[i][0] = v[i].copy();
    
    RK_v[i][0] = v[i].copy();
  }
  calculateForce_RK4(0);
}

void RK2(){
  //RK2
  //new state would be something like :
  for(int i=0; i<N;i++){ 
    S_x[i][1] = PVector.add(S_x[i][0],PVector.mult(RK_v[i][0], h/2));
    S_v[i][1] = PVector.add(S_v[i][0], PVector.mult(RK_a[i][0], h/2));
    
    RK_v[i][1] = S_v[i][1].copy();
    
  }
  calculateForce_RK4(1);
}

void RK3(){
  
  //RK3
  for(int i=0; i<N;i++){ 
    S_x[i][2] = PVector.add(S_x[i][0],PVector.mult(RK_v[i][1], h/2));
    S_v[i][2] = PVector.add(S_v[i][0], PVector.mult(RK_a[i][1], h/2));
    
    RK_v[i][2] = S_v[i][2].copy();
    
  }
  calculateForce_RK4(2);
}

void RK4(){
  
  //RK4
  for(int i=0; i<N;i++){ 
    S_x[i][3] = PVector.add(S_x[i][0],PVector.mult(RK_v[i][2], h));
    S_v[i][3] = PVector.add(S_v[i][0], PVector.mult(RK_a[i][2], h));
    
    RK_v[i][3] = S_v[i][3].copy();
    
  }
  calculateForce_RK4(3);
  
}

void updateState_RK4(int i){
  
  a[i] = new PVector(0,0,0);
  for(int j=0;j<4;j++){
    if (j==1||j==2){
          RK_v[i][j].mult(2);
          RK_a[i][j].mult(2);
    }
    RK_v[i][j].mult(h/6.0);
    RK_a[i][j].mult(h/6.0);
    x[i].add(RK_v[i][j]);
    v[i].add(RK_a[i][j]);
    a[i].add(RK_a[i][j]);
  }
  
  if (collisionDetection(i)!=-1){
    //print("COLLISION");
    collisionResponse(i);
    vertexCollision = true;
  }
}

void calculateForce_RK4(int rk){
    PVector deltaX;
    float dx;
    for(int i=0; i<N;i++)  
      RK_a[i][rk] = new PVector(0,0);
      
    
    
    for(int i=0; i<N;i++){
      
      //Spring Forces
      for(int j=0;j<N;j++){
          if (i==j)
            continue;
          deltaX = PVector.sub(S_x[i][rk],S_x[j][rk]);
          dx = deltaX.mag() - restL[i][j];
          if (dx==0)  continue;
          float sign = dx/abs(dx);
          float maxStretch = restL[i][j]/10.0;
          dx = sign*min(abs(dx),maxStretch);
          PVector springF = deltaX.mult(-1);
          springF.setMag(k*dx);
          
          RK_a[i][rk].add(springF);
          RK_a[j][rk].add(PVector.mult(springF,-1));
      }
      
      //Damping
      if (RK_a[i][rk].mag()!=0)
        RK_a[i][rk].add(PVector.mult(S_v[i][rk],-damping));
      
      //Other forces : ex: gravity etc
      RK_a[i][rk].add(G);
    }
    
    
    
}
