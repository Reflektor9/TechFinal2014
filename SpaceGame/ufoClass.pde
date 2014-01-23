class UFO extends Enemy
{
  int stime;
  int sdelay;
  UFO(float x,float y, float vx, float vy,PImage t)
  {
    pos = new PVector(x,y);
    vel = new PVector(vx,vy);
    size = new PVector(50,50);
    health = 3;
    speed = 4;
    vel.normalize();
    vel.mult(speed);
    stime = 0;
    sdelay = 1000;
    u = true;
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
    boolean t = millis()-stime>=sdelay;
    if(t)
    {
      stime = millis();
    }
    return t;
  }
}
