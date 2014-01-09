int phase = 3;
Player p;
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
