class UltExplosion {
  float radius = 100;
  float lifespan = 255;

  void run() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(explosionImg, width/2, height - 40, radius, radius);
    tint(255,255);
    radius = radius + 20;
    lifespan-=4;
  }
}

class UltExplosions {
  ArrayList<UltExplosion> ultexplosions;

  UltExplosions() {
    ultexplosions = new ArrayList<UltExplosion>();
  }
  void run() {
    for(int i = ultexplosions.size()-1; i>=0 ;i--){
      UltExplosion ue = (UltExplosion) ultexplosions.get(i);
      ue.run();
      if (ue.lifespan<=0)
       ultexplosions.remove(i);
    }
  }
}
