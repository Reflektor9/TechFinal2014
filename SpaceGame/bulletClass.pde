class Bullet
{
  PVector pos;
  PVector size;
  PVector mov;
  float speed = 10;
  boolean friendly;
  boolean miss;
  Bullet(PVector p,boolean f,boolean mi)
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
  }
  Bullet(PVector p, boolean f, PVector m)
  {
    pos = p;
    m.normalize();
    m.mult(speed);
    mov = m;
    size = new PVector(5,5);
    miss = false;
  }
  void move()
  {
    pos.add(mov);
  }
  void display()
  {
    if(friendly)
    {
      stroke(255,0,0);
      fill(0,255,0);
    }
    else
    {
      stroke(0,255,0);
      fill(255,0,0);
    }
    ellipse(pos.x,pos.y,size.x,size.y);
  }
  boolean offScreen()
  {
    boolean off = (pos.x<-size.x || pos.y<-size.y || pos.x>width+size.x || pos.y>height+size.y);
    return off;
  }
}
