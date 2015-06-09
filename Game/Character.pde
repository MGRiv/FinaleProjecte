public class Character {
  private String name;
  private String DATA;
  private String text;
  private PImage rightpos;
  private PImage leftpos; 
  private PImage uppos;
  private PImage downpos;
  private float x, y;
  private int dir, stopx, stopy;
  private boolean huzzah;
  private int imageCount;
  private int iform;

  public Character() {
    this("Bob");
    if (imageCount==0) {
      imageCount = 1;
    }
  }

  public Character(String name_) {
    setName(name_);
    if (imageCount==0) {
      imageCount = 1;
    }
  }

  public Character(String name_, int iC) {
    this(name_);
    imageCount = iC;
  }

  public void display() {
    if (huzzah) {
      image(loadImage("huzzah.png"), x, y);
    } else {
      if (dir==37) {
        image(leftpos, x, y);
      } else if (dir==38) {
        image(uppos, x, y);
      } else if (dir==39) {
        image(rightpos, x, y);
      } else if (dir==40) {
        image(downpos, x, y);
      }
    }
  }

  public void setIForm(int q) {
    iform = q;
  }

  public void setPosR(int form) {
    rightpos=loadImage(name+"Data/"+name+"RightPosData/"+form+".png");
  }

  public void setPosL(int form) {
    leftpos=loadImage(name+"Data/"+name+"LeftPosData/"+form+".png");
  }

  public void setPosU(int form) {
    uppos=loadImage(name+"Data/"+name+"UpPosData/"+form+".png");
  }

  public void setPosD(int form) {
    downpos=loadImage(name+"Data/"+name+"DownPosData/"+form+".png");
  }

  public void setX(float Nx) {
    x=Nx;
  }

  public void setY(float Ny) {
    y=Ny;
  }

  public void setName(String name_) {
    name=name_;
  }

  public void setDir(int d) {
    dir=d;
  }

  public void setText(String t) {
    text=t;
  }

  public void setHuzzah(boolean h) {
    huzzah=h;
  }

  public int getStopX() {
    return stopx;
  }

  public int getStopY() {
    return stopy;
  }

  public String getText() {
    return text;
  }

  public int getDir() {
    return dir;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public String getName() {
    return name;
  }

  public boolean getHuzzah() {
    return huzzah;
  }

  public void move(int a, int b) {
    stopx=a;
    stopy=b;
    if(Math.abs (x - a) != 0 || Math.abs(y - b) != 0) {
      if (Math.abs(x - a) != 0) {
        if (x > a) {
          x -= 2;
          setPosL(iform % imageCount);
          iform++;
        } else {
          x += 2;
          setPosR(iform % imageCount);
          iform++;
        }
      }
      if (Math.abs(y - b) != 0) {
        if (y > b) {
          y -= 2;
          setPosU(iform % imageCount);
          iform++;
        } else {
          y += 2;
          setPosD(iform % imageCount);
          iform++;
        }
      }
      display();
      waitC(100);
    }
  }
  public void waitC(int t) {
    int s = millis();
    while (millis () - s < t);
  }
}

