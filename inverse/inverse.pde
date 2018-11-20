PImage image;
PImage current;
Button button;

void setup() {
  size(500, 387);
  image = loadImage("../image.jpg");
  button = new Button(width - 110, height - 70, 80, 40, "Save");
  current = invertColor(image);
}

void draw() {
  background(30);
  image(current, 0, 0, current.width, current.height);
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

PImage invertColor(PImage img) {
  //create new image with height and width of the original image
  PImage inv = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //set color in output image by taking difference between 255 and channel value
    inv.pixels[i] =  color(255-red(c), 255-green(c), 255-blue(c));
  }
  //end work on pixels
  updatePixels();
  //return the result
  return inv;
}
