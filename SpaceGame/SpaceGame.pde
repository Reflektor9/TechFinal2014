//variable declared for number of frames since launched
int fnum = 1;
//variable declared to establish which phase the game is in, and therefore what will be displayed, etc. Initially set to 0
int phase = 0;
//variable declared for maximum number of enemies
int maxNum = 15;
//variable declared for money (which is attained through playing the game)
int money = 0;
//player created by using Player class
Player p;
//variable declared for asteroid spawning time 
int atime;
//variable declared for time between asteroid spawns 
int adelay;
//variable declared for ufo spawning time 
int utime;
//variable declared for time between ufo spawns
int udelay;
//variable declared for score within the game.
int score = 0;
//Array list declared for bullets
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//Array list declared for enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
//Array list declared for power ups
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
//variable declared for font (used for Menu Screen)
PFont BankGothic;
//variable declared for font (used for Start screen) 
PFont OCR;
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
//image for space window in store
PImage spaceWindow;
//image for the merchant 
PImage merchant;
//image for the asteroid texture
PImage astTex;
//image for the ufo texture
PImage ufoTex;
//boolean for if the spacebar is pressed in the frame before
boolean spacePressed = false;
//variable for the missile powerups
int missiles;
//variable for the bombs powerup
int bombs;

PImage bulletTex;
PImage[] powerTex;

void setup()
{
  size(800, 800);
  rectMode(CENTER);
  BlackBox.init(this);
  textAlign(CENTER, CENTER);
  //New Player defined
  p = new Player(width/2, height/2, rocket);
  //value for time between asteroid spawning 
  adelay = 1000000;
  //time 
  atime = 0;
  udelay = 5000000;
  utime = 0;
  //rocket image
  rocket = loadImage("rocket1.png");
  //earth image
  astTex = loadImage("asttex.png");
  ufoTex = loadImage("ufotex.png");
  earth = loadImage("Earth1.png");
  bulletTex = loadImage("bullet.png");
  powerTex = new PImage[4];
  powerTex[0] = loadImage("heart.png");
  //speed of rocket
  yspeed = new PVector(0, 0.75);
  //so that the rocket will accelerate 
  yacc = new PVector(0, 0.12);
  BankGothic = loadFont("BankGothicBT-Light-200.vlw");
  OCR = loadFont("OCRAExtended-112.vlw");
  spaceWindow= loadImage ("spaceWindow.jpg");
  merchant= loadImage ("ForthDoctorMerchantEdited.png");
  bombs = 0;
  missiles = 0;
}
void draw()
{  
  println(millis());
  if (phase == 0)
  {
    //title screen if phase = 0
    title();
  }
  else if (phase == 1)
  {
    //menu screen if phase = 1
    menu();
  }
  else if (phase == 2)
  {
    //launch screen in phase = 2
    launch();
  }
  else if (phase == 3)
  {
    //game play if phase = 3
    play();
  }
  else if (phase == 4)
  {
    //store displayed if phase = 4
    store();
  }
}

void play()
{
  //time between spawns of asteroids
  adelay = 1000000/(fnum);
  //time between spawns of ufos
  udelay = 5*adelay*int(abs(cos(fnum))+1);
  //increasing the number of frames after launched 
  fnum++;

  background(0);
  p.move();
  p.display();
  asteroidSpawn();
  ufoSpawn();
  if (mousePressed&&p.shoot())
  {
    PVector po = new PVector(p.pos.x, p.pos.y);
    boolean m = false;
    if (mouseButton==RIGHT && missiles >0)
    {
      m = true;
      missiles--;
    }
    bullets.add(new Bullet(po, true, m));
  }
  if (BlackBox.isKeyDown(BlackBox.VK_SPACE) && !spacePressed && bombs>0)
  {
    enemies.clear();
    bombs--;
  }
  for (int i = bullets.size()-1;i>=0;i--)
  {
    Bullet b = bullets.get(i);
    b.move();
    b.display();
    if (p.bulletCol(b))
    {
      bullets.remove(i);
    }
    if (b.offScreen())
    {
      bullets.remove(i);
    }
  }
  for (int i = powerups.size()-1;i>=0;i--)
  {
    PowerUp pu = powerups.get(i);
    pu.display();
    if (pu.playerCol(p))
    {
      if (pu.type == 0)
      {
        p.lives = 5;
      }
      else if (pu.type == 1)
      {
        p.shield = true;
      }
      else if (pu.type == 2)
      {//increasing number of missiles
        missiles++;
      }
      else
      {
        //increasing number of bombs
        bombs++;
      }
      powerups.remove(i);
    }
  }
  for (int i = enemies.size()-1;i>=0;i--)
  {
    Enemy e = enemies.get(i);
    e.move();
    e.display();
    if (e.shoot())
    {
      PVector pos = new PVector(e.pos.x, e.pos.y);
      PVector v = new PVector(p.pos.x, p.pos.y);
      v.sub(pos);
      bullets.add(new Bullet(pos, false, v));
    }
    for (int j = bullets.size()-1;j>=0;j--)
    {
      Bullet b = bullets.get(j);
      if (e.bulletCol(b))
      {
        bullets.remove(j);
      }
    }
    if (!e.checkLive())
    {
      if (e.u)
      {
        score += 20;
      }
      else
      {
        score += 10;
      }
      int rand = int(random(40));
      if (rand <4)
      {
        powerups.add(new PowerUp(e.pos, rand));
      }
      enemies.remove(i);
    }
    else if (e.offScreen())
    {
      enemies.remove(i);
    }
    else if (p.enemyCol(e))
    {
      enemies.remove(i);
    }
  }
  if (!p.checkLives())
  {
    bullets.clear();
    enemies.clear();
    powerups.clear();
    phase = 1;
  }
  println(score);
  spacePressed = BlackBox.isKeyDown(BlackBox.VK_SPACE);
}
void store()
{

  background (255, 80, 80);
  rectMode (CORNER); 
  fill (150, 190, 230);
  rect (30, height-400, width-30, 350);
  //Display counter of store
  textSize (80);
  textAlign (CORNER);
  fill (15, 5, 210);
  text ("THE A", 34, 100);
  fill (25, 15, 255);
  text ("STORE", 285, 100);
  fill (15, 5, 220);
  text ("OID", 576, 100);
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
  fill (0);
  if (mouseX >= 60 && mouseX <= 200 && mouseY >= 145 && mouseY <= 255 && mousePressed) {
    phase = 1;
  }
  //clicking on the space window returns the player back to gameplay
  textSize (22);
  text ("WELCOME TO THE STORE. CLICK ON WHAT YOU WANT TO BUY", width/2, height-10);
  //text explains the function of the store and how to use it
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
  //to ensure that everything is reset once the phase is over
  if (y <= -555) {
    phase = 3;
    reset();
    fnum = 1;
  }
}
void asteroidSpawn()
{
  //if there are less than 
  if (enemies.size() < maxNum)
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
      enemies.add(new Asteroid(astPos.x, astPos.y, astVel.x, astVel.y, astTex));
    }
  }
}
void ufoSpawn()
{
  if (enemies.size() <maxNum)
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
      else if (side==1)
      {
        uPos= new PVector(random(-25, width+25), -25);
      }
      else if (side==2)
      {
        uPos= new PVector(width+25, random(-25, height+25));
      }
      else
      {
        uPos= new PVector(random(-25, width+25), height + 25);
      }
      PVector uVel = new PVector(p.pos.x, p.pos.y);
      uVel.sub(uPos);
      enemies.add(new UFO(uPos.x, uPos.y, uVel.x, uVel.y, ufoTex));
    }
  }
}
void reset()
{
  p = new Player(width/2, height/2, rocket);
  adelay = 1000000;
  atime = millis();
  udelay = 5000000;
  utime = millis();
  money += score;
  score = 0;
}
void mousePressed() {
  //button that if clicked, will change the phase to one and bring the start screen to the menu screen
  if (phase == 0) {
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 13*height/24 + 15 && mouseY < 19*height/24 + 15) {
      phase = 1;
    }
  }

  //button that if clicked, will change phase to 2 and therefore display the launch screen 
  else if (phase == 1) {
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 7*height/12 - 80 && mouseY < 9*height/12 - 80) {
      phase = 2;
      y = 525;
      flame.clear();
      yspeed = new PVector(0, 0);
    }
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 7*height/12 + 90 && mouseY < 9*height/12 + 90) {
      phase = 4;
    }
  }
}

