class Star{
  PVector location;
  float speed;

  Star(float maxY){
   location= new PVector(random(width),random(-10, maxY));
   speed = 1;

  }

  void run(){
    location.y+=speed;
    imageMode(CENTER);
    image(starImg,location.x,location.y,5,10);
  }

}


class Stars{
  ArrayList<Star> stars;

  Stars(){
    stars= new ArrayList<Star>();
  }

  void run(){
   if (stars.size() == 0) {
     for (int i = 0; i <= 50; i++) {
       stars.add(new Star(height));
     }
   }
   float r=random(5);
   if(r<0.3){
    stars.add(new Star(-10));
   }
   for(int i=stars.size()-1;i>=0;i--){
    Star s = (Star) stars.get(i);
    s.run();
    if(s.location.y>height+10){
      stars.remove(i);
    }
   }
  }
}
