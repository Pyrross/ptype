PFont fontA;
PImage imgSkib;
boolean dead, end, next;
ArrayList<Projectile> projectiles;
ArrayList<Enemy> enemies;
int score;
Camera rystKamera;
float shipRotat, lvl, spawnCounter, spawnMax;
void setup() {
    size (480,720);
    frameRate(50);
    projectiles = new ArrayList<Projectile>();
    enemies = new ArrayList<Enemy>();
    ArrayList<Enemy> sortedEnemies = new ArrayList<Enemy>();
    initGame();
    imgSkib = loadImage("Ownship.png");
    fontA = loadFont("ArialNarrow-48.vlw");
}

void draw() {
  background(0);
  tegnProjektil();
  tegnSkib();
  tegnFjende();
  nextLvl();
  gameOver();
  displayScore();
}

void lvlUp() {
    if (enemies.size() == 0 && end == false) {
        textFont(fontA, 35);
        textAlign(CENTER);
        fill(125, 249, 255);
        text("LEVEL " + int(lvl), width / 2, height / 2);
        if (spawnCounter >= 100) {
          next = true;
          spawnCounter = 0;
        }
        else
          spawnCounter ++;
    }
}

void nextLvl() {
    shipRotat = 0;
    lvlUp();
    if (next && lvl < 7) {
      for (int i = 0; i <= 8 * lvl; i++) {
        int ordL = int(random(3+lvl));
        String ordet = ord[ordL][int(random(ord[ordL].length-1))];
        if (spawnCounter >= 10) {
          enemies.add(new Enemy(ordet));
          spawnCounter = 0;
        }
        else
         spawnCounter ++;
         next = false;
      }
      lvl = lvl + 1;
    }
    if (next && lvl >= 7) {
      for (int i = 0; i <= 8 * lvl; i++) {
        int ordL = int(random(9));
        String ordet = ord[ordL][int(random(ord[ordL].length-1))];
        if (spawnCounter >= 10) {
          enemies.add(new Enemy(ordet));
          spawnCounter = 0;
        }
        else
         spawnCounter ++;
      }
      lvl = lvl + 1;
      next = false;
    }
}

void initGame() {
  score = 0;
  lvl = 1;
    for (int i = 0; i <=4; i++) {
      int ordL = int(random(3));
      String ordet = ord[ordL][int(random(ord[ordL].length-1))];
      enemies.add(new Enemy(ordet));
    }
  end = false;
  shipRotat = 0;
}

void displayScore() {
  fill(255);
  textFont(fontA, 15);
  textAlign(LEFT);
  text("Score: ", width / 20, height / 15);
  text(score, width / 20 + 60, height / 15);
}

void gameOver() {
  if (end) {
    enemies.clear();
    textFont(fontA, 35);
    textAlign(CENTER);
    fill(255, 128, 0);
    text("GAME OVER", width / 2, height / 2);
    if (keyPressed)
      initGame();
  }
}
