private Player you;
private boolean rightPressed, leftPressed, upPressed, downPressed;
private boolean rightReleased, leftReleased, upReleased, downReleased;
private int pos;
//private float cx,cy;

void setup() {
  you=new Player("Link");
  System.out.println(you.getName());
  pos=0;
  size(600, 600);
}

void draw() {
  System.out.println(keyCode);

  //you.display(keyCode);
  clear();
  you.setDir(keyCode);

  you.display();
  processKeys(); 
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
    pos++;
    for (int i=0; i<30; i++) {
    }
  }
  if (upPressed) {
    you.setY(you.getY()-2.0);
    pos++;
    for (int i=0; i<30; i++) {
    }
  }
  if (rightPressed) {
    you.setX(you.getX()+2.0);
    pos++;
    for (int i=0; i<30; i++) {
    }
  }
  if (leftPressed) {
    you.setX(you.getX()-2.0);
    pos++;
    for (int i=0; i<30; i++) {
    }
  }

  if (you.getA() > you.getX()) {
    you.setPosL(pos % 10);
  } else if (you.getA() < you.getX()) {
    you.setPosR(pos % 10);
  }
  if (you.getB() > you.getY()) {
    you.setPosU(pos % 10);
  } else if (you.getB() < you.getY()) {
    you.setPosD(pos % 10);
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

