class Asteroid extends Enemy
{
  Asteroid(float x,float y, float vx,float vy,PImage t)
  {//set position
    pos = new PVector(x,y);
    //set velocity
    vel = new PVector(vx,vy);
    //set size
    size = new PVector(50,50);
    //health
    health = 2;
    //speed
    speed = 4;
    //set velocity to be speed toward the the player
    vel.normalize();
    vel.mult(speed);
    //asteroid is not a ufo
    u = false;
    tex = t;
  }
  @Override
  void display()
  {
    //display asterosi
   image(tex,pos.x,pos.y,size.x,size.y);
  }
  @Override
  void move()
  {//add velociy to position
    pos.add(vel);
  }
  @Override
  boolean shoot()
  {//asteroids do not shoot
    return false;
  }
}
