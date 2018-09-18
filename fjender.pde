class Enemy {
  PVector velocity, location, targetLoccen;
  float size, speed, enemyRotat, angle, time, shootCooldown;
  PImage imgFjende;
  boolean corresponding;
  String outputString;
  StringBuilder manipulString;
  void initializeFjende() {
      size = outputString.length();
      speed = 1 / size + (lvl / 50); //jo større desto langsommere
      imgFjende = loadImage("fjende.png");
      shootCooldown = 0;
    }

    Enemy (String tempStr) {
        manipulString = new StringBuilder(tempStr);
        outputString = manipulString.toString();
        initializeFjende();
        location = new PVector(random(width),random(-10*lvl*size, -5)); //spawnes mellem 5 og 20 pixels over grænsen
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
        if (outputString.length() >= 1 && key == outputString.charAt(0) && keyPressed)
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
        if (size > 5) {
            rotate(enemyRotat);
            image(imgFjende, 0, 0, 27 * size * 0.25, 37 * size * 0.25);
            if (shootCooldown > 480) {
              for (int i = 0; i <= size; i++) {
                ondprojectiles.add(new EnemyProjectile(location.x, location.y, (velocity.heading() - (PI / 4 + (i - size / 2))), bogstaver[int(random(bogstaver.length))]));
              }
            shootCooldown = 0;
            }
            else
              shootCooldown ++;
        }
        else {
            fill(0);
            strokeWeight(1);
            stroke(255,215,0);
            ellipse(0, 0, size * 4, size * 4);
            noStroke();
            fill(255,215,0);
            ellipse(0, 0, size*1.5, size*1.5);
        }
        popMatrix();
        outputString = manipulString.toString();
        textSize(size * 2 + 8);
        textAlign(RIGHT);
        fill(255);
        text(outputString,location.x-size*3,location.y-size*3);

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
  if (keyPressed)
    continueStreak = false;
  for (int i = enemies.size()-1; i >= 0; i--) {
    Enemy enemy = (Enemy) enemies.get(i);
    enemy.informationProjektil();
    if (keyPressed && enemy.manipulString.length() < 0 && key == enemy.manipulString.charAt(0))
      continueStreak = true;
    if (enemy.manipulString.length() > 0) {
      if (i == mindex && keyPressed && key == enemy.manipulString.charAt(0)) {
        enemy.manipulString.deleteCharAt(0);
        projectiles.add(new Projectile(enemy.location.x, enemy.location.y));
        streak ++;
        score = score + 1 * streakMult;
        skudLyd.play();
        skudLyd.rewind();
      }
    }
    if (enemy.dead()) {
        explosionssystem.explosions.add(new Explosion(enemy.location, enemy.size));
        eksplosionsLyd.setGain(89 / (0.1 * enemy.size));
        eksplosionsLyd.play();
        eksplosionsLyd.rewind();
        enemies.remove(i);
    }
    if (ult > 0 && enemy.distance() < 400 && ((keyPressed == true) && (key == ENTER || key == RETURN)))
      enemies.remove(i);
    enemy.update();
    enemy.display();
    if (enemy.distance() < 20) {
        end = true;
        explosionssystem.explosions.add(new Explosion(new PVector(width/2,height-40), 20));
        eksplosionsLyd.play();
        eksplosionsLyd.rewind();
    }
  }
  if (ult > 0 && ((keyPressed == true) && (key == ENTER || key == RETURN))) {
    ult --;
    keyPressed = false;
  }
  tegnOndProjektil();
  sortering();
  getIndexOfClosestEnemy();
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


void streaking () {
  if (streak >= 20 && streak < 100) {
    streakMult = 2;
    streakProgress = streak / 99;
  }
  else if (streak >= 100 && streak < 250) {
    streakMult = 3;
    streakProgress = streak / 249;
  }
  else if (streak >= 250 && streak < 500) {
    streakMult = 4;
    streakProgress = streak / 499;
  }
  else if (streak >= 500 && streak < 1000) {
    streakMult = 5;
    streakProgress = streak / 999;
  }
  else if (streak >= 1000 && streak < 2000) {
    streakMult = 6;
    streakProgress = streak / 1999;
  }
  else {
    streakMult = 1;
    streakProgress = streak / 19;
  }
  fill(125, 249, 255);
  stroke(125, 249, 255);
  strokeWeight(10+streakMult*2);
  line(0-10-streakMult*2, height, width * streakProgress-10-streakMult*2, height);
  if (streakMult > 1)
    text("x "+streakMult,20,height - 20);
  pushMatrix();
  translate(width-30,height-30);
  rotate(PI / 8);
  noStroke();
  fill(100,200,255);
  polygon(0, 0, 20, 8);
  popMatrix();
  fill(255);
  textAlign(CENTER);
  textFont(fontA,25);
  text(int(ult),width-28,height-22.5);
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
