PFont fontA;
PImage imgSkib;
boolean dead, deads, next;
ArrayList<Projectile> projectiles;
ArrayList<Enemy> enemies;
int score;
float shipRotat, lvl;
void setup() {
    size (480,720);
    frameRate(50);
    projectiles = new ArrayList<Projectile>();
    enemies = new ArrayList<Enemy>();
    ArrayList<Enemy> sortedEnemies = new ArrayList<Enemy>();
    initGame();
    imgSkib = loadImage("Ownship.png");
    enemies.add(new Enemy("adds"));
}

void draw() {
  background(0);
  tegnProjektil();
  tegnSkib();
  tegnFjende();
  //println(str.substring(0,1),str.length());
  println(deads);
  nextLvl();
}

void lvlUp() {
    if (enemies.size() == 0)
        next = true;
}

void nextLvl() {
    lvlUp();
    if (next && lvl < 7) {
      for (int i = 0; i <=8 * lvl; i++) {
        int ordL = int(random(3+lvl));
        String ordet = ord[ordL][int(random(ord[ordL].length-1))];
        enemies.add(new Enemy(ordet));
      }
    }
    if (next && lvl < 7) {
      for (int i = 0; i <=8 * lvl; i++) {
        int ordL = int(random(9));
        String ordet = ord[ordL][int(random(ord[ordL].length-1))];
        enemies.add(new Enemy(ordet));
      }
    }
    lvl = lvl + 1;
}

void initGame() {
  score = 0;
  lvl = 1;
    for (int i = 0; i <=8; i++) {
      int ordL = int(random(3));
      String ordet = ord[ordL][int(random(ord[ordL].length-1))];
      enemies.add(new Enemy(ordet));
    }
  deads = false;
}

/*void displayScore() {
  background(0);
  fill(255);
  textFont(fontA, 15);
  textAlign(LEFT);
  text("Score: ", width / 20, height / 15);
  text(score, width / 20 + 60, height / 15);
  strokeWeight(2);
  stroke(0, 255, 0);
  line(0, 9 * height / 10 + 20, width, 9 * height / 10 + 20);
  for (int i = 0; i < conf.lives; i++) {
    Ship ship = livesFeedBck.get(i);
    ship.display();
  }
}

void gameOver() {
  textFont(fontA, 35);
  textAlign(CENTER);
  fill(255, 128, 0);
  text("GAME OVER", width / 2, height / 2);
  if (keyPressed) {
    initGame();
  }
}*/
