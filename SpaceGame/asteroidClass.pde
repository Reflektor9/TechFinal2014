class Asteroid extends Enemy
{
  Asteroid(float x,float y, float vx,float vy)
  {
    pos = new PVector(x,y);
    vel = new PVector(vx,vy);
    size = new PVector(50,50);
    health = 2;
    speed = 4;
    vel.normalize();
    vel.mult(speed);
  }
  @Override
  void display()
  {
    stroke(0,0,255);
    fill(255,127.5,0);
    rect(pos.x,pos.y,size.x,size.y);
  }
  @Override
  void move()
  {
    pos.add(vel);
  }
}
