import java.util.*;
long lastTime;
String words;
boolean zPressed;
int nextset;
ArrayList<String> sets;
void setup() {
  sets=new ArrayList<String>(1);
  lastTime=millis();
  words="Let's get down to business To defeat the huns. Did they send me daughters When I asked for sons? You're the saddest bunch I ever met But you can bet before we're through Mister, I'll make a man Out of you.";
  size(600, 600);
  background(#FFFFFF);
  dialogue(words);
  nextset=0;
}

void draw() {
  background(#FA0330);
  //fill(0);
  // stroke(255, 300);
  // strokeWeight(4);
  // rect(width/24, height*3/4, width-width/12, height/5, 30);
  fill(0);
  stroke(255, 300);
  strokeWeight(4);
  rect(width/24, height*3/4, width-width/12, height/5, 30);
  fill(255);
  textSize(24);
  text("YAY:", width/24+30, height*3/4+70);
  textSize(16);

  text(sets.get(nextset), width/24+100, height*3/4+30);
  processKeys();
  // textSize(16);
  //text("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", width/24+100, height*3/4+30);
  int limit=46;
}

void dialogue(String text) {
  System.out.println("START...............................................................................................................");
  String list[]=split(text, ' ');

  String str="";
  int counter=0;
  int lines=0;
  for (String word : list) {

    if (word.length()+counter>=46) {
      lines+=1;
      str+="\n";
      counter=0;
    } else if (lines==3) {
      sets.add(str);
      counter=0;
      str="";
      lines=0;
    }
    str+=word+" ";
    counter+=word.length();
  }
  if (str.length()!=0) {
    sets.add(str);
  }
}

void processKeys() {
  if (zPressed) {
    zPressed=false;
    nextset++;
    text(sets.get(nextset), width/24+100, height*3/4+30);
  }
}


void keyPressed() {
  if (keyCode==90) {
    zPressed=true;
  }
}

void keyReleased() {
  if (keyCode==90) {
    zPressed=false;
  }
}

void newTextBox() {
  fill(0);
  stroke(255, 300);
  strokeWeight(4);
  rect(width/24, height*3/4, width-width/12, height/5, 30);
  fill(255);
  textSize(24);
  text("YAY:", width/24+30, height*3/4+70);
}

