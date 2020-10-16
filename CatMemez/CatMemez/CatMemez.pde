//IMPORTANT: PRESS '0' WHENEVER YOU WANT TO GO BACK TO MAIN MENU!
//P.S BONUS CAT CLICKER GAME DOESN'T RESTART SCENE BECAUSE IT'S A CONTINUOS GAME...
//TILL YOU BEAT IT!

//Sounds, libraries, varirables for majority of the scenes:
import processing.sound.*; //library
SoundFile MeowSFX_Score; //made a SoundFile variable like PImage
int scene = 0;

//Scene 0: (Cat Cafe Mini Games Main Menu)
PImage CatCafeBG;
PImage catsBreadMENU;
PImage grumpMENU;
PImage nyanMENU;

//Scene 1: (Rainin' Grumpy Cats - Main Game)
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

//Scene 2: (Nyan Cat = Rocket - Main Game)
nyanCat nyan = new nyanCat();
PImage nyanBG;
float bgX = width/2;
asteroid[] asteroids = new asteroid[5];
int startTime = 0;
boolean gameWon = false;
boolean touch = false;
int currentTime = millis();
int countDown = currentTime/1000;
float touchedBG = 2000;

//Scene 3: (Cat Meme Evolution Clicker - Main Bonus Scene)
CatClicks score = new CatClicks();
breadText breadText = new breadText();
bagelText bagelText = new bagelText();
liquidText liquidText = new liquidText();
PImage CatINbread;
PImage MrBreadHimself;
PImage HosicoCAT;
PImage catBagel;
PImage catLiquid;
float CatIsBreadSize;
float size = 300;
boolean bread = true;
boolean bagel = false; 
boolean liquid = false;
boolean unlocked = false;


void settings()
{
  size(700, 700);

  //Scene 0: (Cat Cafe Mini Games Main Menu)
  CatCafeBG = loadImage("CatCafe.gif"); //AREN'T ACTUAL GIFS (Only works in Processing 2)
  CatCafeBG.resize(width, height);
  catsBreadMENU = loadImage("catsBread.gif");
  grumpMENU = loadImage("grumpMENU.gif");
  nyanMENU = loadImage ("nyanMENU.gif");

  //Scene 1: (Rainin' Grumpy Cats - Main Game)
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

  //Scene 2: (Nyan Cat = Rocket - Main Game)
  for (int i=0; i<asteroids.length; i++) {
    asteroids[i] = new asteroid();
  }
  nyanBG = loadImage ("nyanBG.png");
  nyanBG.resize(width, height);

  //Scene 3: (Cat Meme Evolution Clicker - Main Bonus Scene)
  CatINbread = loadImage("CatINbread.jpg");
  MrBreadHimself = loadImage ("Mr.BreadHimself.jpg");
  HosicoCAT = loadImage ("HosicoCAT.jpg");
  catBagel = loadImage("catBagel.jpg");
  catLiquid = loadImage("catLiquid.png");
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
  imageMode(CENTER);
  rectMode(CENTER);
  background(CatCafeBG);
  textSize(50);
  textAlign(CENTER);
  fill(#B27924);
  rect(width/2, 80, width, 170);
  fill(#2BD3B3);
  text("CAT MEME CAFE", width/2, 100);

  stroke(0);
  strokeWeight(3);
  rect(380, 250, 150, 150);
  image(grumpMENU, 380, 250, 150, 150);
  float d1 = dist(380, 250, mouseX, mouseY);
  if (d1 < 150/2 && mousePressed == true) {
    scene = 1;
  }

  rect(450, 410, 150, 150);
  image(nyanMENU, 450, 410, 150, 150);
  float d2 = dist(450, 410, mouseX, mouseY);
  if (d2 < 150/2 && mousePressed == true) {
    touchedBG = 2000;
    scene = 2;
  }

  rect(520, 570, 150, 150);
  image(catsBreadMENU, 520, 570, 150, 150);
  float d3 = dist( 520, 570, mouseX, mouseY);

  if (unlocked == false) {
    if (d3 < 150/2) {
      fill(0, 0, 0, 150);
      rect(380, 570, 620, 80);
      fill(225, 0, 0);
      textSize(23);
      text("LOCKED: SCORE 5 IN GRUMPY CAT GAME TO UNLOCK!", 380, 570);
    }
  }

  if (unlocked == true) {
    if (d3 < 150/2) {
      fill(0, 0, 0, 150);
      rect(380, 570, 620, 80);
      fill(#15E30B);
      textSize(23);
      text("UNLOCKED: YAY! YOU MAY PLAY NOW!", 380, 570);
      if (mousePressed == true) {
        score.catClicksScore = 0;
        // liquid = false;
        // bagel = false;
        breadText.show();
        size = 300;
        scene = 3;
      }
    }
  }
} // End of scene0()

void scene1() { //It's Rainin' Grumpy Cats (MAIN GAMEPLAY)

  background(room1);
  imageMode(CENTER);
  rectMode(CORNER);
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

  if (CatLives_Score == 5 || CatLives_Score > 5) {
    fill(#E3B50B);
    text("(BONUS GAME UNLOCKED!)", 200, 300);
    unlocked = true;
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
        if (mousePressed == true) { 
          if (scene == 1) {
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
} // End of void scene1()

void scene2() { // CASUAL NEVER ENDING GAME. NO SUCH THING AS BEATING THE GAME.
  gameWon = false;
  imageMode(CENTER);
  rectMode(CORNER);
  image(nyanBG, bgX, height/2);
  image(nyanBG, bgX + nyanBG.width, height/2);
  bgX += -2;
  if (bgX < -nyanBG.width) {
    bgX = width/2;
  }

  nyan.Draw();
  nyan.pacman();

  for (int i=0; i< asteroids.length; i++) {
    asteroids[i].Draw();
    asteroids[i].fly();
    float nyanD = dist(nyan.nyanX, nyan.nyanY, asteroids[i].astX, asteroids[i].astY);
    if (nyanD < 80 + asteroids[i].astRadius ) {
      touch = true;
    }
  }

  if (touch == false) {
    currentTime = millis();
    countDown = currentTime/1000;
  }

  textSize(40);
  text(countDown, 100, 100);
  if (touch == true) {
    touchedBG = 350;
    fill(0, 0, 0, 150); // bg kind of fades
    noStroke();
    rectMode(CENTER);
    rect(touchedBG, 350, width, height); 
    fill(#22E320);
    textSize(30);
    textAlign(CENTER);
    text("AN ASTEROID HIT YOU!", touchedBG, 230);
    textSize(20);
    text(countDown + " SECONDS IS HOW LONG YOU MANAGED TO SURVIVE FOR!", touchedBG, 270);
    fill(#207FE3);
    text("Press '0' to go back to Main Menu", touchedBG, 310);
  }
} // End of void scene2()


void scene3() {
  // bread = true;
  background(#1CEAD1);
  imageMode(CENTER);
  image(CatINbread, width/2, 400, size, size);
  textAlign(LEFT);
  textSize(50);
  fill(255);
  text("CATS ARE ", 110, 70);
  breadText.show();
  score.show();
  textSize(20);
  fill(#299BF0);
  String instructs1 = "(Just keep clicking till you ";
  String instructs2 = "reach the ultimate cat evolution!)";
  text(instructs1, 350, 105);
  text(instructs2, 350, 130);


  if (score.catClicksScore == 10) {
    liquid = false;
    bread = false;
    bagel = true;
  }

  if (score.catClicksScore == 20) {
    bread = false;
    bagel = false; 
    liquid = true;
  }

  if (bread == true) {
    fill(255);
    textSize(50);
    //bagelText.hide();
    breadText.show();
    image(CatINbread, width/2, 400, size, size);
  } 

  if (bagel == true) {
    fill(255);
    textSize(50);
    breadText.hide();
    // liquidText.hide(); 
    bagelText.show();
    image(catBagel, width/2, 400, size, size);
  } 


  if (liquid == true) {
    fill(#E3CF1B);
    textSize(50);
    bagelText.hide();
    breadText.hide();
    liquidText.show();
    image(catLiquid, width/2, 400, size, size);

    fill(0, 0, 0, 150); // bg kind of fades
    noStroke();
    rect(width/2, 430, width, height); 
    fill(#22E320);
    textSize(35);
    textAlign(CENTER);
    text("YOU BEAT THE GAME!", width/2, 230);
    text("YOU ACHIEVED THE LIQUID CAT FORM!", width/2, 270);
    fill(#207FE3);
    text("Press '0' to go back to Main Menu", width/2, 310);
  }
} // End of void scene4()


void mousePressed() {
  float breadD = dist(width/2, height/2, mouseX, mouseY);
  if (breadD < 150) {
    size += -50;
  }
}

void mouseClicked() {
  float breadD = dist(width/2, height/2, mouseX, mouseY);
  if (breadD < 150) {
    score.count();

    size += 50;
  }
}
