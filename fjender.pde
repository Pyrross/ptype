class Enemy {
  PVector velocity, location, targetLoccen;
  float size, speed, enemyRotat, angle, time;
  PImage imgFjende;
  boolean corresponding;
  String outputString;
  StringBuilder manipulString;
  void initializeFjende() {
      size = outputString.length();
      speed = 10 / size * (lvl / 10); //jo større desto langsommere
      imgFjende = loadImage("fjende.png");

    }

    Enemy (String tempStr) {
        manipulString = new StringBuilder(tempStr);
        outputString = manipulString.toString();
        initializeFjende();
        location = new PVector(random(width),random(-40, -5)); //spawnes mellem 5 og 20 pixels over grænsen
        targetLoccen = new PVector(0, 0);
        navigation();
    }

    void navigation() {
        velocity = new PVector(width / 2 - location.x, height - 40 - location.y); //velocity vektoren er en vektor som går fra enemy.location til ship.location
        velocity.setMag(speed); //den skaleres da den ellers ville nå hen til ship efter et billede. her bevæger den sig kun 10 pixel per frame, men har samme retning/vinkel.
        enemyRotat = velocity.heading() + PI / 2; //så skibet orienteres. tidligere PI/3 - velocity.heading()
    }

    void informationProjektil () {
      if (outputString.length() == 0) {
        for (int i = projectiles.size() - 1; i >= 0; i--) {
            Projectile projectile = (Projectile) projectiles.get(i);
            targetLoccen = projectile.location;
        }
      }
    }

    void update() {
        location.add(velocity);
        if (outputString.length() >= 1 && key == outputString.charAt(0) && spawnCounter <= 60) {
          velocity.setMag(0);
          spawnCounter ++;
        }
        else {
          velocity = new PVector(width / 2 - location.x, height - 40 - location.y); //velocity vektoren er en vektor som går fra enemy.location til ship.location
          velocity.setMag(speed);
          spawnCounter = 0;
        }
        if (outputString.length() >= 1 && key == outputString.charAt(0))
          corresponding = true;
        else
          corresponding = false;
        //println(tan(velocity.y / velocity.x), velocity.heading());
    }

    float distance() {
        return location.dist(new PVector(width/2, height-40));
    }

    void display() {
        imageMode(CENTER);
        pushMatrix();
        translate(location.x,location.y);
        if (size > 4) {
            rotate(enemyRotat);
            image(imgFjende, 0, 0, 27 * size * 0.5, 37 * size * 0.5);
        }
        else {
            fill(0);
            stroke(255,215,0);
            ellipse(0, 0, size * 5, size * 5);
            ellipse(0, 0, size, size);
        }
        popMatrix();
        if (outputString.length() >= 1 && key == outputString.charAt(0) /*&& distance */) {
            manipulString.deleteCharAt(0);
            projectiles.add(new Projectile(location.x, location.y));
            score = score + 1;
        }
        outputString = manipulString.toString();
        textSize(size * 2 + 8);
        textAlign(RIGHT);
        fill(255);
        text(outputString,location.x-size*5,location.y-size*5);

        if (outputString.length() == 0)
          time = time + 1;
    }

    Boolean dead() {
        if (outputString.length() == 0 && (location.dist(targetLoccen) <= 30 || time > 45) || location.y > height)
           return true;
        else
           return false;
    }
}

void tegnFjende () {
  for (int i = enemies.size()-1; i >= 0; i--) {
    Enemy enemy = (Enemy) enemies.get(i);
    enemy.informationProjektil();
    enemy.update();
    enemy.display();
    if (enemy.location.x < width / 2 + 20 && enemy.location.x > width / 2 - 20 && enemy.location.y > height - 60 && enemy.location.y < height - 20)
        end = true;
    println(end);
      if (enemy.dead())
          //rystKamera.draw();
          enemies.remove(i);
    /*if (enemy.corresponding)
        sortering();*/
  }
}
/*void sortering () {
  int indexFlag = 0;
  for (Enemy before : enemies) {
    indexFlag = indexOf(before);
    for (Enemy inProcess : enemies) {
      if (before != inProcess) {
        if (inProcess.distance < before.distance && indexOf(inProcess) > indexFlag && before.corresponding) {
          int indexinProcess = indexOf(inProcess);
          int indexbefore = indexOf(before);
          enemies.set(indexinProcess, before);
          enemies.set(indexbefore, inProcess);
        }
      }
    }
  }
}*/
