int phase = 3;
Player p;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
void setup()
{
  size(800,800);
  rectMode(CENTER);
  BlackBox.init(this);
  p = new Player(width/2,height/2);
}
void draw()
{
  if (phase == 0)
  {
    title();
  }
  else if (phase == 1)
  {
    menu();
  }
  else if (phase == 2)
  {
    launch();
  }
  else if (phase == 3)
  {
    play();
  }
  else if (phase == 4)
  {
    store();
  }
  
}
void play()
{
  p.move();
  p.display();
  if(mousePressed&&p.shoot())
  {
    PVector bmove = new PVector(mouseX,mouseY);
    bmove.sub(p.pos);
    bmove.normalize();
    bmove.mult(10);
    bullets.add(new Bullet(p.pos,bmove));
  }
  for(int i = bullets.size()-1;i>=0;i--)
  {
    Bullet b = bullets.get(i);
    b.move();
    b.display();
  }
}
void store()
{
  
}
void menu()
{
  
}
void title()
{
  
}
void launch()
{
  
}
