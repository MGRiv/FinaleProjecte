int mode;
int buttonX,buttonY;
int buttonSize = 60;
boolean start;

void setup(){
  size(600,600);
  background(50);
  fill(45,32,100);
  rect(width/2 - 30,height/2 - 30,buttonSize,buttonSize,5);
  
}



void draw(){
  update();
  if(mode == 0){
   background(23,156,90); 
  }else{
   background(60,175,89);
  }
  rect(width/2 - 30,height/2 - 30,buttonSize,buttonSize,5);
}

void mousePressed(){
 if(start == true){
  mode = 1;
 }else{
  mode = 0; 
 } 
}

void update(){
  if(overRectButton(width/2 - 30,height/2 - 30,buttonSize,buttonSize)){
    start = true;
  }else{
    start = false;
  }
}

boolean overRectButton(int x, int y, int w, int h){
 if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
   return true; 
 }else{
   return false;
 }
}
