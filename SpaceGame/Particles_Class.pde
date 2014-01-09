class Particle {
  PVector loc, vel, acc;
  int k;


  Particle(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(random(-0.2, 0.2),0);
    acc = new PVector(random(-0.2, -0.1), random(0, 0.1));
    k = 5;
  }

  void display() {
    noStroke();
    fill(255, 0, 0);
    ellipse(loc.x, loc.y, k, k);
  }

  void move() {
    vel.add(acc);
    loc.add(vel);
  }
}

