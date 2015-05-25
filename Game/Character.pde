public abstract class Character {
  private String name;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;
  private float x, y;

  abstract boolean ifMoveRight();
  abstract boolean ifMoveLeft();
  abstract boolean ifMoveUp();
  abstract boolean ifMoveDown();
  abstract void setX();
  abstract void setY();
  abstract float getX();
  abstract float getY();
  abstract String getName();
}

