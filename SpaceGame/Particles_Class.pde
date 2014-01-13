class Particle {
  PVector loc, vel, acc, acc2;
  int k;
  int lifetime;


  Particle(float x, float y) {
    //location 
    loc = new PVector(x, y);
    //velocity
    vel = new PVector(0, random(-0.2, 0.2));
    //acceleration to the right
    acc = new PVector(random(0, 0.05), random(0, 0.1));
    //acceleration to the left
    acc2 = new PVector(random(-0.05, 0), random(0, 0.1));
    //diamter of particles
    k = 5;
    //lifetime to remove the particles once the rocket is offscreen
    lifetime = 0;
  }

  void display() {
    //particles displayed
    noStroke();
    fill(255, 0, 0);
    ellipse(loc.x, loc.y, k, k);
  }

  void move() {
    //particles moving and accelerating
    vel.add(acc);
    loc.add(vel);
    vel.add(acc2);
    lifetime++;
  }
  boolean fadeaway() {
    if (lifetime >= 50) {
      return true;
    }
    else {
    return false;
    }
  }
}

