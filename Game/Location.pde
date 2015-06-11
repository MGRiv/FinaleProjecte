public class Location {

  private Character[] NPC;
  public ArrayList<Item> catalog;
  private PImage background;
  private int bu, bd, bl, br;
  private boolean cutscene;
  private Location[] Links;
  public ArrayList<Integer> nodes = new ArrayList<Integer>();
  private String name;

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

  public void setLinks(Location[] l) {
    Links=l;
  }

  public void setName(String n) {
    name=n;
  }

  public Character[] getNPC() {
    return NPC;
  }
  public Character getNPC(int u) {
    return NPC[u];
  }
  public PImage getBackground() {
    return background;
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

  public boolean environment(float x, float y) {
    for (Character e : NPC) {
      if (Math.abs(x - e.getX()) <= 12 && Math.abs(y - e.getY()) <= 12) {
        return false;
      }
    }
    return true;
  }

  public String getName() {
    return name;
  }

  public Location[] getLinks() {
    return Links;
  }
  public boolean checkdoor(int x, int y) {
    for (int i = 0; i < nodes.size (); i+=2) {
      int nodeX = nodes.get(i);
      int nodeY = nodes.get(i + 1);
      if (Math.abs(((bd + bu)/2) - y) < Math.abs(((br + bl)/2) - x)) {
        if (Math.abs(x - nodeX) < 6 && Math.abs(y - nodeY) < 18) {
          return true;
        }
      } else {
        if (Math.abs(x - nodeX) < 18 && Math.abs(y - nodeY) < 6) {
          return true;
        }
      }
    }
    return false;
  }
  public int wdoor(int x, int y) {
    for (int i = 0; i < nodes.size (); i+=2) {
      int nodeX = nodes.get(i);
      int nodeY = nodes.get(i + 1);
      if (Math.abs(((bd + bu)/2) - y) < Math.abs(((br + bl)/2) - x)) {
        if ((Math.abs(x - nodeX) < 6 && Math.abs(y - nodeY) < 18) || (Math.abs(x - nodeX) < 18 && Math.abs(y - nodeY) < 6)) {
          return i;
        }
      }
    }
    return 0;
  }
}
