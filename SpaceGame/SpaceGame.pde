int phase = 3;
Player p;
int atime;
int adelay;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void setup()
{
  size(displayHeight-100,displayHeight-100);
  rectMode(CENTER);
  BlackBox.init(this);
  p = new Player(width/2,height/2);
  adelay = 1000;
  atime = 0;
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
  background(0);
  p.move();
  p.display();
  asteroidSpawn();
  if(mousePressed&&p.shoot())
  {
    PVector po = new PVector(p.pos.x,p.pos.y);
    bullets.add(new Bullet(po));
  }
  for(int i = bullets.size()-1;i>=0;i--)
  {
    Bullet b = bullets.get(i);
    b.move();
    b.display();
  }
  for(int i = enemies.size()-1;i>=0;i--)
  {
    Enemy e = enemies.get(i);
    e.move();
    e.display();
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
void asteroidSpawn()
{
  if(millis()-atime >= adelay)
  {    
    atime = millis();
    PVector astPos;
    astPos = new PVector(0,0);
    int side = int(random(0,3));
    if(side==0)
    {
       astPos= new PVector(-25,random(-25,height+25));
    }
    if(side==1)
    {
       astPos= new PVector(random(-25,width+25),-25);
    }
    if(side==2)
    {
       astPos= new PVector(-25,random(width + 25,height+25));
    }
    if(side==3)
    {
       astPos= new PVector(random(-25,width+25),height + 25);
    }
    PVector astVel = new PVector(p.pos.x,p.pos.y);
    astVel.sub(astPos);
    enemies.add(new Asteroid(astPos.x,astPos.y,astVel.x,astVel.y));
  }
}
