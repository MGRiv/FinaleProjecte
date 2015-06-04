public class Item{
  private int x,y;
  private PImage image;
  private String name;
  
  public Item(){
    this("rock",loadImage("Letters/0.png"),300,300);
  }
  
  
  public Item(String s, PImage i, int xval, int yval){
    name=s;
    x=xval;
    y=yval;
    image=i;
  }
  
  public String getName(){
    return name;
  }
  
  public void display(){
    image(image, x, y, 25,25);
  }
  
  public void setX(int xval){
    x=xval;
  }
  
  public void setY(int yval){
    y=yval;
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  
}
