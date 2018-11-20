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
  current = contrast(image, ratio * (hs.getPos()-low_bar)-255);
  image(current, 0, 0, current.width, current.height);
  hs.update();
  hs.display();
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

PImage contrast(PImage img, float arg) {
  //create new image with height and width of the original image
  PImage contr = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //calculate the contrasting factor
    float factor = (259 * (arg + 255)) / (255 * (259 - arg));
    //calculate new values
    float r = factor * (red(c) - 128) + 128;
    float g = factor * (green(c) - 128) + 128;
    float b = factor * (blue(c) - 128) + 128;
    //set color of the new pixel
    contr.pixels[i] =  color(r, g, b);
  }
  //end work on pixels
  updatePixels();
  //return the result
  return contr;
}
