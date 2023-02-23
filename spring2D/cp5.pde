import controlP5.*;

ControlP5 cp5;

int slider_length;
int slider_height;
float xpos;

boolean reset = true;

void add_UI(){
  cp5 = new ControlP5(this);
  
  slider_length = floor(width*0.1);
  slider_height = 15;
  xpos = width*0.85;
  int p = 120, g = 22;
  
  cp5.setColorForeground(color(32,42,68));      //16,42,42
  cp5.setColorCaptionLabel(color(32,42,68));
  cp5.setColorBackground(color(53,81,92));
  
  
  cp5.addSlider("damping")
     .setPosition(xpos,p)
     .setRange(0,1)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
     
  cp5.addSlider("k")
     .setPosition(xpos,p)
     .setRange(0,0.01)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
     
  cp5.addButton("reset")
     .setValue(0)
     .setPosition(xpos,p)
     .setSize(100,slider_height)
     ; p+=g;
}

void reset(){
    if (reset)  {reset = false; return;}
    k = 0.001;
    damping = 0.99;
    pos = PVector.add(anchor,new PVector(0,restL));
}
