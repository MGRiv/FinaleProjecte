public class Player extends Character {


  public Player() {
    this("Link");
  }
  public Player(String name) {
    super(name);
    setPosR(0);
    setPosL(0);
    setPosU(0);
    setPosD(0);
  }
  public Player(String name, int iC) {
    super(name, iC);
    setPosR(0);
    setPosL(0);
    setPosU(0);
    setPosD(0);
  }
}

