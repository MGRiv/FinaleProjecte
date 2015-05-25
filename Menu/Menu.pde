int mode;
int buttonX, buttonY;
int buttonSize = 60;
boolean start;
int counter, c2;
int tcolor, bcolor;
PImage img1;

void setup() {
  bcolor = 245;
  tcolor = 10;
  size(600, 600);
  background(bcolor);
  fill(tcolor);
  rect(width/2 - 30, height/2 - 30, buttonSize, buttonSize, 5);
  String[] fontList = PFont.list();
  println(fontList);
  PFont myFont = createFont("Mongolian Baiti", 64);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  text("PHASE SHIFT", width/2, height/3);
  img1 = loadImage("TEST2.png");
}



void draw() {
  if (mode == 0) {
    update();
    if (counter % 2 == 0) {
      tcolor = 245;
      bcolor = 10;
    } else {
      bcolor = 245;
      tcolor = 10;
    }
    background(bcolor);
    fill(tcolor);
    rect(width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5);
    rect(3*width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5);
    textSize(64);
    text("PHASE SHIFT", width/2, height/3);
    textSize(32);
    fill(bcolor);
    text("START", width/4, 3*width/4);
    text("HELP", 3*width/4, 3*width/4);
  } else if (mode == 1) {
    background(img1);
  }
}

void mousePressed() {
  if (start == true) {
    mode = 1;
  } else {
    mode = 0;
  }
}

void update() {
  if (overRectButton(width/4 - 60, 3*height/4 - 60, buttonSize, buttonSize) ||
    overRectButton(3*width/4 - 60, 3*height/4 - 60, buttonSize, buttonSize)) {
    start = true;
  } else {
    start = false;
  }
  c2++;
  if (c2 % 180 == 179) {
    counter++;
  }
}

boolean overRectButton(int x, int y, int w, int h) {
  if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) {
    return true;
  } else {
    return false;
  }
}
