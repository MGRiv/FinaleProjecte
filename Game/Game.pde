import java.util.*;
import java.io.*;
import java.lang.*;

//------------------MENU
int mode;
Button START, HELP;
int buttonSize = 60;
boolean start, hover;
int counter, c2;
int tcolor, bcolor;
PImage img1;
//-------------------------GAMEPLAY
private Player you;
private boolean rightPressed, leftPressed, upPressed, downPressed;
private boolean rightReleased, leftReleased, upReleased, downReleased;
private int pos;
private int dirc;
private boolean moved;
private Location current;
private Scanner file;
private String line;
private int fcount;
private Character[] firstNPCs;
private String zbutton;
//-------------------------DIALOGUE
long lastTime;
String words;
boolean zPressed;
int nextset;
ArrayList<String> sets;


void setup() {
  //---------------------------GAMEPLAY
  firstNPCs=new Character[10];
  firstNPCs[0]=new Character("Boy1");
  firstNPCs[0].setX(200);
  firstNPCs[0].setY(200);
  firstNPCs[0].setDir(40);
  firstNPCs[0].setPosD(0);
  firstNPCs[0].setText("Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world.");

  zbutton="DoNothing";
  size(600, 600);
  current = new Location(0, 578, 0, 580);
  you=new Player("Link");
  System.out.println(you.getName());
  pos=0;
  you.setX(width/2);
  you.setY(height/2);
  you.setPosD(0);
  dirc = 40;
  //-----------------------------MENU
  START=new Button(width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5, "START");
  HELP=new Button(3*width/4 - 60, 3*height/4 - 60, 2*buttonSize, 2*buttonSize, 5, "HELP");
  bcolor = 245;
  tcolor = 10;
  background(bcolor);
  fill(tcolor);
  //String[] fontList = PFont.list();
  PFont myFont = createFont("Mongolian Baiti", 64);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  //-----------------------------DIALOGUE
  sets=new ArrayList<String>(1);
  dialogue(firstNPCs[0].getText()); 
  lastTime=millis();
  nextset=0;
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
    textSize(64);
    text("PHASE SHIFT", width/2, height/3);
    textSize(32);
    text("PHASE SHIFT", width/2, height/3);
    fill(bcolor);
    START.display(bcolor, tcolor);
    HELP.display(bcolor, tcolor);
  } else if (mode == 1) {
    background(254);
    PImage bg=loadImage("Locations/0.png");
    image(bg, 0, 0, 600, 600);

    firstNPCs[0].display();

    you.display();
    processKeys();
    interact();
    if (zbutton=="Talk") {

      newTextBox(firstNPCs[0].getName());
      textAlign(LEFT);
      text(sets.get(nextset), width/24+75, height*3/4+30);
      talk();
    }
    System.out.println(zbutton);
    if (current.getScene()) {
      current.setScene(false);
      runFile();
      fcount++;
    }
  } else if (mode==2) {
    loadInstructions();
    processButtons();
    START.display(bcolor, tcolor);
  }
}

//---------------------------MENU STUFF

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

    START.setHover(true);
    START.setHighlight(#1CFF00);
  } else if (HELP.inRange()) {
    HELP.setHover(true);
    HELP.setHighlight(#0035FF);
  }
  if (!START.inRange()) {
    START.setHover(false);
  }
  if (!HELP.inRange()) {
    HELP.setHover(false);
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

void loadInstructions() {
  background(#A7BFFF);
  textSize(24);
  text("Instructions", 100, 50);
  textSize(16);
  text("Use the arrow keys to move and Z to go to the next when talking to NPCs", 300, 200);
}

//--------------------------------------GAME STUFF

void processKeys() {

  if (downPressed) {
    if (you.getY() < current.getBD()) {
      you.setY(you.getY()+2.0);
      pos++;
      dirc = 40;
    }
  }
  if (upPressed) {
    if (you.getY() > current.getBU()) {
      you.setY(you.getY()-2.0);
      pos++;
      dirc = 38;
    }
  }
  if (rightPressed) {
    if (you.getX() < current.getBR()) {
      you.setX(you.getX()+2.0);
      pos++;
      dirc = 39;
    }
  }
  if (leftPressed) {
    if (you.getX() > current.getBL()) {
      you.setX(you.getX()-2.0);
      pos++;
      dirc = 37;
    }
  }
  if (zPressed) {
    interact();
  }
  if (dirc == 37) {
    you.setPosL(pos % 10);
  } else if (dirc == 39) {
    you.setPosR(pos % 10);
  } else if (dirc == 38) {
    you.setPosU(pos % 10);
  } else if (dirc == 40) {
    you.setPosD(pos % 10);
  }
  you.setDir(dirc);
  System.out.println("" + (int)you.getX() + ", " + (int)you.getY());
}

void keyReleased() {
  if (keyCode==37) {
    leftPressed=false;
  } else if (keyCode==38) {
    upPressed=false;
  } else if (keyCode==39) {
    rightPressed=false;
  } else if (keyCode==40) {
    downPressed=false;
  } else if (keyCode==90) {
    zPressed=false;
  }
}

void keyPressed() {
  if (keyCode==37) {
    leftPressed=true;
  } else if (keyCode==38) {
    upPressed=true;
  } else if (keyCode==39) {
    rightPressed=true;
  } else if (keyCode==40) {
    downPressed=true;
  } else if (keyCode==90) {
    zPressed=true;
  } else {
    downPressed = zPressed = rightPressed = leftPressed = upPressed = false;
  }
}

void runFile() {
  file = new Scanner("scene"+fcount+".txt");
  while (file.hasNextLine ()) {
    line = file.nextLine();
    String[] commands = split(line, ", ");
    if (commands[0].equals("MOVE")) {
      Character temp = findCharacter(commands[1]);
      temp.move(Integer.valueOf(commands[2]), Integer.valueOf(commands[3]));
    } else {
      dialogue(commands[2]);
      newTextBox(commands[1]);
      textSize(16);
      text(sets.get(nextset), width/24+100, height*3/4+30);
    }
  }
}

void dialogue(String text) {
  String list[]=split(text, ' ');
  String str="";
  int counter=0;
  int lines=0;
  for (String word : list) {
    if (word.length()+counter>=38) {
      lines+=1;
      str+="\n";
      counter=0;
    }
    if (lines>=3) {
      sets.add(str);
      counter=0;
      str="";
      lines=0;
    }
    str+=word+" ";
    counter+=word.length();
  }
  if (str.length()!=0) {
    sets.add(str);
  }
}

void talk() {
  if (zPressed) {
    zPressed=false;
    nextset++;
    if (nextset==sets.size()) {
      zbutton="DoNothing";
      nextset=0;
      textAlign(CENTER, CENTER);
      // sets=new ArrayList<String>(1);
    }
  }
}

void newTextBox(String person) {
  fill(0);
  stroke(255, 300);
  strokeWeight(4);
  rect(width/24, height*3/4, width-width/12, height/5, 30);
  fill(255);
  textSize(24);
  textAlign(CENTER);
  text(person + ":", width/24+40, height*3/4 + 25);
}

void interact() {

  if (you.getDir()==37) { //if you're facing left
    if (firstNPCs[0].getX()==you.getX()-24 &&
      firstNPCs[0].getY()<=you.getY()+14 && firstNPCs[0].getY()>=you.getY()-14) {


      firstNPCs[0].setPosR(0);
      firstNPCs[0].setDir(39);
      zbutton="Talk";
    }
  } else if (you.getDir()==38) { //if you're facing up
    if (firstNPCs[0].getY()==you.getY()-24 && 
      firstNPCs[0].getX()<=you.getX()+14 && firstNPCs[0].getX()>=you.getX()-14) {


      firstNPCs[0].setPosD(0);
      firstNPCs[0].setDir(40);
      zbutton="Talk";
    }
  } else if (you.getDir()==39) { //if you're facing right
    if (firstNPCs[0].getX()==you.getX()+24 && 
      firstNPCs[0].getY()<=you.getY()+14 && firstNPCs[0].getY()>=you.getY()-14) {


      firstNPCs[0].setPosL(0);
      firstNPCs[0].setDir(37);
      zbutton="Talk";
    }
  } else if (you.getDir()==40) { //if you're facing down
    if (firstNPCs[0].getY()==you.getY()+24 && 
      firstNPCs[0].getX()<=you.getX()+14 && firstNPCs[0].getX()>=you.getX()-14) {


      firstNPCs[0].setPosU(0);
      firstNPCs[0].setDir(38);
      zbutton="Talk";
    }
  }
}

public Character findCharacter(String name) {
  Character[] l = current.getNPC();
  for (int p = 0; p < l.length; p++) {
    if (l[p].getName().equals(name)) {
      return l[p];
    }
  }
  return you;
}

public void wait(int t) {
  int s = millis();
  while (millis () - s < t);
}

