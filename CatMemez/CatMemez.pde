//Sounds, libraries, varirables for majority of the scenes:
import processing.sound.*; //library
SoundFile MeowSFX_Score; //made a SoundFile variable like PImage
int scene = 0;

//Scene 0: (Cat Cafe Mini Games Main Menu)
PImage CatCafeBG;
PImage catsBreadMENU;
PImage grumpMENU;
PImage nyanMENU;

//Scene 1: (Rainin' Grumpy Cats - Title Screen)
PImage cat;
PImage room;
float catDown = -300;
float MovingBox_X = -300;

//Scene 2: (Rainin' Grumpy Cats - Main Game)
PImage LoseAgain_Button; 
float LoseAgainButton_X = 270;
float gameoverBG_FilterX = 0;
float GAMEOVER_textX = 200;
PImage room1;
int box_X = 200;
PImage cat1;
int CAT_COUNT = 5;
float[] catX = new float[CAT_COUNT]; //array
float[] catY = new float[CAT_COUNT];
float[] catYspeed = new float[CAT_COUNT];
int CatLives_Score = 0;
int highScore = 0;
boolean gameOver = false;

//Scene 3: (Nyan Cat Meow - Title Screen)
PImage nyanTITLE;

//Scene 4: (Nyan Cat Meow - Main Game)
nyanCat nyan = new nyanCat();
PImage nyanBG;
float bgX = width/2;
asteroid[] asteroids = new asteroid[5];
int startTime = 0;
boolean gameWon = false;
boolean touch = false;

//Scene 5: (Cats are Bread Theory - Main Bonus Scene)
PImage CatINbread;
PImage MrBreadHimself;
PImage HosicoCAT;
float CatIsBreadSize;


void settings()
{
  size(700, 700);


  //Scene 0:
  CatCafeBG = loadImage("CatCafe.gif"); //AREN'T ACTUAL GIFS (Only works in Processing 2)
  CatCafeBG.resize(width, height);
  catsBreadMENU = loadImage("catsBread.gif");
  grumpMENU = loadImage("grumpMENU.gif");
  nyanMENU = loadImage ("nyanMENU.gif");

  //Scene 1:
  cat = loadImage("GrumpKitty.png");
  room = loadImage("room.jpg");
  room.resize(width, height);

  //Scene 2:
  MeowSFX_Score = new SoundFile(this, "Meow_sfx.aiff"); //load sound file basically
  cat1 = loadImage("GrumpKitty.png");
  room1 = loadImage("room1.jpg");
  room1.resize(width, height);
  LoseAgain_Button = loadImage("LoseAgain.png");

  for (int i=0; i<CAT_COUNT; i++) {
    catX[i]= random(width);
    catY[i]= 0;
    catYspeed[i]= random(2, 5);
  }

  //Scene 3: 
  nyanTITLE = loadImage("nyanTITLE.gif");

  //Scene 4:
  for (int i=0; i<asteroids.length; i++) {
    asteroids[i] = new asteroid();
  }
  nyanBG = loadImage ("nyanBG.png");
  nyanBG.resize(width, height);

  //Scene 5:
  CatINbread = loadImage("CatINbread.jpg");
  MrBreadHimself = loadImage ("Mr.BreadHimself.jpg");
  HosicoCAT = loadImage ("HosicoCAT.jpg");
} // End of void settings()


void draw()
{
  if (scene == 0) {
    scene0();
  }
  if (scene == 1) {
    scene1();
  }
  strokeWeight(1);
  if (scene == 2) {
    scene2();
  }
  if (scene == 3) {
    scene3();
  }
} //End of void draw()


//BELOW VOID DRAW. OTHER FUNCTIONS.
//CANT HAVE 2 SAME VOID FUNCTIONS. SO TO USE MORE THAN ONE KEYPRESSED, MUST PUT ALL OF THEM IN THE SAME VOID LOOP.

void scene0() { //CHANGE NUM
  imageMode(CORNER);
  background(CatCafeBG);

  stroke(0);
  strokeWeight(3);
  rect(290, 150, 150, 150);
  image(grumpMENU, 290, 150, 150, 150);
  rect(390, 310, 150, 150);
  image(nyanMENU, 390, 310, 150, 150);
  rect(490, 470, 150, 150);
  image(catsBreadMENU, 490, 470, 150, 150);
}


void scene1() { 

  //IF DON'T WANT SMEARING, ADD BG TO COVER THAT LAYER OF SMEAR
  background(room); 

  image(cat, 450, catDown, 250, 250);
  if (catDown>700) {
    catDown = -300;
  }
  fill(161, 100, 21);
  stroke(20);
  rect(MovingBox_X, 550, 250, 250);
  if (MovingBox_X > 700) {
    MovingBox_X = -300;
  }

  catDown = catDown + 3;
  MovingBox_X = MovingBox_X + 3; // Can also do add assign --> +=

  String spaceBar = "PRESS THE SPACE BAR";
  fill(48, 60, 226);
  textAlign(CENTER);
  textSize(25);// X   Y  
  text(spaceBar, width/2, 200);  

  String StopsMissingLanding = "(SO GRUMPY CAT STOPS MISSING HIS LANDING TO THE BOX!)";
  fill(0);
  textAlign(CENTER);
  textSize(18);             // X     Y   W   H
  text(StopsMissingLanding, 250, 230, 200, 210);  // Text wraps within text box

  String startTitle = "IT'S RAINING TACOS GRUMPY CATS";
  fill(118, 71, 24);
  strokeWeight(3);
  line( 290, 117, 390, 117);
  textAlign(CENTER);
  textSize(30);
  text(startTitle, width/2, 130);
} // End of scene 1
// End of void scene1 ()


void scene2() { //It's Rainin' Grumpy Cats (MAIN GAMEPLAY)

  background(room1);
  imageMode(CENTER);
  for (int i=0; i<CAT_COUNT; i++) {
    image(cat1, catX[i], catY[i], 200, 200);
    catY[i] += catYspeed[i];

    if (catX[i]>box_X) {
      if (catX[i]<box_X+200) {
        if (catY[i]>600) {
          //SCORE PLACE:
          catX[i]= random(width);
          catY[i]= 0;
          catYspeed[i]= random(2, 5);
          MeowSFX_Score.amp(0.1);
          MeowSFX_Score.play();
          CatLives_Score+=1;
          if (CatLives_Score>highScore) {
            highScore += 1;
          }
        }
      }
    }

    stroke(20);
    fill(161, 100, 21);
    rect(box_X, 550, 200, 250);
    //Box loops back to other side like pacman:
    if (box_X < -200) {
      box_X = width;
    }

    if ( box_X > width) {
      box_X = -200;
    }

    // (To see string, must be after bg layer)
    String SCORE = "CAT LIVES: ";
    textAlign(LEFT);
    noStroke(); 
    fill(255, 255, 255);
    rect(15, 20, 220, 40); //White UI box

    fill(0);
    textSize(30);              // X   Y  coordinates
    text(SCORE + CatLives_Score, 20, 50);

    String HIGHSCORE = "HIGHSCORE: ";
    noStroke(); 
    fill(255, 255, 255); // white
    rect(15, 80, 240, 40); // UI box

    fill(0);
    textSize(30);             // X   Y  coordinates
    text(HIGHSCORE + highScore, 20, 110);

    if (catY[i] > 790) {
      gameOver = true;
      fill(0, 0, 0, 150);
      noStroke();
      rect(gameoverBG_FilterX, 0, width, height); // bg kind of fades
      break;
    }
  }
  if (gameOver == true) {
    for (int i=0; i<CAT_COUNT; i++) {
      catX[i]= catX[i];
      catY[i]= catY[i];
      catYspeed[i]= 0;
    }

    LoseAgainButton_X = 270;
    gameoverBG_FilterX = 0;
    GAMEOVER_textX = 200;

    imageMode(CORNER);
    image(LoseAgain_Button, LoseAgainButton_X, 280, 150, 70); //"Lose Again" button.
    fill(225, 0, 0);
    String GAME_OVER = "GAME OVER";
    textSize (50);          
    text(GAME_OVER, GAMEOVER_textX, 200);

    //LoseAgain button function:
    if (mouseX>270 && mouseX<270+150) { 
      if (mouseY>280 && mouseY<280+70) { 
        if (mousePressed == true) { // Add WHILE loop here!
          if (scene == 2) {
            CatLives_Score = 0;
            box_X = 200;
            for (int i=0; i<CAT_COUNT; i++) {
              catX[i]= random(width);
              catY[i]= 0;
              catYspeed[i]= random(2, 5);
            }
            LoseAgainButton_X = 2000;
            gameoverBG_FilterX = 2000;
            GAMEOVER_textX = 2000;
            mousePressed = false;
            gameOver = false;
          }
        }
      }
    }
  }
} // End of Scene 2 aka this grumpy cat scene
// End of void scene2 ()

void scene3() { // Nyan Cat = Rocket (MAIN GAMEPLAY)
  if (scene == 3) {
  } //WHAT DA HELL!
  imageMode(CENTER);
  image(nyanBG, bgX, height/2);
  image(nyanBG, bgX + nyanBG.width, height/2);
  bgX += -2;
  if (bgX < -nyanBG.width) {
    bgX = width/2;
  }

  nyan.Draw();
  nyan.pacman();

  for (int i=0; i<asteroids.length; i++) {
    asteroids[i].Draw();
    asteroids[i].fly();
    float nyanD = dist(nyan.nyanX, nyan.nyanY, asteroids[i].astX, asteroids[i].astY);
    if (nyanD < 80 + asteroids[i].astRadius ) {
      touch = true;
      asteroids[i].astX = asteroids[i].astX;
      asteroids[i].astY = asteroids[i].astY;
      asteroids[i].astSpeed = 0;
      nyan.nyanY = nyan.nyanY;
    }
    if (gameWon == false) {
      if (touch == true) {
        fill(0, 0, 0, 150);
        noStroke();
        rect(gameoverBG_FilterX, 0, width, height); // bg kind of fades
        LoseAgainButton_X = 270;
        gameoverBG_FilterX = 0;
        GAMEOVER_textX = 200;

        imageMode(CORNER);
        // image(LoseAgain_Button, LoseAgainButton_X, 280, 150, 70); //"Lose Again" button.
        fill(225, 0, 0);
        String GAME_OVER = "GAME OVER";
        textSize (50);          
        text(GAME_OVER, GAMEOVER_textX, 200);
      }
    }
  }



  textSize(40);
  int currentTime = millis() - startTime;
  int countDown = 4 - currentTime/1000;
  text(countDown, 100, 100);

  if (countDown < 0)
  {
    gameWon = true;
    fill(0, 0, 0, 150);
    noStroke();
    rect(gameoverBG_FilterX, 0, width, height); // bg kind of fades
  }
  if (touch == false) {
    if (gameWon == true) {
      imageMode(CORNER);

      fill(#36EA43);
      String YOU_WON = "YOU WON!";
      textSize (50);          
      text(YOU_WON, GAMEOVER_textX, 200);
      countDown = 0;
      nyan.nyanY = nyan.nyanY;
    }
  } // End of if(scene3)
  // End of void scene3()
}
