class CatClicks {
  //Member Data:
  float x;
  float y;
  int catClicksScore;

  //Default Constructor:
  CatClicks() {
    x = 100;
    y = 250;
    catClicksScore = 0;
  }

  //Functions:
  void show() {
    textSize(25);
    fill(0);
    rectMode(CENTER);
    rect(170, 150, 310, 60);
    fill(255);
    text("CAT CLICKER SCORE: " + catClicksScore, 20, 160);
  }

  void count() {
    catClicksScore += 1;
  }
}
