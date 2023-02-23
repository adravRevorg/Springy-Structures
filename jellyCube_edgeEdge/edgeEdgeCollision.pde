void collisionDetection_edgeEdge() {
    
  //all possible edges 
  int[][] fe = {{0,1}, {1,2}, {2,3}, {3,0}};      //face edges base
  int[][] oe = new int[28][2];
  boolean[] vertexCovered = new boolean[8];
  
  int index=0;
  for(int i=0; i<8; i++){
    for(int j=i+1; j<8; j++){
      oe[index][0] = i; oe[index][1] = j;
      index++;
    }
  }
  
  
  //maintain structure for collision response
  int counter = 0;
  int[] vertices = new int[8];
  PVector[] normals = new PVector[8];
  
  
  //now lets check all pairs of edges
  for(int a=0;a<4;a++){
    for(int b = 0; b<index; b++){
      
      PVector p1 = face[fe[a][0]],  p2 = face[fe[a][1]];
      PVector e1 = PVector.sub(p2,p1);
      PVector e_1 = e1.copy(); e_1.normalize();
      
      PVector q1 = S_x[oe[b][0]][0],  q2 = S_x[oe[b][1]][0];
      PVector e2 = PVector.sub(q2,q1);
      PVector e_2 = e2.copy(); e_2.normalize();
      
      PVector normal = e1.cross(e2).normalize();
      PVector q = PVector.sub(q1,p1);
      
      //determining s and t
      float s = (q.dot(e_2.cross(normal)))/(e1.dot(e_2.cross(normal)));
      float t = (-q.dot(e_1.cross(normal)))/(e2.dot(e_1.cross(normal)));
      
      PVector pc = PVector.add(p1,PVector.mult(e1,s));
      PVector qc = PVector.add(q1,PVector.mult(e2,t));
      
      if (PVector.sub(pc,qc).mag()<2)      //tolerance, ideally pc should be equal to qc if they have collided
        {
          if (oe[b][0]!=2 && oe[b][0]!=3 && oe[b][0]!=6 && oe[b][0]!=7)
            continue;
          //form a plane
          PVector q1_next = x[oe[b][0]];
          PVector qc_next = PVector.add(q1_next,PVector.mult(e2,t));
          float d0 = normal.dot(PVector.sub(qc, p1));
          float d1 = normal.dot(PVector.sub(qc_next, p1)) ;
          
          if ((d0*d1)<0.005) {
            println("edge collision", q1, q2, t, oe[b][0], oe[b][1], a , b);
            edgeCollision = true;
            
            for(int tmp=0;tmp<=1; tmp++){
                if (!vertexCovered[oe[b][tmp]]){
                  vertices[counter] = oe[b][tmp];
                  normals[counter] = normal.copy();
                  vertexCovered[oe[b][tmp]] = true;
                  counter++;
              }
            }
            
          }
         }
    }
  }
  
  //now collisionResponses
  for(int c=0; c<counter; c++)
    collisionResponse_edgeEdge(vertices[c], normals[c]);
}

void collisionResponse_edgeEdge(int vert, PVector n){
  
  //if (atRest[vert])
  //      return;
  //what's our collision response ?
  //our velocities will change
  PVector v_bc = S_v[vert][0].copy();      //bc : before collision
  PVector v_bcN = PVector.mult(n, n.dot(v_bc));  //bcN : before collision normal part
  PVector v_bcT = PVector.sub(v_bc, v_bcN);      //bcT : before collision tangential part

  //normal component would be -1*e*v
  PVector v_acN = PVector.mult(v_bcN, -e);
  PVector v_acT = PVector.mult(v_bcT, max(0, (1-cf)));
  v[vert] = PVector.add(v_acN, v_acT);
  
  //And, rather than doing partial timestep for each, 
  //since margin is quite less,
  //simply reset the position to the one at begin of this timestep
  x[vert] = S_x[vert][0].copy();
  


  if (atRest(vert, n)){
    v[vert].mult(0);
    atRest[vert] = true;
  }
}

boolean atRest(int i, PVector n){
  
  
  if (v[i].mag()>10)    return false;              //not slow enough to consider for rest (Condition 1 in book)
  
  //float d = n.dot(PVector.sub(x[i],p));
  //if (abs(d)>100)    return false;              //not near enough to the plane to consider rest  (Condition 2 in book)
  
  if (PVector.dot(a[i],n)>0.1)  return false;         //force isnt opposite to plane, ex : vertical plane (Condition 3 in book)
  
  PVector aN = PVector.mult(n,n.dot(a[i]));
  PVector aT = PVector.sub(a[i],aN);
  if ((aT.mag()-aN.mag()*cf)>0.1)               return false;     //(Condition 4 in book)
      
  
  return true;
}
