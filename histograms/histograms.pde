import org.gicentre.utils.stat.*;

PImage image;
Button button;
float[] reds;
float[] greens;
float[] blues;
String name = "red";
String[] labels;
BarChart barChart;

void setup() {
  size(550, 500);
  image = loadImage("../image.jpg");
  //image = loadImage("../expanded.jpeg");
  //image = loadImage("../lesscontrast.jpeg");
  //image = loadImage("../equalized.jpeg");
  reds = new float[256];
  greens = new float[256];
  blues = new float[256];
  labels = new String[256];
  fillZero();
  process();
  
  barChart = new BarChart(this);
  barChart.setData(reds);
  barChart.setBarColour(color(255,0,0));
  barChart.setBarGap(0);
  barChart.setBarLabels(labels);
  barChart.setAxisValuesColour(0);     
  barChart.showValueAxis(true);
  barChart.showCategoryAxis(true);
  //barChart.setMinBorder(2, AbstractChart.Side);
  button = new Button(width - 110, height - 50, 80, 40, "Save");
}

void draw() {
  background(255);
  barChart.draw(0,0,width-30,height-70); 
  button.update();
  button.show();
}

void mousePressed() {
  button.update();
}

void fillZero() {
  for(int i = 0; i < 256; i++) {
    reds[i] = 0;
    greens[i] = 0;
    blues[i] = 0;
    labels[i] = "";
  }
  labels[0] = "0";
  labels[254] = "255";
}

void process() {
  //start work on pixels
  image.loadPixels();
  //loop through every pixel
  for(int i = 0; i < image.pixels.length; i++) {
    //take color value of a pixel
    color c = image.pixels[i];
    //increase corresponding values in arrays
    reds[(int)red(c)]++;
    greens[(int)green(c)]++;
    blues[(int)blue(c)]++;
  }
}

void keyPressed() {
  switch(key) {
    case '1':
      barChart.setData(reds);
      barChart.setBarColour(color(255,0,0));
      name = "red";
      break;
    case '2':
      barChart.setData(greens);
      barChart.setBarColour(color(0,255,0));
      name = "green";
      break;
    case '3':
      barChart.setData(blues);
      barChart.setBarColour(color(0,0,255));
      name = "blue";
      break;
  }
}
