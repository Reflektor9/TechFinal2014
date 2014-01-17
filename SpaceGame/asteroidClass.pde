class Asteroid extends Enemy
{
  Asteroid(float x,float y, float vx,float vy,PImage t)
  {
    pos = new PVector(x,y);
    vel = new PVector(vx,vy);
    size = new PVector(50,50);
    health = 2;
    speed = 4;
    vel.normalize();
    vel.mult(speed);
    u = false;
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
    pos.add(vel);
  }
  @Override
  boolean shoot()
  {
    return false;
  }
}
