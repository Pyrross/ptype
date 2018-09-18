PFont fontA;
PImage imgSkib, explosionImg, starImg;
import ddf.minim.*;
Minim minim;
AudioPlayer eksplosionsLyd, klikLyd, ramLyd, skudLyd;
boolean dead, end, next;
ArrayList<Projectile> projectiles;
ArrayList<Enemy> enemies;
Explosions explosionssystem;
UltExplosions ultexplosionssystem;
Stars starsystem;
boolean continueStreak = false;
ArrayList<EnemyProjectile> ondprojectiles;
int score, streakMult;
float shipRotat, lvl, spawnCounter, spawnMax, ult, highScore, streakProgress, streak;
int mindex = 0;
void setup() {
    size (480,720);
    frameRate(60);
    explosionImg = loadImage("explosionImg.png");
    starImg = loadImage("starimg.png");
    minim = new Minim(this);
    projectiles = new ArrayList<Projectile>();
    enemies = new ArrayList<Enemy>();
    ondprojectiles = new ArrayList<EnemyProjectile>();
    initGame();
    imgSkib = loadImage("Ownship.png");
    fontA = loadFont("ArialNarrow-48.vlw");
    explosionssystem = new Explosions();
    ultexplosionssystem = new UltExplosions();
    starsystem = new Stars();
    ramLyd = minim.loadFile("hit.mp3");
    skudLyd = minim.loadFile("plasma.mp3");
    eksplosionsLyd = minim.loadFile("eksplosion.mp3");
    klikLyd = minim.loadFile("click.mp3");
}

void draw() {
  background(0);
  if (ult > 0 && ((keyPressed == true) && (key == ENTER || key == RETURN))) {
    eksplosionsLyd = minim.loadFile("eksplosion.mp3");
    ultexplosionssystem.ultexplosions.add(new UltExplosion());
    eksplosionsLyd.play();
    eksplosionsLyd.rewind();
  }
  tegnProjektil();
  tegnSkib();
  tegnFjende();
  nextLvl();
  gameOver();
  displayScore();
  streaking();
  keyPressed = false;
  explosionssystem.run();
  ultexplosionssystem.run();
  if (continueStreak == false) {
    klikLyd.play();
    klikLyd.rewind();
  }
  starsystem.run();
}

void lvlUp() {
    if (enemies.size() == 0 && end == false) {
        textFont(fontA, 35);
        textAlign(CENTER);
        fill(125, 249, 255);
        text("LEVEL " + int(lvl + 1), width / 2, height / 2);
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
      for (int i = 0; i <= 3 * lvl; i++) {
        int ordL = int(random(3+lvl));
        String ordet = ord[ordL][int(random(ord[ordL].length-1))];
        enemies.add(new Enemy(ordet));
      }
      lvl = lvl + 1;
      next = false;
    }
    if (next && lvl >= 7) {
      for (int i = 0; i <= 3 * lvl; i++) {
        int ordL = int(random(9));
        String ordet = ord[ordL][int(random(ord[ordL].length-1))];
        enemies.add(new Enemy(ordet));
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
  ult = 3;
  streak = 0;
  streakMult = 1;
}

void displayScore() {
  fill(255);
  textFont(fontA, 15);
  textAlign(LEFT);
  text("Score: ", width / 20, height / 15);
  text(score, width / 20 + 60, height / 15);
}

void gameOver() {
  if (end == true) {
    if (highScore < score)
      highScore = score;
    enemies.clear();
    textFont(fontA, 35);
    textAlign(CENTER);
    fill(255, 128, 0);
    text("GAME OVER", width / 2, height / 2);
    textFont(fontA, 15);
    textAlign(CENTER);
    fill(125, 249, 255);
    text("HIGHSCORE:", width / 2, height / 2+50);
    textFont(fontA, 20);
    text(int(highScore), width / 2, height / 2+75);
    if (keyPressed && key == ' ') {
      initGame();
  }
}
}
