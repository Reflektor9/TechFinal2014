int fnum = 1;
int maxNum = 20;
Player p;
int atime;
int adelay;
int utime;
int udelay;
int score = 0;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PFont BankGothic;
PFont OCR;
int phase = 0;
//variable for rocket image
PImage rocket;
//variable for earth image
PImage earth;
//speed of the rocket
PVector yspeed;
//starting position for the rocket 
int y = 525;
//for the acceleration of the rocket
PVector yacc;
//declare array list for flames particles
ArrayList<Particle> flame = new ArrayList<Particle>();
void setup()
{
  size(800, 800);
  rectMode(CENTER);
  BlackBox.init(this);
  textAlign(CENTER, CENTER);
  p = new Player(width/2, height/2);
  adelay = 1000000;
  atime = 0;
  udelay = 5000000;
  utime = 0;
   //rocket image
  rocket = loadImage("rocket1.png");
  //earth image
  earth = loadImage("Earth1.png");
  //speed of rocket
  yspeed = new PVector(0, 0.75);
  //so that the rocket will accelerate 
  yacc = new PVector(0, 0.12);
  BankGothic = loadFont("BankGothicBT-Light-200.vlw");
  OCR = loadFont("OCRAExtended-112.vlw");

}

void draw()
{  
  println(millis());
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

  adelay = 1000000/(fnum);
  udelay = 5*adelay*int(abs(cos(fnum))+1);
  fnum++;

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
    bullets.clear();
    enemies.clear();
    phase = 1;
  }
  println(score);
}

void store()
{
}

void menu()
{

//black background
  background(0);
  //different font
  textFont(BankGothic);
  //menu text size
  textSize(200);
  //MENU text displayed, white color
  text("MENU", width/2, height/4);
  //fill text red
  fill(255, 0, 0);
  //"button" for Launch
  rect(width/2, 2*height/3-80, width/2, height/6);
  //fill blue
  fill(0, 0, 255);
  //"button" for Store
  rect(width/2, 2*height/3+90, width/2, height/6);
  //fill white
  fill(255);
  //text size
  textSize(100);
  //text for buttons
  text("Launch\n\n\nStore", width/2, 2*height/3);
}

void title()
{
  fill(255);
  background(0);
  textFont(OCR);
  textSize(112);
  text("SPACE GAME", width/2, height/3);
  fill(0, 255, 0);
  rect(width/2, 2*height/3+15, width/2, height/4);
  fill(255);
  textSize(100);
  text("Play!", width/2, 2*height/3);
}

void launch()
{
  //treat as if this section is void draw in order to display and send the rocket up, etc.
  //if a certain boolean is true it'll go autmatically 
  background(0);
  //changing the reference for the image 
  imageMode(CENTER);
  //displaying the earth
  image(earth, width/2, height+200, 1250, 1000);
  //displaying the rocket
  image(rocket, width/2, y, 50, 100);
  //moving the rocket up the screen
  y-= yspeed.y;
  //making it so the rocket will accelerate
  yspeed.add(yacc);
  //for loop for the particles
  flame.add(new Particle(width/2, y+50)); 
  for (int i = flame.size()-1; i >= 0; i--) {
    Particle f = flame.get(i);
    //display and move
    f.display();
    f.move();
    //to remove the particles
    if (f.fadeaway()) {
      flame.remove(i);
    }
  }
  if (y <= -555) {
    phase = 3;
    reset();
    fnum = 1;
  }
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
      else if (side==1)
      {
        astPos= new PVector(random(-25, width+25), -25);
      }
      else if (side==2)
      {
        astPos= new PVector(width+25, random(-25, height+25));
      }
      else
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
void reset()
{
  p = new Player(width/2, height/2);
  adelay = 1000000;
  atime = millis();
  udelay = 5000000;
  utime = millis();
}
void mousePressed() {
  if (phase == 0) {
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 13*height/24 + 15 && mouseY < 19*height/24 + 15) {
      phase = 1;
    }
  }
  else if (phase == 1) {
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 7*height/12 - 80 && mouseY < 9*height/12 - 80) {
      phase = 2;
      y = 525;
      flame.clear();
      yspeed = new PVector(0,0);
      
    }
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 7*height/12 + 90 && mouseY < 9*height/12 + 90) {
      phase = 4;
    }
  }
}


