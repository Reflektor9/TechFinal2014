class UFO extends Enemy
{
  //time of last shot
  int stime;
  //shot delay
  int sdelay;
  UFO(float x,float y, float vx, float vy,PImage t)
  {//set pos
    pos = new PVector(x,y);
    //set velocity
    vel = new PVector(vx,vy);
    //set size
    size = new PVector(50,50);
    //set health
    health = 3;
    //set speed
    speed = 4;
    //set velocity to speed in current direction
    vel.normalize();
    vel.mult(speed);
    //set last shot to 0
    stime = 0;
    //set delay
    sdelay = 1000;
    //enemy is a ufo
    u = true;
    //set texture
    tex = t;
  }
  @Override
  void display()
  {//display ufo
    image(tex,pos.x,pos.y,size.x,size.y);
  }
  @Override
  void move()
  {
    //ad velocity to position
    pos.add(vel);
  }
  @Override
  boolean shoot()
  {
    //if delay has passed
    boolean t = millis()-stime>=sdelay;
    if(t)
    {//set last shot to millis
      stime = millis();
    }
    return t;
  }
}
