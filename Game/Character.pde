public class Character {
  private String name;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;
  private PImage spritesheet;
  private float x, y;

  public Character(){
    this("Bob");
  }
  
  public Character(String name_){
     setName(name);
  }
  
  public void display(){
    image(downpos,x,y);
  }
  
  public void setPosR(){
    rightpos=spritesheet.get(0,0,0,500);
  }
  
  public void setPosL(){
    leftpos=spritesheet.get(0,0,50,100);
  }
  
  public void setPosU(){
    uppos=spritesheet.get(0,0,50,100);
  }
  
  public void setPosD(int x, int y, int w, int h){
    downpos=spritesheet.get(x,y,w,h);
  }
  
  public void setX(float X){
    x=X;
  }
  
  public void setY(float Y){
    y=Y;
  }
  
  public void setName(String name_){
    name=name_;
  }
  
  public void setSpriteSheet(String sheetPath){
    PImage sheet=loadImage(sheetPath);
    spritesheet=sheet;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public String getName(){
    return name;
  }
}

