class nyanCat
{
  PImage nyanCat;
  float nyanY;
  float nyanX;
  float nyanRadius;

  nyanCat()
  {
    nyanY = 400;
    nyanX = 100;
    nyanRadius = 100;
  }

  void Draw()
  {
    nyanCat = loadImage("THE_nyanCat.png");
    image(nyanCat, nyanX, nyanY, nyanRadius*2, nyanRadius*2);
  }

  void up() {
    nyanY += -20;
  }

  void down() {
    nyanY += 20;
  }

  void pacman()
  {
    if (nyanY < -100) {
      nyanY = height;
    }

    if (nyanY > height) {
      nyanY= -100;
    }
  }


}
