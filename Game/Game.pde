import java.util.*;
import java.io.*;
import java.lang.*;

//------------------MENU
int mode;
Button START, HELP;
int buttonSize = 60;
boolean start, hover, open;
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
private String prev;
private Scanner file;
private String line;
private int fcount;
private Character[] firstNPCs;
private String zbutton;
private Location[] maps;
private ArrayList<Item> testItems;
private ArrayList<Item> inventory;
//-------------------------DIALOGUE
long lastTime;
String words;
boolean zPressed;
int nextset;
ArrayList<String> sets;


void setup() {
  //---------------------------GAMEPLAY
  firstNPCs=new Character[1];
  firstNPCs[0]=new Character("Boy1");
  firstNPCs[0].setX(200);
  firstNPCs[0].setY(200);
  firstNPCs[0].setDir(40);
  firstNPCs[0].setPosD(0);
  firstNPCs[0].setText("Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world.");
  PImage bg=loadImage("Locations/0.png");
  zbutton="DoNothing";
  size(600, 600);
  current = new Location(66, 502, 74, 502, firstNPCs, bg, false);
  current.setName("Start");

  Location[] newLinks=new Location[1];
  Location[] otherLinks=new Location[1];
  otherLinks[0]=current;
  otherLinks[0].setNodeX(60);
  otherLinks[0].setNodeY(285);
  newLinks[0]=new Location(92, 464, 62, 524, firstNPCs, loadImage("Locations/1.png"), false);
  newLinks[0].setName("class");
  newLinks[0].setNodeX(504);
  newLinks[0].setNodeY(205);
  current.setLinks(newLinks);
  newLinks[0].setLinks(otherLinks);
  you=new Player("Link");
  System.out.println(you.getName());
  pos=0;
  you.setX(width/2);
  you.setY(height/2);
  you.setPosD(0);
  dirc = 40;
  prev="";
  maps=new Location[10];
  inventory=new ArrayList<Item>(1);
  testItems=new ArrayList<Item>(1);
  testItems.add(new Item("J", loadImage("Letters/0.png"), 75, 75));
  testItems.add(new Item("O", loadImage("Letters/1.png"), 100, 100));
  testItems.add(new Item("H", loadImage("Letters/2.png"), 150, 150));
  testItems.add(new Item("N", loadImage("Letters/3.png"), 400, 200));

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
  dialogue(current.getNPC(0).getText()); 
  lastTime=millis();
  nextset=0;
}

void draw() {
  System.out.println(keyCode);
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
    image(current.getBackground(), 0, 0, 600, 600);
    current.getNPC(0).display();


    pickup();
    if (you.getHuzzah()) {
      yay();
      you.display();
    }
    you.setHuzzah(false);
    you.display();
    processKeys();
    interact();

    if (zbutton=="Talk") {

      newTextBox(current.getNPC(0).getName());
      textAlign(LEFT);
      text(sets.get(nextset), width/24+75, height*3/4+30);
      talk();
    }
    if (inLink()) {
      reposition();
    }
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

//---------------------------MENU STUFF--------------------------------------------------------------------------

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

//--------------------------------------GAME STUFF--------------------------------------------------------------------

void processKeys() {
  if (downPressed) {
    if (you.getY() < current.getBD() && current.environment(you.getX(), you.getY() + 4)) {
      you.setY(you.getY()+2.0);
    } else if (!current.environment(you.getX(), you.getY())) {
      if (you.getY() < current.getBD() && current.environment(you.getX(), you.getY())) {
        you.setY(you.getY()+2.0);
      } else {
        you.setY(you.getY()-2.0);
      }
    }
    pos++;
    dirc = 40;
  }
  if (upPressed) {
    if (you.getY() > current.getBU() && current.environment(you.getX(), you.getY() - 4)) {
      you.setY(you.getY()-2.0);
    } else if (!current.environment(you.getX(), you.getY())) {
      if (you.getY() > current.getBU() && current.environment(you.getX(), you.getY())) {
        you.setY(you.getY()-2.0);
      } else {
        you.setY(you.getY()+2.0);
      }
    }
    pos++;
    dirc = 38;
  }
  if (rightPressed) {

    if (you.getX() < current.getBR() && current.environment(you.getX() + 4, you.getY())) {
      you.setX(you.getX()+2.0);
    } else if (!current.environment(you.getX(), you.getY())) {

      if (you.getX() < current.getBR() && current.environment(you.getX(), you.getY())) {
        you.setX(you.getX()+2.0);
      } else {

        you.setX(you.getX()-2.0);
      }
    }
    pos++;
    dirc = 39;
  }
  if (leftPressed) {
    if (you.getX() > current.getBL() && current.environment(you.getX() - 4, you.getY())) {
      you.setX(you.getX()-2.0);
    } else if (!current.environment(you.getX(), you.getY())) {
      if (you.getX() > current.getBL() && current.environment(you.getX(), you.getY())) {
        you.setX(you.getX()-2.0);
      } else {
        you.setX(you.getX()+2.0);
      }
    }
    pos++;
    System.out.println("FFFFFFFFFFFFFFFFFFFFFF");
    dirc = 37;
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
  System.out.println("" + (int)you.getX() + ", " + (int)you.getY()+" "+pos);
  if (zPressed) {
    interact();
  }
  if (open) {

    openInv();
  }
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
  } else if (keyCode==73) {
    open=!open;
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
    if (current.getNPC(0).getX()==you.getX()-24 &&
      current.getNPC(0).getY()<=you.getY()+14 && current.getNPC(0).getY()>=you.getY()-14) {


      current.getNPC(0).setPosR(0);
      current.getNPC(0).setDir(39);
      zbutton="Talk";
    }
  } else if (you.getDir()==38) { //if you're facing up
    if (current.getNPC(0).getY()==you.getY()-24 && 
      current.getNPC(0).getX()<=you.getX()+14 && current.getNPC(0).getX()>=you.getX()-14) {


      current.getNPC(0).setPosD(0);
      current.getNPC(0).setDir(40);
      zbutton="Talk";
    }
  } else if (you.getDir()==39) { //if you're facing right
    if (current.getNPC(0).getX()==you.getX()+24 && 
      current.getNPC(0).getY()<=you.getY()+14 && current.getNPC(0).getY()>=you.getY()-14) {


      current.getNPC(0).setPosL(0);
      current.getNPC(0).setDir(37);
      zbutton="Talk";
    }
  } else if (you.getDir()==40) { //if you're facing down
    if (current.getNPC(0).getY()==you.getY()+24 && 
      current.getNPC(0).getX()<=you.getX()+14 && current.getNPC(0).getX()>=you.getX()-14) {


      current.getNPC(0).setPosU(0);
      current.getNPC(0).setDir(38);
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

public boolean inLink() {
  for (Location door : current.getLinks ()) {
    if (door.checkdoor((int)you.getX(), (int)you.getY())) {
      prev=current.getName();
      current=door;
      return true;
    }
  }
  return false;
}

public void reposition() {
  for (Location door : current.getLinks ()) {
    if (door.getName()==prev) {
      if (Math.abs(((door.getBD() + door.getBU())/2) - door.getNodeY()) < Math.abs(((door.getBR() + door.getBL())/2) - door.getNodeX())) {
        if (door.getNodeX() > ((door.getBR() + door.getBL())/2)) {
          you.setX(door.getNodeX() - 32);
        } else {
          you.setX(door.getNodeX() + 32);
        }
        you.setY(door.getNodeY());
      } else {
        if (door.getNodeY() > ((door.getBD() + door.getBU())/2)) {
          you.setY(door.getNodeY() - 32);
        } else {
        }
        you.setX(door.getNodeX() + 32);
      }
    }
  }
}

public void pickup() {
  for (int i=0; i< testItems.size (); i++) {
    testItems.get(i).display();
    if (you.getX()>=testItems.get(i).getX()-15 && you.getX()<=testItems.get(i).getX()+15 &&
      you.getY()>=testItems.get(i).getY()-15 && you.getY()<=testItems.get(i).getY()+15) {

      you.setHuzzah(true);
      Item temp=testItems.get(i);
      testItems.remove(testItems.get(i));
      inventory.add(temp);
    }
  }
}

public void yay() {
  int s = millis();
  while (millis () - s < 1500) {
    you.display();
  }
}
public void openInv() {
  int x=200;
  int y=200;
  rect(100, 100, 400, 400);
  for (Item i : inventory) {
    i.setX(x);
    i.setY(y);
    i.display();
    if (x==450) {
      x=200;
      y+=50;
    } else {
      x+=50;
    }
  }
}



public void wait(int t) {
  int s = millis();
  while (millis () - s < t);
}

