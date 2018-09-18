class EnemyProjectile {
  PVector location, velocity;
  float size, distance;
  char bogstav;

  EnemyProjectile(float x_, float y_, float shootAngel, char bogstav_) {
      location = new PVector(x_, y_);
      velocity = new PVector(cos(shootAngel), sin(shootAngel));
      size = 6;
      velocity.setMag(size*0.5);
      bogstav = bogstav_;
  }

  void update() {
      location.add(velocity);
      distance = location.dist(new PVector(width/2, height-40));
  }

  Boolean dead() {
      if (location.x < 0 || location.x > width || location.y < 0 || location.y > height || key == bogstav || (ult > 0 && distance < 400 && ((keyPressed == true) && (key == ENTER || key == RETURN))))
          return true;
      else
          return false;
  }


  void display() {
      noStroke();
      fill(255,215,0);
      ellipse(location.x, location.y, size, size);
      fill(255);
      text(bogstav,location.x,location.y);
  }
}

void tegnOndProjektil() {
  for (int i = ondprojectiles.size()-1; i >= 0; i--) {
    EnemyProjectile ondprojectile = (EnemyProjectile) ondprojectiles.get(i);
    ondprojectile.update();
    ondprojectile.display();
    if (ondprojectile.dead())
      ondprojectiles.remove(i);
    if (key == ondprojectile.bogstav)
      continueStreak = true;
    if (ondprojectile.distance < 40) {
      end = true;
      explosionssystem.explosions.add(new Explosion(new PVector(width/2,height-40), 20));
    }
  }
}
