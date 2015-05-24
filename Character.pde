public abstract class Character {
  private String name;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;

  abstract boolean ifMoveRight();
  abstract boolean ifMoveLeft();
  abstract boolean ifMoveUp();
  abstract boolean ifMoveDown();
}

