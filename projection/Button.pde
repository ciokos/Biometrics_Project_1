class Button {
  int x;
  int y;
  int w;
  int h;
  String s;
  color backc;
  color textc;
  
  
  Button (int x, int y, int w, int h, String s) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.s = s;
  }
  
  void show() {
    fill(backc);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(textc);
    text(s, x+w/2, y+h/2);
  }
  
  void update() {
    if(mouseX < x || mouseX > x+w || mouseY < y || mouseY > y+h) {
      textc = #FFFFFF;
      backc = #0000FF;
    } else {
      textc = #000000;
      backc = #FF0000;
      if(mousePressed)
        click();
    }
    
  }
  
  void click() {
    PImage part = get(0,0,current.width,current.height);
    part.save("projection.jpeg");
    println("saved");
  }
  
}
