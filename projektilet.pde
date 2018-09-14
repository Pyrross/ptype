class Projectile {
    PVector location, velocity, targetLoc;
    float size = 5;

    Projectile(float x_, float y_) {
        targetLoc = new PVector(x_, y_);
        location = new PVector(width/2, height - 40);
        velocity = new PVector(targetLoc.x - width / 2, targetLoc.y - (height - 40)); //velocity vektoren er en vektor som går fra enemy.location til ship.location
        velocity.setMag(20);
    }

    void update() {
        location.add(velocity);
    }

    Boolean dead() {
        if (location.x < 0 || location.x > width || location.y < 0 || location.y > height || location.dist(targetLoc) <= 30)
            return true;
        else
            return false;
    }

    void display() {
        noStroke();
        pushMatrix();
        translate(location.x, location.y);
        rotate(velocity.heading() + PI / 2);
        fill(125, 249, 255);
        ellipse(0, 0, size, size*3);
        popMatrix();
        shipRotat = velocity.heading() + PI / 2;
    }
}

void tegnProjektil() {
  for (int i = projectiles.size()-1; i >= 0; i--) {
    Projectile projectile = (Projectile) projectiles.get(i);
    projectile.update();
    projectile.display();
    if (projectile.dead())
        projectiles.remove(i);
  }
  //println(projectiles.size());
}
