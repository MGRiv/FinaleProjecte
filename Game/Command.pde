public class Command {
  private Character Char;
  private int stopx, stopy;


  public Command(Character c, int x, int y) {
    Char=c;
    stopx=x;
    stopy=y;
  }

  public Character getChar() {
    return Char;
  }

  public int getStopX() {
    return stopx;
  }

  public int getStopY() {
    return stopy;
  }
  
}

