public class Character {
  private String name;
  private String DATA;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;
  private float lastx,lasty;
  private float x, y;

  public Character(){
    this("Bob");
  }
  
  public Character(String name_){
     setName(name_);
  
  }
  
  public void display(int dir){
    if (dir==37){
      image(leftpos,x,y);
    }else if (dir==38){
      image(uppos,x,y);
    }else if (dir==39){
      image(rightpos,x,y);
    }else if (dir==40){
      image(downpos,x,y);
    }
  }
  
  public void setPosR(int form){
    rightpos=loadImage(name+"Data/"+name+"RightPosData/"+form+".png");
  }
  
  public void setPosL(int form){
    leftpos=loadImage(name+"Data/"+name+"LeftPosData/"+form+".png");
  }
  
  public void setPosU(int form){
    uppos=loadImage(name+"Data/"+name+"UpPosData/"+form+".png");
  }
  
  public void setPosD(int form){
    downpos=loadImage(name+"Data/"+name+"DownPosData/"+form+".png");
  }
  
  public void setX(float X){
    lastx = x;
    x=X;
  }
  
  public void setY(float Y){
    lasty = y;
    y=Y;
  }
  
  public void setName(String name_){
    name=name_;
  }
  
 
  public float getA(){
    return lastx;
  }
  
  public float getB(){
   return lasty; 
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

