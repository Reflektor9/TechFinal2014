class Bullet
{
  //position
  PVector pos;
  //size
  PVector size;
  //velocity
  PVector mov;
  //speed
  float speed = 10;
  //is this a friendly bullet
  boolean friendly;
  //is this a missile
  boolean miss;
  //texture
  PImage tex;
  Bullet(PVector p,boolean f,boolean mi,PImage te)
  {
    //set position
    pos = p;
    //set velocity to speed in given direction
    PVector m = new PVector(mouseX,mouseY);
    m.sub(p);
    m.normalize();
    m.mult(speed);
    mov = m;
    //set size
    size = new PVector(5,5);
    //set freindly to true
    friendly = true;
    // set missile
    miss = mi;
    // if it is a missile, double the size
    if(miss)
    {
      size.mult(2);
    }
    //set texture
    tex = te;
  }
  Bullet(PVector p, boolean f, PVector m,PImage te)
  {
    //set position
    pos = p;
    //set velocity to speed in a given direction
    m.normalize();
    m.mult(speed);
    mov = m;
    //set size
    size = new PVector(5,5);
    //set missile to false;
    miss = false;
    //set friendly to false
    friendly = false;
    //set texture
    tex = te;
  }
  void move()
  {
    //add velocity to position
    pos.add(mov);
  }
  void display()
  {
    if(friendly)
    {//if this is a friendly bullet, tint it green
      tint(127.5,255,127.5);
    }
    else
    {
      //if this is not a friendly bullet, tint it red
      tint(255,127.5,127.5);
    }
    //display bullet
    image(tex,pos.x,pos.y,size.x,size.y);
    noTint();
  }
  boolean offScreen()
  {
    //check if the bullet is offscreen
    boolean off = (pos.x<-size.x || pos.y<-size.y || pos.x>width+size.x || pos.y>height+size.y);
    return off;
  }
}
