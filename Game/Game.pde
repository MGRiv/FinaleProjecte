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
//-------------------------DIALOGUE
long lastTime;
String words;
boolean zPressed;
int nextset;
ArrayList<String> sets;


void setup() {
  //---------------------------GAMEPLAY
  size(600, 600);
  current = new Location();
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
    you.display();
    processKeys();
    if (current.getScene()) {
      current.setScene(false);
      runFile();
      fcount++;
    }
  }
}

//---------------------------MENU STUFF

void processButtons() {
  processHovers();
  if (START.clicked()) {
    mode=1;
  } else if (HELP.clicked()) {
    mode=1;
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

//--------------------------------------GAME STUFF

void processKeys() {
  if (downPressed) {
    if (you.getY() < current.getBD())
      you.setY(you.getY()+2.0);
    pos++;
    dirc = 40;
  }
  if (upPressed) {
    if (you.getY() > current.getBU())
      you.setY(you.getY()-2.0);
    pos++;
    dirc = 38;
  }
  if (rightPressed) {
    if (you.getX() < current.getBR())
      you.setX(you.getX()+2.0);
    pos++;
    dirc = 39;
  }
  if (leftPressed) {
    if (you.getX() > current.getBL())
      you.setX(you.getX()-2.0);
    pos++;
    dirc = 37;
  }
  if (zPressed) {
    zPressed=false;
    nextset++;
    if (nextset==sets.size()) {
      mode=1;
    }
    if (mode==0) {
      text(sets.get(nextset), width/24+100, height*3/4+30);
    }
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
  System.out.println("" + (int)you.getX() + "," + (int)you.getY());
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
    String[] commands = split(line, ",");
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
  //System.out.println("START...........................................................................................");
  String list[]=split(text, ' ');
  String str="";
  int counter=0;
  int lines=0;
  for (String word : list) {

    if (word.length()+counter>=46) {
      lines+=1;
      str+="\n";
      counter=0;
    } else if (lines==3) {
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

void newTextBox(String person) {
  fill(0);
  stroke(255, 300);
  strokeWeight(4);
  rect(width/24, height*3/4, width-width/12, height/5, 30);
  fill(255);
  textSize(24);
  text(person + ":", width/24+30, height*3/4+70);
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

