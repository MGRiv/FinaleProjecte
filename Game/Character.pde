public class Character {
  private String name;
  private String DATA;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;
  private float x, y;
  private int dir;

  public Character() {
    this("Bob");
  }

  public Character(String name_) {
    setName(name_);
  }

  public void display() {
    if (dir==37) {
      image(leftpos, x, y);
    } else if (dir==38) {
      image(uppos, x, y);
    } else if (dir==39) {
      image(rightpos, x, y);
    } else if (dir==40) {
      image(downpos, x, y);
    }
  }

  public void setPosR(int form) {
    rightpos=loadImage(name+"Data/"+name+"RightPosData/"+form+".png");
  }

  public void setPosL(int form) {
    leftpos=loadImage(name+"Data/"+name+"LeftPosData/"+form+".png");
  }

  public void setPosU(int form) {
    uppos=loadImage(name+"Data/"+name+"UpPosData/"+form+".png");
  }

  public void setPosD(int form) {
    downpos=loadImage(name+"Data/"+name+"DownPosData/"+form+".png");
  }

  public void setX(float Nx) {
    x=Nx;
  }

  public void setY(float Ny) {
    y=Ny;
  }

  public void setName(String name_) {
    name=name_;
  }

  public void setDir(int d){
    dir=d;
  }
  public int getDir(){
   return dir; 
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public String getName() {
    return name;
  }
  public void move(int a, int b){
    while(Math.abs(x - a) != 0 || Math.abs(y - b) != 0){
     if(Math.abs(x - a) != 0){
       if(x > a){
        x -= 2; 
       }else{
        x += 2;
       }
     }
     if(Math.abs(y - b) != 0){
       if(y > b){
         y -= 2;
       }else{
         y += 2;
       }
     }
     waitC(17);
    }
  }
}
public void waitC(int t) {
  int s = millis();
  while (millis () - s < t);
}
