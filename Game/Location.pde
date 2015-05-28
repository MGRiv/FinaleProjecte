public class Location {
  private Character[] NPC;
  private PImage background;
  private int bu, bd, bl, br;

  public Location() {
    bu = 0;
    bd = 578;
    bl = 0;
    br = 580;
  }

  public Location(int a, int b, int c, int d) {
    bu = a;
    bd = b;
    bl = c;
    br = d;
  }

  public Location(int a, int b, int c, int d, Character[] l, PImage q) {
    this(a, b, c, d);
    NPC = l;
    background = q;
  }

  public int getBU() {
    return bu;
  }
  public int getBD() {
    return bd;
  }
  public int getBL() {
    return bl;
  }
  public int getBR() {
    return br;
  }
}

