class asteroid
{
  PImage asteroid;
  float astX = random(700, 1000);
  float astY = random(height);
  float astSpeed = random (-10, -20);
  float astRadius = random(20, 70);


  void Draw() {
    asteroid = loadImage("asteroid.png");
    image(asteroid, astX, astY, astRadius*2, astRadius*2);
  }

  void fly() {
    astX += astSpeed;
    if (astX < 0 - astRadius) {
      astX = random(700, 1000);
      astY = random(height);
      astSpeed = random (-5, -20);
      astRadius = random(20, 70);
    }
  }
}
