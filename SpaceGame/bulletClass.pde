class Bullet
{
  PVector pos;
  PVector size;
  PVector mov;
  float speed = 10;
  boolean friendly;
  boolean miss;
  PImage tex;
  Bullet(PVector p,boolean f,boolean mi,PImage te)
  {
    pos = p;
    PVector m = new PVector(mouseX,mouseY);
    m.sub(p);
    m.normalize();
    m.mult(speed);
    mov = m;
    size = new PVector(5,5);
    friendly = true;
    miss = mi;
    if(miss)
    {
      size.mult(2);
    }
    tex = te;
  }
  Bullet(PVector p, boolean f, PVector m,PImage te)
  {
    pos = p;
    m.normalize();
    m.mult(speed);
    mov = m;
    size = new PVector(5,5);
    miss = false;
    tex = te;
  }
  void move()
  {
    pos.add(mov);
  }
  void display()
  {
    if(friendly)
    {
      tint(127.5,255,127.5);
    }
    else
    {
      tint(255,127.5,127.5);
    }
    image(tex,pos.x,pos.y,size.x,size.y);
    noTint();
  }
  boolean offScreen()
  {
    boolean off = (pos.x<-size.x || pos.y<-size.y || pos.x>width+size.x || pos.y>height+size.y);
    return off;
  }
}
