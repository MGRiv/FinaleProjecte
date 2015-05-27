int mode;
Button START, HELP;
int buttonSize = 60;
boolean start, hover;
int counter, c2;
int tcolor, bcolor;
PImage img1;

void setup() {
  size(600, 600);
  START=new Button(width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5, "START");
  HELP=new Button(3*width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5, "HELP");
  bcolor = 245;
  tcolor = 10;

  background(bcolor);
  fill(tcolor);
  // rect(width/2 - 30, height/2 - 30, buttonSize, buttonSize, 5);
  String[] fontList = PFont.list();
  // println(fontList);
  PFont myFont = createFont("Mongolian Baiti", 64);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  /// text("PHASE SHIFT", width/2, height/3);
  img1 = loadImage("TEST2.png");
}



void draw() {
  if (mode == 0) {
    c2++;
    if (c2 % 180 == 179) {
      counter++;
    }
    if (counter % 2 == 0) {
      tcolor = 245;
      bcolor = 10;
    } else {
      bcolor = 245;
      tcolor = 10;
    }
    processButtons();
    background(bcolor);
    fill(tcolor);
    // rect(width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5);
    // rect(3*width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5);
    textSize(64);
    text("PHASE SHIFT", width/2, height/3);
    textSize(32);
    text("PHASE SHIFT", width/2, height/3);
    fill(bcolor);
    // text("START", width/4, 3*width/4);
    // text("HELP", 3*width/4, 3*width/4);
    START.display(bcolor, tcolor);
    HELP.display(bcolor, tcolor);
  } else if (mode == 1) {
    background(img1);
  }
}

void processButtons() {
  processHovers();
  if (START.clicked()) {
    mode=1;
  } else if (HELP.clicked()) {
    mode=2;
  }
}

void processHovers() {
  if (START.inRange()) {
    System.out.println(START.c+"");
    START.setHover(true);
    START.setColor(#1CFF00);
    System.out.println(START.c+"");
  } else if (HELP.inRange()) {
    HELP.setHover(true);
    HELP.setColor(#0035FF);
  }
  if (!START.inRange()) {
    START.setHover(false);
    START.setColor(255);
  }
  if (!HELP.inRange()) {
    HELP.setHover(false);
    HELP.setColor(255);
  }
}

void mousePressed() {
  START.leftclicked();
  HELP.leftclicked();
}

void mouseReleased() {
  START.leftreleased();
  HELP.leftreleased();
}

/*
void update() {
 if (overRectButton(width/4 - 60, 3*height/4 - 60, buttonSize, buttonSize) ||
 overRectButton(3*width/4 - 60, 3*height/4 - 60, buttonSize, buttonSize)) {
 start = true;
 } else {
 start = false;
 }
 
 }
 
 boolean overRectButton(int x, int y, int w, int h) {
 if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) {
 return true;
 } else {
 return false;
 }
 }
 */
