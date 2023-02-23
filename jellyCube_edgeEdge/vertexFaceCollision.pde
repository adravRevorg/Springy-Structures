
//collision detection 
//if yes, determine f (fraction of timestep) 
//if no, return -1
float collisionDetection(int i, PVector p, PVector n) {

   
   float d0 = n.dot(PVector.sub(S_x[i][0], p));
   float d1 = n.dot(PVector.sub(x[i], p)) ;
  
   if ((d0*d1)<0.005) {
        
        float f = abs(d0)/(abs(d0)+abs(d1));
        //noLoop();
        return f;
  }
  return -1;
}

void collisionResponse(int i, PVector n) {

  
  PVector v_bc = v[i].copy();      //bc : before collision
  PVector v_bcN = PVector.mult(n, n.dot(v_bc));  //bcN : before collision normal part
  PVector v_bcT = PVector.sub(v_bc, v_bcN);      //bcT : before collision tangential part

  //normal component would be -1*e*v
  PVector v_acN = PVector.mult(v_bcN, -e);
  PVector v_acT = PVector.mult(v_bcT, max(0, (1-cf)));
  v[i] = PVector.add(v_acN, v_acT);
  
  //And, rather than doing partial timestep for each, 
  //since margin is quite less,
  //simply reset the position to the one at begin of this timestep
  x[i] = S_x[i][0].copy();
  
  if (atRest(i)){
    v[i].mult(0);
    atRest[i] = true;
  }
}

boolean atRest(int i){
  
  
  if (v[i].mag()>30)    return false;              //not slow enough to consider for rest (Condition 1 in book)
  
  float d = n.dot(PVector.sub(x[i],p));
  if (abs(d)>100)    return false;              //not near enough to the plane to consider rest  (Condition 2 in book)
  
  if (PVector.dot(a[i],n)>0.1)  return false;         //force isnt opposite to plane, ex : vertical plane (Condition 3 in book)
  
  PVector aN = PVector.mult(n,n.dot(a[i]));
  PVector aT = PVector.sub(a[i],aN);
  if ((aT.mag()-aN.mag()*cf)>0.1)               return false;     //(Condition 4 in book)
      
  
  return true;
}

boolean insideTriangle(int i, PVector[] p, int I){
  
      //if (plane)
      //    return true;
      //area for p0
      PVector A0 = (PVector.sub(x[i],p[0])).cross(PVector.sub(p[1],p[0]));
      //area for p1
      PVector A1 = (PVector.sub(x[i],p[1])).cross(PVector.sub(p[2],p[1]));
      //area for p2
      PVector A2 = (PVector.sub(x[i],p[2])).cross(PVector.sub(p[0],p[2]));
      
      float area = (A0.mag() + A1.mag() + A2.mag());
      if (abs(area-AT[I].mag())<7)  {
        return true;
      }
      
      return false;
}
