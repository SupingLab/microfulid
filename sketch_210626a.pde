//Fluorescence statistics script
import java.util.*;
PFont font;
PImage[] channels;
int n;
float threshold;
int counter;
PGraphics alphaG;
float total = 0;
float exp;
float sum;
ArrayList<Integer> numberList;
void setup() {
  size(976, 736);
  n = 200;
  channels = new PImage[n];
  font = createFont("Arial", 2);
  textFont(font, 18);
  noCursor();
  for(int i = 0; i < n; ++i) 
  {
    if(i < 10)
      channels[i] = loadImage("000" + str(i) + ".jpg");
    else if(i < 100)
      channels[i] = loadImage("00" + str(i) + ".jpg");
    else
      channels[i] = loadImage("0" + str(i) + ".jpg");
  }
  threshold = 220;
  counter = 0;
  numberList = new ArrayList<Integer>();
}
void draw() {
  background(255);
  for(int i = 0; i < n; ++i) {
    for(int y = 0; y < height; y++) {
      for(int x = 0; x < width; x++) {
        int loc = x + y * width;
        float b = brightness(channels[i].pixels[loc]);
        if(b > threshold) {
          counter++;
        }
      }     
      numberList.add(counter);
      strokeWeight(1);
      stroke(map(i, 0, n, 50, 255), 0, 0, map(i, 0, 10, 255, 50));
      float d = 0.62;
      line(20 + d * width * i / n, y, 2 * counter + 20 + d * width * i / n, y);
      counter = 0;
    }
    for(int k = numberList.size() - 1; k >= 0; k--) {
      sum += numberList.get(k);
    }
    for(int j = numberList.size() - 1; j >= 0; j--) {
      total += j * numberList.get(j);
    }
    exp = total / sum;
    println(exp / 736);
    strokeWeight(2);
    fill(0);
    total = 0;
    println(sum);
    sum = 0;
    numberList.clear();
  }
  noLoop();
}

void keyPressed() {
  save("sta.tiff");
}
