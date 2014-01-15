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
  //changing both alignment for text and rectangle
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
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
  //fill white
  fill(255);
  background(0);
  //text font for main screen (start screen)
  textFont(OCR);
  //text size
  textSize(112);
  //text for the start screen
  text("SPACE GAME", width/2, height/3);
  //green fill for button
  fill(0, 255, 0);
  //buttton fot play option
  rect(width/2, 2*height/3+15, width/2, height/4);
  //fill whtie
  fill(255);
  //text size
  textSize(100);
  //text displayed for play! option
  text("Play!", width/2, 2*height/3);
  //once the mouse is clicked, the phase changes
  if (mousePressed) {
    phase = 1;
  }
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
  }
}
