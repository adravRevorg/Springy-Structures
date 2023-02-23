void draw(){
    
    //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
    translate(400,200,-200);
    drawState();
    
    //if (vertexCollision || edgeCollision)
    //  return;
    
      vertexCollision = false;
      edgeCollision = false;
      RK1();RK2();RK3();RK4();
            
      for(int i=0;i<N;i++){
        
          updateState_RK4(i);
      }
      if (!vertexCollision)
        collisionDetection_edgeEdge();
    //saveFrame("frames/####.tif"); 
}
