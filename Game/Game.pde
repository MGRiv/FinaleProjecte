private Player you;
private boolean rightPressed, leftPressed, upPressed, downPressed;
private boolean rightReleased, leftReleased, upReleased, downReleased;
private int pos;
private int dirc;
private boolean moved;
private Location current; 
//private float cx,cy;

void setup() {
  current = new Location();
  you=new Player("Link");
  System.out.println(you.getName());
  pos=0;
  size(600, 600);
  background(254);
  you.setX(width/2);
  you.setY(height/2);
  you.setPosD(0);
  dirc = 40;
}

void draw() {
  background(254);
  you.display();
  processKeys(); 
}

void processKeys() {
  if (downPressed) {
    if(you.getY() < current.getBD())
    you.setY(you.getY()+2.0);
    pos++;
    dirc = 40;
    //for (int i=0; i<30; i++) {
    //}
  }
  if (upPressed) {
    if(you.getY() > current.getBU())
    you.setY(you.getY()-2.0);
    pos++;
    dirc = 38;
    //for (int i=0; i<30; i++) {
    //}
  }
  if (rightPressed) {
    if(you.getX() < current.getBR())
    you.setX(you.getX()+2.0);
    pos++;
    dirc = 39;
    //for (int i=0; i<30; i++) {
    //}
  }
  if (leftPressed) {
    if(you.getX() > current.getBL())
    you.setX(you.getX()-2.0);
    pos++;
    dirc = 37;
    //for (int i=0; i<30; i++) {
    //}
  }

  if (dirc == 37) {
    you.setPosL(pos % 10);
    //System.out.println(you.getDir());
  }else if (dirc == 39) {
    you.setPosR(pos % 10);
    //System.out.println(you.getDir());
  }else if(dirc == 38) {
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
  } else {
    downPressed =  rightPressed = leftPressed = upPressed = false;
  }
}

