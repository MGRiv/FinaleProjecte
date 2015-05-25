public class Character {
  private String name;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;
  private PImage spritesheet;
  private float x, y;

  public Player(String name_){
     setName(name);
  }
  
  public void moveRight(){
    rightpos=spritesheet.get(0,0,50,100);
  }
  
  public void ifMoveLeft(){
    leftpos=spritesheet.get(0,0,50,100);
  }
  
  public void ifMoveUp(){
    uppos=spritesheet.get(0,0,50,100);
  }
  
  public void ifMoveDown(){
    downpos=spritesheet.get(0,0,50,100);
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
  
  public void setSpriteSheet(PImage sheet){
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

