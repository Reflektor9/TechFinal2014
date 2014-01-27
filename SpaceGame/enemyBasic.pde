abstract class Enemy
{
  //position
  PVector pos;
  //velocity
  PVector vel;
  //size
  PVector size;
  //health
  int health;
  //speed
  float speed;
  //texture
  PImage tex;
  //is this a ufo
  boolean u;

  abstract void display();

  abstract void move();
  
  abstract boolean shoot();

  boolean offScreen()
  {
    //check if enemy is offscreen
    boolean off = (pos.x<-size.x||pos.y<-size.y||pos.x>width+size.x||pos.y>height+size.y);
    return off;
  }
  
  boolean bulletCol(Bullet b)
  {
    boolean t = false;
    //if difference in x and y is les than average size x and y
    if(b.friendly&&abs(pos.x-b.pos.x) <=(size.x+b.size.x)/2 && abs(pos.y-b.pos.y) <=(size.y+b.size.y)/2)
    {
      //decrement health
      health--;
      //set t to true
      t = true;
      if(b.miss)
      {//if the bullet is a missile, set health to 0
        health =0;
      }
    }
    return t;
  }
  
  boolean checkLive()
  {
    //is health greater than 0
    boolean a = health >0;
    return a;
  }
  
}
