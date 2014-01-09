class Bullet
{
  PVector pos;
  PVector size;
  PVector mov;
  Bullet(PVector p,PVector m)
  {
    pos = p;
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
