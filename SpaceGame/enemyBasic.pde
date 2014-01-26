abstract class Enemy
{
  //declarieng pvector for position 
  PVector pos;
  //declarieng pvector for velocity
  PVector vel;
  //declarieng pvector for size
  PVector size;
  //declaring variable for the enemies health/lifespan
  int health;
  //decaring variable for the speed of the enemy
  float speed;
  //image for the texture
  PImage tex;
  //
  boolean u;

  abstract void display();

  abstract void move();

  abstract boolean shoot();

  boolean offScreen()
  {
    boolean off = (pos.x<-size.x||pos.y<-size.y||pos.x>width+size.x||pos.y>height+size.y);
    return off;
  }

  boolean bulletCol(Bullet b)
  {
    boolean t = false;
    if (b.friendly&&abs(pos.x-b.pos.x) <=(size.x+b.size.x)/2 && abs(pos.y-b.pos.y) <=(size.y+b.size.y)/2)
    {
      health--;
      t = true;
      if (b.miss)
      {
        health =0;
      }
    }
    return t;
  }

  boolean checkLive()
  {
    boolean a = health >0;
    return a;
  }
}

