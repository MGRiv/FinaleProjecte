public class Location {
  private Character[] NPC;
  private PImage background;
  private int bu, bd, bl, br;
  private boolean cutscene;

  public Location() {
    bu = 0;
    bd = 578;
    bl = 0;
    br = 580;
    cutscene = false;
  }

  public Location(int a, int b, int c, int d) {
    bu = a;
    bd = b;
    bl = c;
    br = d;
    cutscene = false;
  }

  public Location(int a, int b, int c, int d, Character[] l, PImage q, boolean scene) {
    this(a, b, c, d);
    NPC = l;
    background = q;
    cutscene = scene;
  }

  public void setScene(boolean scene) {
    cutscene =  scene;
  }
  
  public Character[] getNPC(){
   return NPC; 
  }

  public boolean getScene() {
    return cutscene;
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
