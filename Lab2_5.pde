/*
Extra credit 1:
Modify your program so that the speed and direction of movement of the bat affects
the trajectory of the ball when struck.
*/

final int SCREENX = 320;
final int SCREENY = 240;
final int PADDLEHEIGHT = 15;
final int PADDLEWIDTH = 50;
final int MARGIN = 10;




class Player {
  int xpos; int ypos;
  color paddlecolor = color(50);
  int lives = 3;
  int prevTime, prevPos, currPos, currTime;
  
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
  
  void moveComputer(int xOfBall){
    if (xOfBall > xpos){
      xpos++;
    }
    else{
      xpos--;
    }
    
  }
  void lostLife(){
    --lives;
  }
  
  float velocity(){
    
  float currTime=second();  //Current time 
  //....Get current postion and time
  float currPos = mouseX;  
 
  //Process current and prev position: Calculate velocity for instance
  float deltaPos = currPos, prevPos;
  float dt = (second() - prevTime)/1000.0;  
  float velocity = deltaPos;  
 
  //Update previous position
  prevPos=currPos;
  prevTime=second();
  return velocity;
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
        speedOfBall(tp);
        dy = -dy;
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
  
  void speedOfBall(Player tp){
    dx = tp.velocity() /55;
    
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
  computerPlayer.move((int)theBall.x);
  theBall.move();
  theBall.collide();
  theBall.collide(thePlayer);
  theBall.collide(computerPlayer);
  computerPlayer.draw();
  thePlayer.draw();
  theBall.draw();
  
  if(thePlayer.lives <= 0){
    fill(0);
    textFont(myFont);
    textAlign(CENTER);
    text("GameOver", SCREENX/2, SCREENY/2);
  }
  else if(computerPlayer.lives <= 0){
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
  
  }
}
