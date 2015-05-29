public class Button {
  int xcor, ycor, h, w, radius;
  String title;
  boolean isClicked;
  color hc;
  boolean hover;


  public Button() {
    this(30, 30, 50, 100, 6, "Start");
  }

  public Button(int x, int y, String t) {
    this(x, y, 50, 100, 6, t);
  }

  public Button(int x, int y, int hite, int widht, int r, String t) {
    xcor=x;
    ycor=y;
    h=hite;
    w=widht;
    radius=r;
    title=t;
  }

  void display(int q, int d) {
    
    fill(d);
    if (hover){
      fill(hc);
    }else{
      fill(d);
    }
    rect(xcor, ycor, w, h, radius);

    textSize(h/4);

    fill(q);
    text(title, xcor+xcor/128, ycor+ycor/64, w, h);
  }

  void leftclicked() {
    if (mousePressed && mouseButton==LEFT && inRange()) {
      isClicked=true;
    }
  }

  void leftreleased() {
    if (!mousePressed && mouseButton==LEFT) {
      isClicked=false;
    }
  }

  void setHighlight(color hue) {
    hc=hue;
  }

  

  void setHover(boolean mode) {
    hover=mode;
  }

  boolean inRange() {
    if ((mouseX>xcor && mouseX<xcor+w) &&
      (mouseY>ycor && mouseY<ycor+h)) {
      return true;
    }
    return false;
  }

  boolean clicked() {

    return isClicked;
  }
}

