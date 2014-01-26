class Asteroid extends Enemy
{
  Asteroid(float x,float y, float vx,float vy,PImage t)
  {
    //position of the asteroid
    pos = new PVector(x,y);
    //velocity of the asteroid
    vel = new PVector(vx,vy);
    //size of of the asteroid
    size = new PVector(50,50);
    //health of the asteroid (lifespan)
    health = 2;
    //speed of the asteroid
    speed = 4;
    //
    vel.normalize();
    //velocity times speed property
    vel.mult(speed);
    //
    u = false;
    //texture of asteroid
    tex = t;
  }
  @Override
  void display()
  {
   image(tex,pos.x,pos.y,size.x,size.y);
  }
  @Override
  void move()
  {
    //adding position to the velocity 
    pos.add(vel);
  }
  @Override
  //so the player can shoot at the asteroid
  boolean shoot()
  {
    return false;
  }
}
