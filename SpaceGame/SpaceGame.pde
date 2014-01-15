int phase = 4;
int maxNum = 20;
Player p;
int atime;
int adelay;
int utime;
int udelay;
int score = 0;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage spaceWindow;
PImage merchant;
void setup()
{
  size(800, 800);
  rectMode(CENTER);
  BlackBox.init(this);
  p = new Player(width/2, height/2);
  spaceWindow= loadImage ("spaceWindow.jpg");
  merchant= loadImage ("ForthDoctorMerchantEdited.png");
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
  if (mousePressed&&p.shoot())
  {
    PVector po = new PVector(p.pos.x, p.pos.y);
    bullets.add(new Bullet(po));
  }
  for (int i = bullets.size()-1;i>=0;i--)
  {
    Bullet b = bullets.get(i);
    b.move();
    b.display();
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
      enemies.remove(i);
      score+=10;
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
  
  background (255, 80, 80);
  rectMode (CORNER); 
  fill (150, 190, 230);
  rect (30, height-400, width-30, 350);
  //Display counter of store
  textSize (90);
 textAlign (CORNER);
  fill (15, 5, 220);
  text ("THE A", 20, 100);
  fill (25, 15, 245);
  text ("STORE", 285, 100);
   fill (15, 5, 220);
  text ("OID", 570, 100);
  //Text: "THE ASTOREOID".  The "STORE" portion is more brightly colored, emphasizing the wordplay
  rectMode (CENTER);
  fill (100, 70, 100);
  rect (130, 200, 160, 130);
  //window frame
  imageMode (CENTER);
  image (spaceWindow, 130, 200, 140, 110);
  //window shows space outside, allowing you to return
  image (merchant, 725, 264);
  //Space merchant stands at the side
   textAlign (CENTER);
  textSize (25);
  fill (0);
  if (mouseX >= 60 && mouseX <= 200 && mouseY >= 145 && mouseY <= 255 && mousePressed) {
    phase = 3;
  }
  //clicking on the space window returns the player back to gameplay
  text ("WELCOME TO THE STORE. CLICK ON WHAT YOU WANT TO BUY", width/2, height-10);
  //text explains the function of the store and how to use it
  
}
void menu()
{
  background(255,0,0);
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

