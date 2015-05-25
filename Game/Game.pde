private Player you;
private boolean rightPressed, leftPressed, upPressed, downPressed;
private boolean rightReleased, leftReleased, upReleased, downReleased;
private int pos;

void setup() {
  you=new Player("Link");
  System.out.println(you.getName());
  pos=0;
  size(800, 600);
}

void draw() {
  System.out.println(keyCode);
  processKeys();  
  you.display(keyCode);
  clear();
  you.display(keyCode);
  /*
  for (int x=15; x<320; x+=30) {
   you.setPosD(x, 75, 33, 33);
   you.setX(x);
   // you.setY(165);
   you.display();
   }
   */
}

void processKeys() {
  if (downPressed) {
    you.setY(you.getY()+2.0);
    you.setPosD(pos);
    pos++;
    if (pos==9) {
      pos=0;
    }
  }
  if (upPressed) {
    you.setY(you.getY()-2.0);
    you.setPosU(pos);
    pos++;
    if (pos==9) {
      pos=0;
    }
  }
  if (rightPressed) {
    you.setX(you.getX()+2.0);
    you.setPosR(pos);
    pos++;
    if (pos==9) {
      pos=0;
    }
  }
  if (leftPressed) {
    you.setX(you.getX()-2.0);
    you.setPosL(pos);
    pos++;
    if (pos==9) {
      pos=0;
    }
  }
}

void keyReleased() {
  if (keyCode==37) {
    leftPressed=false;
  }
  if (keyCode==38) {
    upPressed=false;
  }
  if (keyCode==39) {
    rightPressed=false;
  }
  if (keyCode==40) {
    downPressed=false;
  }
}

void keyPressed() {
  if (keyCode==37) {
    leftPressed=true;
  }
  if (keyCode==38) {
    upPressed=true;
  }
  if (keyCode==39) {
    rightPressed=true;
  }
  if (keyCode==40) {
    downPressed=true;
  }
  
}

