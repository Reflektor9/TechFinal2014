class Player
{
  PVector pos;
  PVector size;
  float speed;
  int shottime;
  int shotwait;
  int score;
  int lives;
  PImage tex;
  Player(float x, float y, PImage t)
  {
    pos = new PVector(x,y);
    size = new PVector(42,75);
    speed = 4;
    shotwait = 250;
    shottime = -shotwait;
    score = 0;
    lives = 5;
    tex = t;
  }
  void display()
  {
//    stroke(255,0,0);
//    fill(0,255,0);
//    rect(pos.x,pos.y,size.x,size.y);
    image(tex,pos.x,pos.y,size.x,size.y);
  }
  void move()
  {
    boolean pressed = false;
    PVector amt = new PVector (0,0);
    if(BlackBox.isKeyDown(BlackBox.VK_A))
    {
      amt.x -= 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_D))
    {
      amt.x += 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_W))
    {
      amt.y -= 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_S))
    {
      amt.y += 1;
      pressed = true;
    }
    if(pressed)
    {
      amt.normalize();
      amt.mult(speed);
      pos.add(amt);
    }
    if(pos.x-size.x/2<=0)
    {
      pos.x=size.x/2;
    }
    if(pos.x+size.x/2>=width)
    {
      pos.x=width-size.x/2;
    }
    if(pos.y-size.y/2<=0)
    {
      pos.y=size.y/2;
    }
    if(pos.y+size.y/2>=height)
    {
      pos.y=height-size.y/2;
    }
  }
  boolean shoot()
  {
    boolean t = millis()-shotwait>=shottime;
    if(t)
    {
      shottime = millis();
    }
    return t;
  }
  boolean enemyCol(Enemy e)
  {
    boolean t = false;
    if(abs(pos.x-e.pos.x) <=(size.x+e.size.x)/2 && abs(pos.y-e.pos.y) <=(size.y+e.size.y)/2)
    {
      lives--;
      t = true;
    }
    return t;
  }
  boolean checkLives()
  {
    boolean t = lives>0;
    return t;
  }
  boolean bulletCol(Bullet b)
  {
    boolean c = false;
    if(!b.friendly)
    {
      if(abs(pos.x-b.pos.x) <=(size.x+b.size.x)/2 && abs(pos.y-b.pos.y) <=(size.y+b.size.y)/2)
      {
        lives--;
        c = true;
      }
    }
    return c;
  }
}
