PImage image;
PImage current;
Button button;
int[] reds;
int[] greens;
int[] blues;
float[] look_reds;
float[] look_greens;
float[] look_blues;
float maxr, minr, maxg, ming, maxb, minb;

void setup() {
  size(500, 387);
  image = loadImage("../image.jpg");
  reds = new int[256];
  greens = new int[256];
  blues = new int[256];
  look_reds = new float[256];
  look_greens = new float[256];
  look_blues = new float[256];
  process();
  calculateLookUp();
  button = new Button(width - 110, height - 70, 80, 40, "Save"); 
  current = equalizeImage(image);
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

void process() {
  image.loadPixels();
  for(int i = 0; i < image.pixels.length; i++) {
    color c = image.pixels[i];
    reds[(int)red(c)]++;
    greens[(int)green(c)]++;
    blues[(int)blue(c)]++;
  }
}

void calculateLookUp() {
  //The denominator for Di's
  float den = image.width * image.height;
  //D zeros for each channel
  float D0r = reds[0]/den;
  float D0g = greens[0]/den;
  float D0b = blues[0]/den;
  //variables to cumulate probabilities
  float sumr = 0;
  float sumg = 0;
  float sumb = 0;
  //Di's for each channel
  float Dir, Dig, Dib;
  //go through every possible value
  for(int i = 0; i < 256; i++) {
    //accumulate data from histograms
    sumr += reds[i];
    sumg += greens[i];
    sumb += blues[i];
    //calculate new probs
    Dir = sumr/den;
    Dig = sumg/den;
    Dib = sumb/den;
    //use formula to fill look up tables
    look_reds[i] = (Dir-D0r)*255/(1-D0r);
    look_greens[i] = (Dig-D0g)*255/(1-D0g);
    look_blues[i] = (Dib-D0b)*255/(1-D0b);
  }
}

PImage equalizeImage(PImage img) {
  //create new image with height and width of the original image
  PImage eq = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //find every channel value using look up tables
    float r = look_reds[(int)red(c)];
    float g = look_greens[(int)green(c)];
    float b = look_blues[(int)blue(c)];
    //set color of the new pixel
    eq.pixels[i] =  color(r, g, b);
  }
  //end work on pixels
  updatePixels();
  //return the result
  return eq;
}
