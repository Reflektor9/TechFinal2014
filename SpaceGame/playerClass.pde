class Player
{
  PVector pos;
  PVector size;
  float speed;
  int shottime;
  int shotwait;
  int score;
  int lives;
  Player(float x, float y)
  {
    pos = new PVector(x,y);
    size = new PVector(50,50);
    speed = 4;
    shotwait = 250;
    shottime = -shotwait;
    score = 0;
    lives = 3;
  }
  void display()
  {
    stroke(255,0,0);
    fill(0,255,0);
    rect(pos.x,pos.y,size.x,size.y);
  }
  void move()
  {
    boolean pressed = false;
    PVector amt = new PVector (0,0);
    if(BlackBox.isKeyDown(BlackBox.VK_A))
    {
      amt.x -= 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_D))
    {
      amt.x += 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_W))
    {
      amt.y -= 1;
      pressed = true;
    }
    if(BlackBox.isKeyDown(BlackBox.VK_S))
    {
      amt.y += 1;
      pressed = true;
    }
    if(pressed)
    {
      amt.normalize();
      amt.mult(speed);
    }
    pos.add(amt);
  }
  boolean shoot()
  {
    boolean t = millis()-shotwait>=shottime;
    if(t)
    {
      shottime = millis();
    }
    return t;
  }
}
