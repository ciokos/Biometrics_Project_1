PImage image;
PImage current;
HScrollbar hs;
float ratio;
Button button;
int low_bar = 20;
int width_bar = 350;

void setup() {
  size(500, 387);
  image = loadImage("../image.jpg");
  hs = new HScrollbar(low_bar, height-50, width_bar, 16, 1);
  button = new Button(width - 110, height - 70, 80, 40, "Save"); 
  ratio = (float)510/350;
}

void draw() {
  background(30);
  current = brighten(image, ratio * (hs.getPos()-low_bar) - 255);
  image(current, 0, 0, current.width, current.height);
  hs.update();
  hs.display();
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

void truncate(float c) {
 if(c>255){
  c=255;
 } else if(c<0) {
  c=0; 
 }
}

PImage brighten(PImage img, float arg) {
  //create new image with height and width of the original image
  PImage brig = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //add argument to every channel
    float r = red(c) + arg;
    float g = green(c) + arg;
    float b = blue(c) + arg;
    //truncate vaues
    truncate(r);
    truncate(g);
    truncate(b);
    //set color of the new pixel
    brig.pixels[i] =  color(r, g, b);
  }
  //end work on pixels
  updatePixels();
  //return the result
  return brig;
}
