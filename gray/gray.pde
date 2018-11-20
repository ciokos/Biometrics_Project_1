PImage image;
PImage current;
Button button;

void setup() {
  size(500, 387);
  image = loadImage("../image.jpg");
  button = new Button(width - 110, height - 70, 80, 40, "Save");
  current = toGray(image);
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

PImage toGray(PImage img) {
  //create new image with height and width of the original image
  PImage gray = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //take average of red, green and blue channels
    float avg = (red(c) + green(c) + blue(c))/3;
    //set color of the new pixel
    gray.pixels[i] = color(avg, avg, avg);
  }
  //end work on pixels
  updatePixels();
  //return the result
  return gray;
}
