class Bullet
{
  //declaring pvector for position 
  PVector pos;
  //declaring pvector for size 
  PVector size;
  //declaring pvector for the movement 
  PVector mov;
  //variable declared for the speed
  float speed = 10;
  //
  boolean friendly;
  //
  boolean miss;
<<<<<<< HEAD
  //
  Bullet(PVector p,boolean f,boolean mi)
=======
  PImage tex;
  Bullet(PVector p,boolean f,boolean mi,PImage te)
>>>>>>> d5c62b5d0918b085cf99860e296157f7953108fe
  {
    //defining the position of the bullet
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
<<<<<<< HEAD
      //
      stroke(0,255,0);
      //filling it with red
      fill(255,0,0);
=======
      tint(255,127.5,127.5);
>>>>>>> d5c62b5d0918b085cf99860e296157f7953108fe
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
