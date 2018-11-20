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
  current = treshold(image, ratio * (hs.getPos()-low_bar));
  image(current, 0, 0, current.width, current.height);
  project(current);
  hs.update();
  hs.display();
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

PImage treshold(PImage img, float T) {
  PImage tres = createImage(img.width, img.height, RGB);
  loadPixels();
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    float avg = (red(c) + green(c) + blue(c))/3;
    if(avg<T) {
     avg = 0;
    } else {
     avg = 255; 
    }
    tres.pixels[i] =  color(avg, avg, avg);
  }
  updatePixels();
  return tres;
}

void project(PImage binary) {
  //arrays for counting black pixels
  float[] horizontal = new float[binary.width];
  float[] vertical = new float[binary.height];
  //fill arrays with zeros
  for(int i = 0; i<binary.width; i++) {
    horizontal[i] = 0;
  }
  for(int i = 0; i<binary.height; i++) {
    vertical[i] = 0;
  }
  //start working on pixels
  loadPixels();
  //loop through rows
  for (int i=0; i<binary.height; i++) {
    //loop through columns
    for (int j=0; j<binary.width; j++) {
      //take color of a pixel
      color c = binary.pixels[i*binary.width + j];
      //since when black all channels are 0
      //I can look at only one of them
      if(red(c)==0) {
        //if the pixel is black increase count in corresponding
        //place in the arrays
        //I add 0.2 to scale the projections down
        horizontal[j]+=0.2;
        vertical[i]+=0.2;
      }
    }
  }
  //choose red color with some alpha
  stroke(255, 0, 0, 150);
  //draw lines for every pixel column
  for(int i = 0; i<binary.width; i++) {
    line(i, 0, i, horizontal[i]);
  }
  //choose blue color with some alpha
  stroke(0, 0, 255, 150);
  //draw lines for every pixel row
  for(int i = 0; i<binary.height; i++) {
    line(0, i, vertical[i], i);
  }
}
