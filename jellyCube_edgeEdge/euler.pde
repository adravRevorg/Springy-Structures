//calculate forces, and considering point mass , so calculating a
void calculateForces(){
  
  PVector deltaX;
  float dx;
  for(int i=0; i<N;i++)  
    a[i] = new PVector(0,0);
    
  //Spring Forces
  for(int i=0; i<N;i++){
    for(int j=i;j<N;j++){
        deltaX = PVector.sub(x[i],x[j]);
        dx = deltaX.mag() - restL[i][j];
        if (dx==0)  continue;
        float sign = dx/abs(dx);
        dx = sign*min(abs(dx),30);
        PVector springF = deltaX.mult(-1);
        springF.setMag(k*dx);
        
        a[i].add(springF);
        a[j].add(PVector.mult(springF,-1));
    }
    
    //Damping
    a[i].add(PVector.mult(v[i],-damping));
    
    //Acceleration
    a[i].add(G);
  }
}



void updateState(){
  for(int i=0;i<N;i++){
    v[i].add(a[i]);
    x[i].add(v[i]);
  }
}
