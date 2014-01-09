int phase = 2;
PImage rocket;
PImage earth;
PVector yspeed;
int y = 525;
PVector yacc;
ArrayList<Particle> flame = new ArrayList<Particle>();

void setup()
{
  size(800, 800);
  rocket = loadImage("rocket1.png");
  earth = loadImage("Earth1.png");
  yspeed = new PVector(0,1);
  yacc = new PVector(0,0.15);
  
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
  //treat as if this section is void draw in order to display and send the rocket up, etc.
  //if a certain boolean is true it'll go autmatically 
  background(0);
  imageMode(CENTER);
  image(earth, width/2, height+200, 1250, 1000);
  image(rocket, width/2, y, 50, 100);
  y-= yspeed.y;
  yspeed.add(yacc);
  
  flame.add(new Particle(width/2,y)); 
  for (int i = flame.size()-1; i >= 0; i--) {
    Particle f = flame.get(i);
    f.display();
    f.move();
  }
  
}

