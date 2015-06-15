import java.util.*;
import java.io.*;
import java.lang.*;

//------------------Scanner
private ArrayList<Character>mvChars;
private ArrayList<Command>mvchars;
boolean mvmt;
Location prevL;
//------------------MENU
int mode;
Button START, HELP;
int buttonSize = 60;
boolean start, hover, open;
int counter, c2;
int tcolor, bcolor;
PImage img1;
//-------------------------GAMEPLAY
private int huzzahx;
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
private Character[] seconNPCs;
private String zbutton;
private Location[] maps;
private ArrayList<Item> testItems;
private ArrayList<Item> inventory;
private boolean first;
private Character talking;

//-------------------------DIALOGUE
long lastTime;
String words;
boolean zPressed;
int nextset = -1;
ArrayList<String> sets;


void setup() {
  //---------------------------GAMEPLAY
  /*
  firstNPCs=new Character[1];
   seconNPCs=new Character[1];
   firstNPCs[0]=new Character("Boy1");
   firstNPCs[0].setX(200);
   firstNPCs[0].setY(200);
   firstNPCs[0].setDir(40);
   firstNPCs[0].setPosD(0);
   firstNPCs[0].setText("Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world. Hi my name is Boy1. I am the first guinea pig of this world.");
   seconNPCs[0]=new Character("Boy1");
   seconNPCs[0].setX(300);
   seconNPCs[0].setY(200);
   seconNPCs[0].setDir(40);
   seconNPCs[0].setPosD(0);
   seconNPCs[0].setText("Hi my name is Boy2. I am the first guinea pig of this world. Hi my name is Boy2. I am the first guinea pig of this world. Hi my name is Boy2. I am the first guinea pig of this world. Hi my name is Boy2. I am the first guinea pig of this world.");
   
   PImage bg=loadImage("Locations/0.png");
   */
  loadLocations();
  loadLinks();
  current=maps[0];
  zbutton="DoNothing";
  size(600, 600);
  mvchars=new ArrayList<Command>();
  /*
  current = new Location(66, 502, 74, 502, firstNPCs, bg, true);
   current.setName("Start");
   
   Location[] newLinks=new Location[1];
   Location[] otherLinks=new Location[1];
   otherLinks[0]=current;
   otherLinks[0].setNodeX(60);
   otherLinks[0].setNodeY(285);
   newLinks[0]=new Location(92, 464, 62, 524, seconNPCs, loadImage("Locations/1.png"), false);
   newLinks[0].setName("class");
   newLinks[0].setNodeX(504);
   newLinks[0].setNodeY(205);
   current.setLinks(newLinks);
   newLinks[0].setLinks(otherLinks);
   */
  you=new Player("Link", 10);
  //System.out.println(you.getName());
  pos=0;
  you.setX(width/2);
  you.setY(height/2);
  you.setPosD(0);
  you.setDir(40);
  dirc = 40;
  prev="";
  //maps=new Location[10];
  inventory=new ArrayList<Item>(1);
  current.catalog=new ArrayList<Item>(1);

  maps[0].getLinks()[0].catalog=new ArrayList<Item>();
  current.catalog.add(new Item("J", loadImage("Letters/0.png"), 75, 75));
  current.catalog.add(new Item("O", loadImage("Letters/1.png"), 100, 100));
  current.catalog.add(new Item("H", loadImage("Letters/2.png"), 150, 150));
  current.catalog.add(new Item("N", loadImage("Letters/3.png"), 400, 200));

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
  // dialogue(current.getNPC(0).getText()); 
  lastTime=millis();
  nextset= -1;
  talking = current.getNPC(0);
}

void draw() {
  //System.out.println(keyCode);
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
    // System.out.println(maps[0].getLinks()[0]);
  } else if (mode == 1) {
    background(254);
    image(current.getBackground(), 0, 0, 600, 600);
    System.out.println(you.getX() + "," + you.getY());
    if (current.getScene()) {
      current.setScene(false);
      runFile();

      fcount++;
    }
    if (mvmt==true) {
      if (mvchars.size()==0) {
        mvmt=false;
        if (sets.size() != 0) {
          zbutton = "Talk";
        }
      } else {
        moveChars();
        //System.out.println(mvChars.get(0).getStopX()+"...................."+you.getX());
        showItems();
        for (int i = 0; i < current.getNPC ().length; i++) {
          current.getNPC(i).display();
        }
        you.display();
      }
    }
    if (current.getNPC().length!=0) {
      for (int i = 0; i < current.getNPC ().length; i++) {
        current.getNPC(i).display();
      }
    }

    interact();

    pickup();
    showItems();
    you.display();
    if (you.getHuzzah()) {
      huzzahx++;
    }
    //you.getHuzzah());

    if (huzzahx==1) {
      inventory.get(inventory.size()-1).setX((int)you.getX()+10);
      inventory.get(inventory.size()-1).setY((int)you.getY()-13);
      inventory.get(inventory.size()-1).display();
    }
    if (huzzahx==2) {
      noLoopWait(1500);
      loop();
      you.setHuzzah(false);
      huzzahx=0;
    }
    if (zbutton=="Talk") {
      newTextBox(talking.getName());
      textAlign(LEFT);
      if (nextset == -1) {
        text(sets.get(0), width/24+75, height*3/4+30);
      } else {
        text(sets.get(nextset), width/24+75, height*3/4+30);
      }
      talk();
    }

    if (zbutton!="Talk" && mvmt == false) {
      if (inLink()) {
        reposition();
      }
      processKeys();
    }

    //  you.display();
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
    //System.out.println("FFFFFFFFFFFFFFFFFFFFFF");
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
  //System.out.println("" + (int)you.getX() + ", " + (int)you.getY()+" "+pos);
  //if (zPressed) {
  //interact();
  //}
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

void loadLocations() {
  String[] lines=loadStrings("LOCATIONS.txt");
  maps=new Location[lines.length];
  for (int i=0; i<lines.length; i++) {
    String[] room=split(lines[i], ",");
    // NAME, BU, BD, BL, BR, PATH, SCENE?, FIRSTChar,..LASTChar
    Character newchars[]=new Character[0];
    boolean scene=false;
    if (room.length>6) {
      newchars=new Character[(room.length-6)/4];
      for (int j=7, x=0; j<room.length; j+=4, x++) {
        newchars[x]=new Character(room[j]);
        newchars[x].setX(Integer.valueOf(room[j+1]));
        newchars[x].setY(Integer.valueOf(room[j+2]));
        newchars[x].setText(room[j+3]);
        newchars[x].setDir(40);
        newchars[x].setPosD(0);
      }
    }

    if (room[6].equals("FALSE")) {
      scene=false;
    } else if (room[6].equals("TRUE")) {
      scene=true;
    }

    maps[i]=new Location(Integer.valueOf(room[1]), Integer.valueOf(room[2]), Integer.valueOf(room[3]), Integer.valueOf(room[4]), newchars, loadImage(room[5]), scene);
    maps[i].setName(room[0]);
    //System.out.println(newchars.length+"saqeqwe");
  }
}

void loadLinks() {
  int mapctr=0;
  int placectr=0;
  String[] lines=loadStrings("LINKS.txt");
  for (int i=0; i<lines.length; i++) {
    String[] links=split(lines[i], ",");

    Location newLocs[]=new Location[links.length/3];
    // System.out.println(newLocs.length+"hahahahahahahaha");
    for (int j=0; j<links.length; j+=3) {
      int loop=0;
      for (Location place : maps) {

        if (place.getName().equals(links[j])) {
          //  System.out.println(maps[0].getName()+"::::::::::::::::::::::::::"+links[j]);
          newLocs[placectr]=place;
          //System.out.println(newLocs[placectr]+"dadadsdadaaasdsaddadasd");
          newLocs[placectr].nodes.add(Integer.valueOf(links[j+1]));
          newLocs[placectr].nodes.add(Integer.valueOf(links[j+2]));
          placectr++;
        }
      }
    }
    placectr=0;
    maps[mapctr].setLinks(newLocs);
    //System.out.println(maps[0].getName()+maps[0].getLinks()[0].getName());
    mapctr++;
  }
}

void runFile() {
  File blah=new File("scene"+fcount+".txt");
  //System.out.println(blah.getAbsolutePath());
  String commandlines[]=loadStrings("scene"+fcount+".txt");
  mvChars=new ArrayList<Character>(0);

  for (int i=0; i<commandlines.length; i++) {
    String commands[]=split(commandlines[i], ",");

    if (commands[0].equals("MOVE")) {
      //Command,Name,FinalX,FinalY
      mvmt=true;
      //System.out.println(commands[1]);
      Character temp = findCharacter(commands[1]);

      temp.setIForm(0);
      // temp.move(Integer.valueOf(commands[2]), Integer.valueOf(commands[3]));
      Command lelouch=new Command(temp, Integer.valueOf(commands[2]), Integer.valueOf(commands[3]));
      mvchars.add(lelouch);
      mvChars.add(temp);
    } else {
      dialogue(commands[2]);
      newTextBox(commands[1]);
      textSize(16);
      if (nextset == -1) {
        text(sets.get(0), width/24+100, height*3/4+30);
      } else {
        text(sets.get(nextset), width/24+100, height*3/4+30);
      }
    }
  }
  /*
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
   */
}

void moveChars() {

  Command curr=mvchars.get(0);
  if (curr.getStopX()!=curr.getChar().getX() || 
    curr.getStopY()!=curr.getChar().getY()) {
    background(254);
    image(current.getBackground(), 0, 0, 600, 600);
    curr.getChar().move(curr.getStopX(), curr.getStopY());
  } else {
    mvchars.remove(0);
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
  //System.out.println(zPressed);
  //System.out.println(nextset);
  if (zPressed) {
    zPressed=false;
    nextset++;
    if (nextset==sets.size()) {
      zbutton="DoNothing";
      nextset= -1;
      textAlign(CENTER, CENTER);
      sets.clear();
      dialogue(talking.getText());
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
  if (current.getNPC().length!=0) {
    for (int i = 0; i < current.getNPC ().length; i++) {
      if (you.getDir()==37) { //if you're facing left
        if (current.getNPC(i).getX()>=you.getX()-20 && current.getNPC(i).getX()<=you.getX()+20 &&
          current.getNPC(i).getY()<=you.getY()+14 && current.getNPC(i).getY()>=you.getY()-14) {

          if (zPressed) {
            talking = current.getNPC(i);
            current.getNPC(i).setPosR(0);
            current.getNPC(i).setDir(39);
            zbutton="Talk";
          }
        }
      } else if (you.getDir()==38) { //if you're facing up
        if (current.getNPC(i).getY()>=you.getY()-20 && current.getNPC(i).getY()<=you.getY()+20 &&
          current.getNPC(i).getX()<=you.getX()+14 && current.getNPC(i).getX()>=you.getX()-14) {

          if (zPressed) {
            current.getNPC(i).setPosD(0);
            current.getNPC(i).setDir(40);
            zbutton="Talk";
          }
        }
      } else if (you.getDir()==39) { //if you're facing right
        if (current.getNPC(i).getX()<=you.getX()+20 && current.getNPC(i).getX()>=you.getX()-20 &&
          current.getNPC(i).getY()<=you.getY()+14 && current.getNPC(i).getY()>=you.getY()-14) {

          if (zPressed) {
            current.getNPC(i).setPosL(0);
            current.getNPC(i).setDir(37);
            zbutton="Talk";
          }
        }
      } else if (you.getDir()==40) { //if you're facing down
        if (current.getNPC(i).getY()<=you.getY()+24 && current.getNPC(i).getY()>=you.getY()-24 &&
          current.getNPC(i).getX()<=you.getX()+14 && current.getNPC(i).getX()>=you.getX()-14) {

          if (zPressed) {
            current.getNPC(i).setPosU(0);
            current.getNPC(i).setDir(38);
            zbutton="Talk";
          }
        }
      }
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
    if (door.checkdoor((int)you.getX(), (int)you.getY(), current)) {
      //System.out.println(door.getName());
      prev=current.getName();
      prevL=current;
      current=door;
      sets.clear();
      for(int i = 0; i < current.getNPC().length; i++) {
        dialogue(current.getNPC(i).getText());
      } 
      return true;
    }
  }
  return false;
}

public void reposition() {
  int NodeX = 0;
  int NodeY = 0;
  for (int i = 0; i < prevL.getLinks ().length; i++) {
    if (prevL.getLinks()[i].getName().equals(current.getName())) {
      //System.out.println(current.getLinks()[i].getName());
      //System.out.println(current.nodes.get(2*i) + "," + current.nodes.get(2*i + 1));
      //System.out.println(current.getName());
      //System.out.println(Arrays.toString(current.getLinks()));
      NodeX = prevL.nodes.get(2*i);
      NodeY = prevL.nodes.get((2*i) + 1);
    }
  }
  int adjx = 0;
  int adjy = 0;
  if (Math.abs(NodeX - current.getBL()) <= 8) {
    adjx = 24;
  } else if (Math.abs(NodeX - current.getBR()) <=8) {
    adjx = -24;
  }
  if (Math.abs(NodeY - current.getBU()) <= 8) {
    adjy = 24;
  } else if (Math.abs(NodeY - current.getBD()) <=8) {
    adjy = -24;
  }
  you.setX(NodeX + adjx);
  you.setY(NodeY + adjy);
  System.out.println(NodeX + "," +NodeY+"gafhbg.akdjfnhbg.jfdg" + adjx + ","+ adjy);
}


public void pickup() {
  //System.out.println(current.catalog);
  for (int i=0; i< current.catalog.size (); i++) {
    //testItems.get(i).display();
    if (you.getX()>=current.catalog.get(i).getX()-15 && you.getX()<=current.catalog.get(i).getX()+15 &&
      you.getY()>=current.catalog.get(i).getY()-15 && you.getY()<=current.catalog.get(i).getY()+15) {

      you.setHuzzah(true);
      Item temp=current.catalog.get(i);

      current.catalog.remove(temp);
      inventory.add(temp);
    }
  }
}

public void showItems() {
  for (int i=0; i< current.catalog.size (); i++) {
    current.catalog.get(i).display();
  }
}


public void openInv() {
  int x=150;
  int y=200;
  rect(100, 100, 400, 400);
  for (Item i : inventory) {
    i.setX(x);
    i.setY(y);
    i.display();
    if (x==450) {
      x=150;
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

public void noLoopWait(int t) {
  int s=millis();
  while (millis ()-s<1500) {
    noLoop();
  }
}

