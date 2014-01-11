abstract class Enemy
{
  PVector pos;
  PVector vel;
  PVector size;
  int health;
  float speed;

  abstract void display();

  abstract void move();
}
