PImage image;
PImage current;
Button button;
int[] reds;
int[] greens;
int[] blues;
float maxr, minr, maxg, ming, maxb, minb;

void setup() {
  size(500, 387);
  image = loadImage("../lesscontrast.jpeg");
  reds = new int[256];
  greens = new int[256];
  blues = new int[256];
  process();
  calculateMinMax();
  button = new Button(width - 110, height - 70, 80, 40, "Save"); 
  current = expandImage(image);
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

PImage expandImage(PImage img) {
  //create new image with height and width of the original image
  PImage exp = createImage(img.width, img.height, RGB);
  //begin work on pixel level
  loadPixels();
  //loop through every pixel
  for (int i=0; i<img.pixels.length; i++) {
    //take color of the original pixel
    color c = img.pixels[i];
    //compute every channel using the formula
    float r = 255/(maxr-minr)*(red(c)-minr);
    float g = 255/(maxg-ming)*(green(c)-ming);
    float b = 255/(maxb-minb)*(blue(c)-minb);
    //set color of the new pixel
    exp.pixels[i] =  color(r, g, b);
  }
  //end work on pixels
  updatePixels();
  //return the result
  return exp;
}

void calculateMinMax() {
 for(int i = 0; i<reds.length; i++) {
   if(reds[i] != 0) {
     minr = i;
     break;
   }
 }
  for(int i = 0; i<greens.length; i++) {
   if(greens[i] != 0) {
     ming = i;
     break;
   }
 }
  for(int i = 0; i<blues.length; i++) {
   if(blues[i] != 0) {
     minb = i;
     break;
   }
 }
 for(int i = reds.length-1; i>=0; i--) {
   if(reds[i] != 0) {
     maxr = i;
     break;
   }
 }
 for(int i = greens.length-1; i>=0; i--) {
   if(greens[i] != 0) {
     maxg = i;
     break;
   }
 }
 for(int i = blues.length-1; i>=0; i--) {
   if(blues[i] != 0) {
     maxb = i;
     break;
   }
 }
}
