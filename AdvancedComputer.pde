/*
Advanced: ball speeds up and the computer player gets better
over time(Speed shown on screen).
*/

final int SCREENX = 320;
final int SCREENY = 240;
final int PADDLEHEIGHT = 15;
final int PADDLEWIDTH = 50;
final int MARGIN = 10;

float s = millis();


class Player {
  int xpos; int ypos;
  color paddlecolor = color(50);
  int lives = 3;
  float computerSpeed = 1;
  Player(int screen_y)
  {
    xpos=SCREENX/2;
    ypos=screen_y;
  }
  
  void move(int x){
    if(x>SCREENX-PADDLEWIDTH) xpos = SCREENX-PADDLEWIDTH;
    else xpos=x;
  }
  
  void draw()
  {  
    fill(paddlecolor);
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
  
  void moveComputer(float xOfBall){
    if(s %40 == 0){
    computerSpeed += .001;
    }
    
    if (xOfBall > xpos + PADDLEWIDTH){
      xpos+= computerSpeed;
    }
    else if (xOfBall < xpos){
      xpos-= computerSpeed;
    }
    
  }
  void lostLife(){
    lives--;
  }
  
}

class Ball {
  float x; float y;
  float dx; float dy;
  int radius;
  color ballColor = color(200, 100, 50);
  Ball(){
    x = random(SCREENX/4, SCREENX/2);
    y = random(SCREENY/4, SCREENY/2);
    dx = random(1, 2); dy = random(1, 2);
    radius=5;
  }

  void move(){
    x = x+dx; y = y+dy;
  }
  void draw(){
    fill(ballColor);
    ellipse(int(x), int(y), radius, radius);
  }

  void collide(Player tp){
    if(y+radius >= tp.ypos && y-radius<tp.ypos+PADDLEHEIGHT && x >=tp.xpos && x <= tp.xpos+PADDLEWIDTH){
        println("collided!");
        dy=-dy;
    }
    
    if (y-radius <=0)
    dy = -dy;
  }
  
  void collide(){
    
    if(x-radius <=0) 
      dx=-dx;
    else if(x+radius>=SCREENX) dx=-dx;
    
    
    
  }
  
  
  void reset(){
    x = random(SCREENX/4, SCREENX/2);
    y = random(SCREENY/4, SCREENY/2);
    dx = random(1, 2); dy = random(1, 2);
    radius=5;
  }
  
  
}



Player thePlayer;
Player computerPlayer;
Ball theBall;

void settings(){
  size(SCREENX, SCREENY);
}
void setup(){
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  computerPlayer = new Player (MARGIN);
  theBall = new Ball();
  ellipseMode(RADIUS);
}
void mousePressed(){
  if(theBall.y + theBall.radius < 0){
        computerPlayer.lostLife();
       if(computerPlayer.lives > 0){
       theBall.reset();
       
    }
  }
  if((theBall.y - theBall.radius) > SCREENY){
      thePlayer.lostLife();
    if(thePlayer.lives > 0){
    theBall.reset();
    }
  
  }
}


  
void draw() {
  PFont myFont = loadFont("TeluguMN-18.vlw");
  PFont smallFont = loadFont("TeluguMN-12.vlw");
  background(190);
  thePlayer.move(mouseX);
  computerPlayer.moveComputer(theBall.x);
  theBall.move();
  theBall.collide();
  theBall.collide(thePlayer);
  theBall.collide(computerPlayer);
  computerPlayer.draw();
  thePlayer.draw();
  theBall.draw();
  
  if(thePlayer.lives == 0){
    fill(0);
    textFont(myFont);
    textAlign(CENTER);
    text("GameOver", SCREENX/2, SCREENY/2);
  }
  else if(computerPlayer.lives == 0){
    fill(0);
    textFont(myFont);
    textAlign(CENTER);
    text("Congratulations, you have won", SCREENX/2, SCREENY/2);
  }
  else{
    
    fill(10);
    textFont(smallFont);
    textAlign(LEFT);
    text("Computer lives: " + computerPlayer.lives, 20, 20);
    textAlign(LEFT);
    text("Player lives: "+ thePlayer.lives, 20, 225);
  
    fill(150);
    textFont(myFont);
    textAlign(CENTER);
    text("Computer Speed:" +String.format("%.1f", computerPlayer.computerSpeed), SCREENX/2, SCREENY/2);
  }
    
}
