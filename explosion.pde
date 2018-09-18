class Explosion {
  PVector location;
  float radius;
  float lifespan;

  Explosion(PVector location_, float radius_) {
    location=location_;
    radius=radius_;
    lifespan=255;
  }

  void run() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(explosionImg, location.x, location.y, 2*radius, 2*radius);
    tint(255,255);
    radius = radius * 1.04;
    lifespan-=4;
  }
}

class Explosions {
  ArrayList<Explosion> explosions;

  Explosions() {
    explosions = new ArrayList<Explosion>();
  }
  void run() {
    for(int i = explosions.size()-1; i>=0 ;i--){
      Explosion e = (Explosion) explosions.get(i);
      e.run();
      if (e.lifespan<=0)
       explosions.remove(i);
    }
  }
}
