class Player
{
  //position
  PVector pos;
  //size
  PVector size;
  //speed
  float speed;
  //time of last shot
  int shottime;
  //shot delay
  int shotwait;
  //lives
  int lives;
  //do we have a shield
  boolean shield;
  //texture
  PImage tex;
  Player(float x, float y, PImage t)
  {
    //set position
    pos = new PVector(x,y);
    //set size
    size = new PVector(42,75);
    //set maximum speed
    speed = 4;
    //set shot delay
    shotwait = 250;
    //set last shot
    shottime = -shotwait;
    //set lives
    lives = 5;
    //set texture
    tex = t;
    //set shield to false
    shield = false;
  }
  void display()
  {
    //display ship
    image(tex,pos.x,pos.y,size.x,size.y);
    if(shield)
    {//if shield, display an ellipse
      noStroke();
      fill(0,255,0,75);
      ellipse(pos.x-.5,pos.y,size.x,size.y-1);
    }
  }
  void move()
  {
    //have we pressed a button
    boolean pressed = false;
    //amount moved
    PVector amt = new PVector (0,0);
    if(BlackBox.isKeyDown(BlackBox.VK_A))
    {//if a is pressed subtract 1 from amt.x and pressed = true
      amt.x -= 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_D))
    {//if a is pressed add 1 to amt.x and pressed = true
      amt.x += 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_W))
    {//if a is pressed subtract 1 from amt.y and pressed = true
      amt.y -= 1
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_S))
    {//if a is pressed add 1 to amt.x and pressed = true
      amt.y += 1;
      pressed = true;
    }
    if(pressed)
    {//if pressed set amt to speed in current direction and add to position
      amt.normalize();
      amt.mult(speed);
      pos.add(amt);
    }
    if(pos.x-size.x/2<=0)
    {//if off screen to the left, set to left of the screen
      pos.x=size.x/2;
    }
    if(pos.x+size.x/2>=width)
    {//if off screen to the rght, set to right of the screen
      pos.x=width-size.x/2;
    }
    if(pos.y-size.y/2<=0)
    {//if above screen, set to top of the screen
      pos.y=size.y/2;
    }
    if(pos.y+size.y/2>=height)
    {//if below screen, set to bottom of screen
      pos.y=height-size.y/2;
    }
  }
  boolean shoot()
  {
    boolean t = millis()-shotwait>=shottime;
    if(t)
    {// if shot delay has passed set shottime to millis
      shottime = millis();
    }
    //return whether enough time has passed
    return t;
  }
  boolean enemyCol(Enemy e)
  { //if difference in x and y is les than average size x and y
    boolean t = false;
    if(abs(pos.x-e.pos.x) <=(size.x+e.size.x)/2 && abs(pos.y-e.pos.y) <=(size.y+e.size.y)/2)
    {
      if(shield)
      {//if shield is active, deactivate it
        shield = false;
      }
      else
      {//if not, subtract a life
        lives--;
      }
      t = true;
    }
    return t;
  }
  boolean checkLives()
  {//is lives greater than 0
    boolean t = lives>0;
    return t;
  }
  boolean bulletCol(Bullet b)
  { //if difference in x and y is les than average size x and y
    boolean c = false;
    if(!b.friendly)
    {
      if(abs(pos.x-b.pos.x) <=(size.x+b.size.x)/2 && abs(pos.y-b.pos.y) <=(size.y+b.size.y)/2)
      {
        if(shield)
        {//if shield is active, deactivate it
          shield = false;
        }
        else
        {//if not, subtract a life
          lives--;
        }
        c = true;
      }
    }
    return c;
  }
}
