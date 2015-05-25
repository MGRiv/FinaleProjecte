private Player you;
private boolean rightPressed, leftPressed, UpPressed, downPressed;
private boolean rightReleased, leftReleased, upReleased, downReleased;
private int pos;

void setup() {
  you=new Player();
  you.setSpriteSheet("Data/Link.png");
  pos=15;
  you.setPosD(pos, 75, 33, 33);


  size(800, 600);
}

void draw() {
  System.out.println(keyCode);
  processKeys();  
  you.display();
  clear();
  you.display();
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
    you.setPosD(pos, 75, 33, 33);
    pos+=15;
    if (pos==315) {
      pos-=300;
    }
  }
}

void keyReleased() {
  if (keyCode==40) {
    downPressed=false;
  }
}

void keyPressed() {
  if (keyCode==40) {
    downPressed=true;
  }
}

