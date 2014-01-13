abstract class Enemy
{
  PVector pos;
  PVector vel;
  PVector size;
  int health;
  float speed;
  PImage tex;

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
    if(b.friendly&&abs(pos.x-b.pos.x) <=(size.x+b.size.x)/2 && abs(pos.y-b.pos.y) <=(size.y+b.size.y)/2)
    {
      health--;
      t = true;
    }
    return t;
  }
  
  boolean checkLive()
  {
    boolean a = health >0;
    return a;
  }
  
}
