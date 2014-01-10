class Bullet
{
  PVector pos;
  PVector size;
  PVector mov;
  float speed = 10;
  Bullet(PVector p)
  {
    pos = p;
    PVector m = new PVector(mouseX,mouseY);
    m.sub(p);
    m.normalize();
    m.mult(speed);
    mov = m;
    size = new PVector(5,5);
  }
  void move()
  {
    pos.add(mov);
  }
  void display()
  {
    ellipse(pos.x,pos.y,size.x,size.y);
  }
}
