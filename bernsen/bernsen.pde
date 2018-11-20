PImage image;
PImage gray;
PImage current;
HScrollbar hs1;
HScrollbar hs2;
float ratio1, ratio2;
Button button;
int low_bar = 20;
int width_bar = 350;

void setup() {
  size(500, 387);
  image = loadImage("../image.jpg");
  hs1 = new HScrollbar(low_bar, height-70, width_bar, 16, 1);
  hs2 = new HScrollbar(low_bar, height-30, width_bar, 16, 1);
  button = new Button(width - 110, height - 70, 80, 40, "Save"); 
  ratio1 = (float)10/width_bar;
  ratio2 = (float)255/width_bar;
  gray = toGray(image);
  //current = bernsen(image, 2, 15);
  //image(current, 0, 0, w, h);
}

void draw() {
  background(30);
  current = bernsen(image, (int)(ratio1 * (hs1.getPos()-low_bar) + 1), ratio2 * (hs2.getPos()-low_bar));
  image(current, 0, 0, current.width, current.height);
  hs1.update();
  hs1.display();
  hs2.update();
  hs2.display();
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

float findT(PImage img, int x, int y, int size) {
  //x and y are coordinates of the center pixl
  //size is distance from the center not the width of the window
  //result
  float ret;
  //minimum in the window
  float min = 255;
  //maximum in the window
  float max = 0;
  //find left top corner of the window
  int startx = x-size;
  int starty = y-size;
  //loop through the window
  for(int i = 0; i < size*2+1; i++) {
    for(int j = 0; j < size*2+1; j++) {
       //find column and row
       int col = j + startx;
       int row = i + starty;
       //check if they are in the image
       if(col < 0 || col > img.width-1 || row < 0 || row > img.height-1)
         continue;
       //take grayness level from the current pixel
       color c = img.pixels[row*img.width+col];
       float grayness = red(c);
       //check if it's a new min or max
       if(grayness < min)
         min = grayness;
       if(grayness > max)
         max = grayness;
    }
  }
  //use the formula
  ret = (min+max)/2;
  //return the result
  return ret;
}

PImage bernsen(PImage img, int N, float limit) {
  //create new image with height and width of the original image
  PImage thres = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for(int i = 0; i < img.height; i++) {
    for(int j = 0; j < img.width; j++) {
      //take color of the original pixel
      color c = img.pixels[i*img.width + j];
      //find T value for the current pixel
      float T = findT(img, j, i, N);
      //compare with limit
      if(T<limit)
        T=limit;
      //black or white value
      float val;
      //compare grayness level with T and set to white or black
      if(red(c)<T) {
       val = 0;
      } else {
       val = 255; 
      }
      //set color of the new pixel
      thres.pixels[i*img.width + j] =  color(val);
    }
  }
  //end work on pixels
  updatePixels();
  //return the result
  return thres;
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
