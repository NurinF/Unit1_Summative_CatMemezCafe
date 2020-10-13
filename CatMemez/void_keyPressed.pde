
void keyPressed() {

  if (key =='0') {
    scene = 0;
  }

  if (scene == 0) {
    if (key == '3'){

     scene = 3;
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
      scene = 2;
    }
  }


  if (scene == 2 ) {
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

if (scene ==3){
         startTime = millis();
         
}

  if (scene == 3) {

    gameWon = false;
    if (key == CODED) {
      if (keyCode == UP) {
        nyan.up();
      }
      if (keyCode == DOWN) {
        nyan.down();
      }
    }
  }

  if (key == '4') {
    scene = 4;
  }

  if (key == '5') {
    scene = 5;
  }
} // End of void keyPressed()
