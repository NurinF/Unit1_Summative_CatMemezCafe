
void keyPressed() {

  if (key =='0') {
    scene = 0;
  }

  if (key == ' ') {//Apparently the 2nd only way I found to press space bar after '32'
    if (gameOver == false) {
      CatLives_Score = 0;
      box_X = 200;
      for (int i=0; i<CAT_COUNT; i++) {
        catX[i]= random(width);
        catY[i]= 0;
        catYspeed[i]= random(2, 5);
      }
    }
    scene = 1;
  }

  if (scene == 1 ) {
    if (gameOver == false) {
      if (key == 'd') {
        box_X += 20;
      } else if (key == 'a') {
        box_X += -20;
      }
    }

    if (gameOver == false) {
      if (key == CODED) {
        if (keyCode == RIGHT) {
          box_X +=20;
        } else if (keyCode == LEFT) {
          box_X += -20;
        }
      }
    }
  }
  
  if (scene == 2) {
    touch = false;
    if (touch == false) {
      currentTime = millis();
      countDown = currentTime/1000;
    }
    if (key == CODED) {
      if (keyCode == UP) {
        nyan.up();
      }
      if (keyCode == DOWN) {
        nyan.down();
      }
    }
  }
} // End of void keyPressed()
