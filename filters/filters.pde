PImage image;
PImage current;
Button button;
float[][] averaging = {{1.0/9.0,1.0/9.0,1.0/9.0},
                      {1.0/9.0,1.0/9.0,1.0/9.0},
                      {1.0/9.0,1.0/9.0,1.0/9.0}};
float[][] gauss = {{1.0/16.0,1.0/8.0,1.0/16.0},
                  {1.0/8.0,1.0/4.0,1.0/8.0},
                  {1.0/16.0,1.0/8.0,1.0/16.0}};
float[][] sharpening = {{-1.0,-1.0,-1.0},
                        {-1.0,9.0,-1.0},
                        {-1.0,-1.0,-1.0}};
float[][] kernel;
//float[][] sobel0;
//float[][] sobel45;
//float[][] sobel90;
//float[][] sobel135;

void setup() {
  size(500, 387);
  image = loadImage("../grayed.jpeg");
  button = new Button(width - 110, height - 70, 80, 40, "Save");
  //Here change the kernels:
  kernel = averaging;
  current = filtered(image, kernel);
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

PImage filtered(PImage img, float[][] ker) {
  //create new image with height and width of the original image
  PImage fil = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for(int i = 0; i < img.height; i++) {
    for(int j = 0; j < img.width; j++) {
      float val = filtering(img, j, i, ker);
      fil.pixels[i*img.width + j] =  color(val);
    }
  }
  //end work on pixels
  updatePixels();
  //return the result
  return fil;
}

float filtering(PImage img, int x, int y, float[][] ker) {
  float res = 0;
  //loop through the window
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
       //use the kernel and sum
       res += grayness*ker[j][i];
    }
  }
  return res;
}
