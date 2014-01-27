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

//Image for return icon
PImage spaceWindow;
//Sotre merchant
PImage merchant;
// Bomb Image
PImage bombPic;
//Image of Missile
PImage missilePic;

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
  //value for time it takes for asteroid to spawn
  atime = 0;
  //value for time between ufo spawning
  udelay = 5000000;
  //valye for time it takes for a ufo to spawn
  utime = 0;
  //rocket image
  rocket = loadImage("rocket1.png");
  //image for the asteroid
  astTex = loadImage("asttex.png");
  //image for the ufo
  ufoTex = loadImage("ufotex.png");
  //earth image
  earth = loadImage("Earth1.png");
  //image for the bullet
  bulletTex = loadImage("bullet.png");
  //defining the images for each powerup and lived as well
  powerTex = new PImage[4];
  powerTex[0] = loadImage("heart.png");
  powerTex[1] = loadImage("shield powerup.png");
  powerTex[2] = loadImage("missile powerup.png");
  powerTex[3] = loadImage("bomb powerup.png");
  //speed of rocket
  yspeed = new PVector(0, 0.75);
  //so that the rocket will accelerate 
  yacc = new PVector(0, 0.12);
  BankGothic = loadFont("BankGothicBT-Light-200.vlw");
  OCR = loadFont("OCRAExtended-112.vlw");
  //return icon image
  spaceWindow= loadImage ("spaceWindow.jpg");
  //merchant image
  merchant= loadImage ("ForthDoctorMerchantEdited.png");
  //bomb picture
  bombPic= loadImage ("bomb.png");
  //Missile picture
  missilePic= loadImage ("spaceMissile.png");
  //number of bombs orignally set to zero
  bombs = 0;
  //number of missiles orignally set to zero
  missiles = 0;
}
void draw()
{  
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
  udelay = 5*adelay*int(abs(cos(PI * fnum))+1);
  //increasing the number of frames after launched 
  fnum++;

  background(0);
  //to help the player move
  p.move();
  //so that the player is displayed
  p.display();
  //spawning an asteroid 
  asteroidSpawn();
  //spawning a ufo
  ufoSpawn();
  //if the player shoots and the mouse is pressed
  if (mousePressed&&p.shoot())
  {
    //
    PVector po = new PVector(p.pos.x, p.pos.y);
    boolean m = false;
    //if the right mouse button is pressed and there are more than 0 missiles 
    if (mouseButton==RIGHT && missiles >0)
    {
      //
      m = true;
      //number of missiles decrease
      missiles--;
    }
    //adding new bullets to the game
    bullets.add(new Bullet(po, true, m,bulletTex));
  }
  //
  if (BlackBox.isKeyDown(BlackBox.VK_SPACE) && !spacePressed && bombs>0)
  {
    //clears enemies if the bomb goes off
    enemies.clear();
    //bombs decrease in number
    bombs--;
  }
  for (int i = bullets.size()-1;i>=0;i--)
  {
    Bullet b = bullets.get(i);
    //move and display b
    b.move();
    b.display();
//    check collision of player and bullet
    if (p.bulletCol(b))
    {
      //the bullets are removed
      bullets.remove(i);
    }
    //chck if bullet is onscreen
    if (b.offScreen())
    {
      bullets.remove(i);
    }
  }
  for (int i = powerups.size()-1;i>=0;i--)
  {
    PowerUp pu = powerups.get(i);
//    display pu
    pu.display();
    //check collision of player and powerup
    if (pu.playerCol(p))
    {
      // if pu is a health powerup
      if (pu.type == 0)
      {
//        refill player life
        p.lives = 5;
      }
//      if pu is a shield
      else if (pu.type == 1)
      {
//        give player shield
        p.shield = true;
      }
      //if pu is a missile
      else if (pu.type == 2)
      {//increasing number of missiles
        missiles++;
      }
      else
      {
        //increasing number of bombs
        bombs++;
      }
//      remove pu
      powerups.remove(i);
    }
  }
  for (int i = enemies.size()-1;i>=0;i--)
  {
    //for each enemy
    Enemy e = enemies.get(i);
    //move and display the enemy
    e.move();
    e.display();
    //check if it is shooting
    if (e.shoot())
    {//add new bullet at enemy moving toward player
      PVector pos = new PVector(e.pos.x, e.pos.y);
      PVector v = new PVector(p.pos.x, p.pos.y);
      v.sub(pos);
      bullets.add(new Bullet(pos, false, v,bulletTex));
    }
    for (int j = bullets.size()-1;j>=0;j--)
    {//for each bullet
      Bullet b = bullets.get(j);
      if (e.bulletCol(b))
      {//if it has collided sith an enemy, remove it
        bullets.remove(j);
      }
    }
    if (!e.checkLive())
    {//if enemy has no health
      int rand = int(random(20));
      //ransdom chance of spawning a powerup
      if (rand <4)
      {//if random is less than 4, add new powerup with type random
        powerups.add(new PowerUp(e.pos, rand, powerTex[rand]));
      }
      if (e.u)
      {//if it is a ufo, add 20 to money and score
        score += 20;
        money += 20;
      }
      else
      {//if not, add 10 to money and score
        score += 10;
        money += 10;
      }
      //remove enemy
      enemies.remove(i);
    }
    else if (e.offScreen())
    {
      //if offscreen, remove enemy
      enemies.remove(i);
    }
    else if (p.enemyCol(e))
    {//if enemy collides with player, remove enemy
      enemies.remove(i);
    }
  }
  if (!p.checkLives())
  {
    // if player is out of lives, clear enemies, bulllets, and powerups
    bullets.clear();
    enemies.clear();
    powerups.clear();
    //go to menu
    phase = 1;
  }
  //set spacebar pressed for next frame
  spacePressed = BlackBox.isKeyDown(BlackBox.VK_SPACE);
  //display one socket for each life
  for(int i = 0; i < p.lives;i++)
  {
    image(rocket,42*i+24,height-75/2,42,75);
  }
  //display money, score, missiles,and bombs
  textSize(32);
  fill(255);
  text("Score: "+score,width/2,20);
  text("Money: "+money,width/2,50);
  textSize(16);
  text("Missiles: "+missiles,width - 60,height-30);
  text("Bombs: "+bombs,width - 60,height-10);
}
void store()
{
  textSize (100);
  background (255, 80, 80);
  fill (0, 150, 0);
  text (money, width/2, 200);
  textSize (32);
  rectMode (CORNER); 
  fill (150, 190, 230);
  //Display counter of store
  rect (30, height-400, width-30, 350);
  //Missle purchaser
  image (missilePic, 220, 550, 240, 200);
  fill(0);
  rect (150, 635, 80, 50);
  fill (0, 150, 0);
  text ("$50", 190, 670);
  //Bomb purchaser
  fill(0);
  image (bombPic, 500, 550, 240, 200);
  rect (455, 635, 100, 50);
  fill (0, 150, 0);
  text ("$100", 505, 670);
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
  textAlign (CENTER,CENTER);
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
  //if there are less than maxnum of enemies 
  if (enemies.size() < maxNum)
  {
    if (millis()-atime >= adelay)
    { //if adelay has passed, set asteroid spawn time
      atime = millis();
      PVector astPos;
      astPos = new PVector(0, 0);
      //set random side
      int side = int(random(0, 4));
      if (side==0)
      {//set astpos to random position on the left
        astPos= new PVector(-25, random(-25, height+25));
      }
      else if (side==1)
      {//set astpos to random position on the top
        astPos= new PVector(random(-25, width+25), -25);
      }
      else if (side==2)
      {//set astpos to random position on the right
        astPos= new PVector(width+25, random(-25, height+25));
      }
      else
      {//set astpos to random position on the bottom
        astPos= new PVector(random(-25, width+25), height + 25);
      }
      //add new asteroid at astpos with velocity toward player
      PVector astVel = new PVector(p.pos.x, p.pos.y);
      astVel.sub(astPos);
      enemies.add(new Asteroid(astPos.x, astPos.y, astVel.x, astVel.y, astTex));
    }
  }
}
//in order to spawn the ufos
void ufoSpawn()
{
  //number of enemies doesn't surpass the maximum limit
  if (enemies.size() <maxNum)
  {
    //regulating how long they are in display 
    if (millis()-utime >= udelay)
    {    
      //if udelay has passed, set ufo spawn time
      utime = millis();
      PVector uPos;
      uPos = new PVector(0, 0);
      //set random side
      int side = int(random(0, 4));
      if (side==0)
      {//set upos to random position on the left
        uPos= new PVector(-25, random(-25, height+25));
      }
      else if (side==1)
      {//set upos to random position on the top
        uPos= new PVector(random(-25, width+25), -25);
      }
      else if (side==2)
      {//set upos to random position on the right
        uPos= new PVector(width+25, random(-25, height+25));
      }
      else
      {//set upos to random position on the bottom
        uPos= new PVector(random(-25, width+25), height + 25);
      }
      PVector uVel = new PVector(p.pos.x, p.pos.y);
      uVel.sub(uPos);
      enemies.add(new UFO(uPos.x, uPos.y, uVel.x, uVel.y, ufoTex));
    }
  }
}
//in order to reset the game. All values set to original values
void reset()
{
  //declaring new player once again
  p = new Player(width/2, height/2, rocket);
  //asteroid time in between spawns
  adelay = 1000000;
  //asteroid time to spawn
  atime = millis();
  //ufo time in between spawns
  udelay = 5000000;
  //ufo time to spawn
  utime = millis();
  //score set to zero. (Money is kept however)
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
      //button that if clicked, will change phase to 4, and therefore display the store
    if (mouseX > width/4 && mouseX < 3*width/4 && mouseY > 7*height/12 + 90 && mouseY < 9*height/12 + 90) {
      phase = 4;
    }
  }
    //if not phase 1, 2, or 3, therefore must be phase 4, the store
  else if (phase == 4) {
    // to buy missiles, money decreases because the power up is bought, and missiles increase because that's what was bought
    if (mouseX >= 150 && mouseX <= 230 && mouseY >= 635 && mouseY <= 685 && mousePressed && money >= 50) {
      missiles++;
      money-= 50;
    }
     // to buy bombs, money decreases because the power up is bought and costs that much, and bombs increase because that's what was bought
    if (mouseX >= 455 && mouseX <= 555 && mouseY >= 635 && mouseY <= 685 && mousePressed && money >= 100) {
      bombs++;
      money-= 100;
    }
  }
}

