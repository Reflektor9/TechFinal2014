int starttime = 0;
int phase = 3;
int maxNum = 20;
Player p;
int atime;
int adelay;
int utime;
int udelay;
int score = 0;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void setup()
{
  size(800, 800);
  rectMode(CENTER);
  BlackBox.init(this);
  p = new Player(width/2, height/2);
  adelay = 1000;
  atime = 0;
  udelay = 5000;
  utime = 0;
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
  adelay = 1000/(starttime+1);
  udelay = 5000*/(starttime+1);
  background(0);
  p.move();
  p.display();
  asteroidSpawn();
  ufoSpawn();
  if (mousePressed&&p.shoot())
  {
    PVector po = new PVector(p.pos.x, p.pos.y);
    bullets.add(new Bullet(po,true));
  }
  for (int i = bullets.size()-1;i>=0;i--)
  {
    Bullet b = bullets.get(i);
    b.move();
    b.display();
    if(p.bulletCol(b))
    {
      bullets.remove(i);
    }
    if(b.offScreen())
    {
      bullets.remove(i);
    }
  }
  for (int i = enemies.size()-1;i>=0;i--)
  {
    Enemy e = enemies.get(i);
    e.move();
    e.display();
    if(e.shoot())
    {
      PVector pos = new PVector(e.pos.x,e.pos.y);
      PVector v = new PVector(p.pos.x,p.pos.y);
      v.sub(pos);
      bullets.add(new Bullet(pos,false,v));
    }
    for (int j = bullets.size()-1;j>=0;j--)
    {
      Bullet b = bullets.get(j);
      if(e.bulletCol(b))
      {
        bullets.remove(j);
      }
    }
    if(!e.checkLive())
    {
      if(e.u)
      {
        score += 20;
      }
      else
      {
        score += 10;
      }
      enemies.remove(i);
    }
    else if(e.offScreen())
    {
      enemies.remove(i);
    }
    else if(p.enemyCol(e))
    {
      enemies.remove(i);
    }
  }
  if(!p.checkLives())
  {
    phase = 1;
  }
  println(score);
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
  if (enemies.size() <20)
  {
    if (millis()-atime >= adelay)
    {    
      atime = millis();
      PVector astPos;
      astPos = new PVector(0, 0);
      int side = int(random(0, 4));
      if (side==0)
      {
        astPos= new PVector(-25, random(-25, height+25));
      }
      if (side==1)
      {
        astPos= new PVector(random(-25, width+25), -25);
      }
      if (side==2)
      {
        astPos= new PVector(width+25, random(-25, height+25));
      }
      if (side==3)
      {
        astPos= new PVector(random(-25, width+25), height + 25);
      }
      PVector astVel = new PVector(p.pos.x, p.pos.y);
      astVel.sub(astPos);
      enemies.add(new Asteroid(astPos.x, astPos.y, astVel.x, astVel.y));
    }
  }
}
void ufoSpawn()
{
  if (enemies.size() <20)
  {
    if (millis()-utime >= udelay)
    {    
      utime = millis();
      PVector uPos;
      uPos = new PVector(0, 0);
      int side = int(random(0, 4));
      if (side==0)
      {
        uPos= new PVector(-25, random(-25, height+25));
      }
      if (side==1)
      {
        uPos= new PVector(random(-25, width+25), -25);
      }
      if (side==2)
      {
        uPos= new PVector(width+25, random(-25, height+25));
      }
      if (side==3)
      {
        uPos= new PVector(random(-25, width+25), height + 25);
      }
      PVector uVel = new PVector(p.pos.x, p.pos.y);
      uVel.sub(uPos);
      enemies.add(new UFO(uPos.x, uPos.y, uVel.x, uVel.y));
    }
  }
}

