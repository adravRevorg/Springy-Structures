void draw(){
    background(0);//53,81,100);
    //background(153,255,255);
    if (!ready)
        return;
   // camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
    translate(0,500,-width*0.35);
    
    
    drawState();
    
    fill(255);
    if (euler){
      
        text("EULER", 20,20);
        RK1();
        for(int i=0;i<N;i++)
          updateState_RK1(i);
    }else{
      text("Range-Kutta4", 20,20);
      RK1();RK2();RK3();RK4();
            
        for(int i=0;i<N;i++)
          updateState_RK4(i);
      
      
    }
    
    saveFrame("frames/####.tif"); 
}
