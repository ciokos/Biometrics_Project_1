PImage image;
PImage current;
Button button;
float[][] v = {{0,0,0}, {0,1,0}, {0,0,-1}};
float[][] h = {{0,0,0}, {0,0,1}, {0,-1,0}};

void setup() {
  size(500, 387);
  image = loadImage("../Bikesgray.jpg");
  button = new Button(width - 110, height - 70, 80, 40, "Save");
  current = roberts(image);
  image(current, 0, 0, current.width, current.height);
}

void draw() {
  //background(30);
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

PImage roberts(PImage img) {
  //create new image with height and width of the original image
  PImage fil = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for(int i = 0; i < img.height; i++) {
    for(int j = 0; j < img.width; j++) {
      float val = filtering(img, j, i);
      fil.pixels[i*img.width + j] =  color(val);
    }
  }
  //end work on pixels
  updatePixels();
  //return the result
  return fil;
}

float filtering(PImage img, int x, int y) {
  float resv = 0;
  float resh = 0;
  for(int i = 0; i < 3; i++) {
    for(int j = 0; j < 3; j++) {
       //find column and row
       int col = j + x - 1;
       int row = i + y - 1;
       //check if they are in the image
       if(col < 0 || col > img.width-1 || row < 0 || row > img.height-1)
         continue;
       //take grayness level from the current pixel
       color c = img.pixels[row*img.width+col];
       float grayness = red(c);
       resv += grayness*v[j][i];
       resh += grayness*h[j][i];
    }
  }
  return abs(resh)+abs(resv);
}
