//all the different images for the displays
//background for the first level
//check the manual scores match the actual scores 
PImage gamePage;
//manual page background
PImage manualPage;
//second level
PImage gamePage2;
//third level
PImage gamePage3;
PImage gamePage32;
//image for the person array 
PImage personHead;
//the different zombie character heads
PImage zombieHead;
PImage zombieHead2;
PImage zombieHead3;
//bonus target image
PImage bonus;
//scoring page display
PImage scoringPage;
PImage levelScreen;
PImage gunImage;
//int plays a role in the eye opening effect for level one once it hits 255 then the game begins 
int i=0;
//loading all the different images 
public class gameImage {
  void setup() {
    gunImage = loadImage("gunI.png");
     personHead = loadImage("personHead.png");
    levelScreen = loadImage("background.jpg");
    bonus=loadImage("bonus.png");
    gamePage = loadImage("forest.jpg");
    manualPage = loadImage("cem.jpg");
    gamePage2=loadImage("cme2.jpg");
    gamePage3 = loadImage("graveyardB.jpg");
    scoringPage = loadImage("cem3.jpg");
    zombieHead=loadImage("zombiehead.png");
    zombieHead2=loadImage("zombie2.png");
    zombieHead3 = loadImage("zombiehead3.png");
    gamePage32 = loadImage("graveyard2.jpg");
  }
  //eye opening effect
  void draw() {
    frameRate(1);
    if (i<=255) {
      background(0); 
      tint(i, 200);
      image(gamePage, 0, 0);
      i+=25;
    }
    //effect becomes false after the image is completely visable no more tint 
    //then the gameStart becomes true 
    else {
      effect = false;
    }
  }
  //background for the first level
  void backdropS1() {
    background(gamePage);
  }
  //manual background and instructions 
  void backdropM() {
    image(manualPage,0,0,1000,800); 
   fill(0);
   rect(750,730,230,50);
   fill(255,0,0);
   textSize(30);
   text("Dare to Enter??",760,765);
   //instructions
   text("Kill as many Zombies as possible!",300,40);
   text("by pressing the mouse to direct bullets",300,80);
   text("center the mouse on the zombie and then hold for a second to shoot",100,120);
   text("Don't hold the mouse nonstop otherwise your score will be zeroed out after 2 seconds",20,160);
   text("Zombies you must kill: ",250,240);
   text("You are given three lives", 300,580);
   text("You lose a life and points everytime a zombie passes the bottom of the screen",60,610);
   text("There are three levels",300,640);
   text("after all the zombies in a level",300,670);
   text("are killed, granted you have lives left", 300,700);
   text("you will move on to the next level",300,730);
   text("Goodluck!!", 300,770);
   image(zombieHead,740,200,50,50);
   text("10 points",740,275);
   image(zombieHead2,640,200,50,50);
   text("25 points",620,275);
   image(zombieHead3,540,200,50,50);
   text("35 points",500,275);
   text("Bonus points if you hit: ", 155,340);
   image(bonus,500,300,60,60);
   image(bonus,650,300,60,60);
   image(bonus,800,300,60,60);
   text("lvl 1",450,340);
   text("lvl 2",600,340);
   text("lvl 3",750,340);
   text("20 points",490,380);
   text("40 points",640,380);
   text("60 points",790,380);
   image(personHead,500,400,60,60);
   text("Hit this human and you lose 10points! :",10,445);
   text("Gain 10 points for every human that makes it past the screen safe",100,520);
  }
  //getting from the manual to the game 
  void toGame() {
    if (mousePressed && (mouseX>750 && mouseX<980) && (mouseY>730 && mouseY<780)) {
      manual=false; 
      start=true; 
      effect =true;
      manualSound.stop();
    }
  }
  //the display when you are choosing a level 
  void levelDisplay() {
    background(levelScreen);
    fill(255, 0, 0);
    stroke(0);
    strokeWeight(3);
    rect(350, 150, 300, 100);
    rect(350, 350, 300, 100);
    rect(350, 550, 300, 100);
    strokeWeight(1);
    fill(0);
    textSize(40);
    text("Level 1", 440, 200);
    text("Easy", 450, 240);
    text("Level 2", 440, 400);
    text("Medium", 430, 440);
    text("Level 3", 440, 600);
    text("At your own risk", 365, 640);
  }
  //takes you to your chosen level 
  void levelSelection() {
    if (mousePressed) {
      //level1
      if ((mouseX>350 && mouseX<650)&&(mouseY>150 && mouseY<250)) {
        start=true; 
        levels=false;
        Levels.stop();
      }
      //level2
      else if ((mouseX>350 && mouseX<650)&&(mouseY>350&&mouseY<450)) {
        levels=false;
        gameStart=true;
        level1=false;
        level3=false;
        level2=true;
         Levels.stop();
      }
      //level3
      else if ((mouseX>350&&mouseX<650)&&(mouseY>550&&mouseY<650)) {
        levels=false;
        gameStart=true;
        level3=true;
        level1=false;
        level2=false;
         Levels.stop();
      }
    }
  }
}