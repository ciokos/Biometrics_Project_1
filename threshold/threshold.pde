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
  ratio = (float)255/350;
}

void draw() {
  background(30);
  current = threshold(image, ratio * (hs.getPos()-low_bar));
  image(current, 0, 0, current.width, current.height);
  hs.update();
  hs.display();
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

PImage threshold(PImage img, float T) {
  //create new image with height and width of the original image
  PImage thres = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //take average of red, green and blue channels
    float avg = (red(c) + green(c) + blue(c))/3;
    //compare it with T and set to white or black
    if(avg<T) {
     avg = 0;
    } else {
     avg = 255; 
    }
    //set color of the new pixel
    thres.pixels[i] =  color(avg, avg, avg);
  }
  //end work on pixels
  updatePixels();
  //return the result
  return thres;
}
