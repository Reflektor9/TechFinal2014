int phase = 0;

void setup()
{
  size(800, 800);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
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
  background(0);
  textSize(200);
  text("MENU", width/2, height/4);
  fill(255, 0, 0);
  rect(width/2, 2*height/3-60, width/2, height/6);
  fill(0, 0, 255);
  rect(width/2, 2*height/3+90, width/2, height/6);
  fill(255);
  textSize(100);
  text("Launch\nStore", width/2, 2*height/3);
}

void title()
{
  fill(255);
  background(0);
  textSize(112);
  text("SPACE GAME", width/2, height/3);
  fill(0, 255, 0);
  rect(width/2, 2*height/3+15, width/2, height/4);
  fill(255);
  textSize(100);
  text("Play!", width/2, 2*height/3);
  if (mousePressed) {
    phase = 1;
  }
}

void launch()
{

}

