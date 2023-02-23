void update_state(){
  
  //calculate force
  //Note : dont update a,v,x all for a particle at once
  //First compute forces on all based on given state, then go change the state, otherwise, you would
  //be messing up states and end up getting weird results
  calculate_force();
  
  //now update everyone's velocity and pos
  for(int i=0;i<N; i++){
    v[i].add(a[i]);
    x[i].add(v[i]);
    if (x[i].y<=0){
      x[i].y = 0;
      v[i].y = 0;
    }
    
  }
  
  
}

void calculate_force(){
  for(int i=0;i<N; i++){
    
    //vertical ones
    float dy = x[i].y - restY[i];
    a[i].y = -k_vert*dy;
    
    //horizontal ones
    float dh = dist(x[i].x,x[i].z,0,0) - restH[i];
    float mag = -k_hori*dh;
    a[i].x = mag*cos(angle[i]);
    a[i].z = mag*sin(angle[i]);
    
  }
}

void keyPressed(){
  
  init();
  if (key=='y')
    addY();
  else if (key=='x')
    addX();
  else if (key=='b'){
    addX();addY();
  }
}

void addY(){
   for(int i=0; i<col; i++){
                   float dy = 5*i;
                   for(int j=0; j<row; j++){
                     int t = i*row + j;
                     x[t].y+=dy;
                   }
   }
}

void addX(){
  for(int i=0; i<col; i++){
                 float r = sqrt(restY[i]*100) + i*0.4;
                 for(int j=0; j<row; j++){
                    int t = i*row + j;
                    x[t].x = r*cos(angle[t]);
                    x[t].z = r*sin(angle[t]);
                 }
  }
}
