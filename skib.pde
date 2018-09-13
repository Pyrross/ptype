class OwnShip {
    int lifeCount, streak;
    color shipColor;
    PVector location;
    void setup() {
        location = new PVector(width/2, height - 40);
        lifeCount = 3;
    }

    OwnShip () {
    }

}

void tegnSkib () {
    imageMode(CENTER);
    pushMatrix();
    translate(width/2, height - 40);
    rotate(shipRotat);
    image(imgSkib, 0, 0, 30, 30);
    popMatrix();
}
