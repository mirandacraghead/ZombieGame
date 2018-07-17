import processing.sound.*;
//booleans controlling which scrren to display
//start calls the first effect of opening your eyes once you push to start the game
boolean start = false; 
//if the manual button is clicked the page displays the directions 
boolean manual =false; 
//once the effect becomes false gamestart becomes true and the game begins
boolean effect = true; 
//starts the game
boolean gameStart = false; 
//the different levels of the game which control the different displays and difficulties
boolean level2 =false;
boolean level3 =false;
//whether or not the user has chosen to select the starting level
boolean levels=false;
//are you on the menu page 
boolean menu = true;
//menu object called whenver the menu needs to be displayed 
menu Menu = new menu();
//used to display the eye opening effect and manual primarly
gameImage gamePic = new gameImage();
//used to call the different methods per different level
gameInterface gaming = new gameInterface();
gameInterface2 gaming2 = new gameInterface2();
gameInterface3 gaming3 = new gameInterface3();
//menu image
PImage img; 
//menu background noise and the sound effect when you shoot the gun 
SoundFile menuPage, gun, manualSound,Levels;

void setup() {
  size(1000, 800);
  gun= new SoundFile(this, "gun.wav");
  menuPage = new SoundFile(this, "menuPage.mp3");
  manualSound = new SoundFile(this,"manualPage.mp3");
  Levels = new SoundFile(this,"levels.mp3");
  Menu.menu();
  //loading all of the pictures
  gamePic.setup();
  //for each level loading all of the location arrays for each zombie
  gaming.setup();
  gaming2.setup();
  gaming3.setup();
  frameRate(.5);
  menuPage.loop();
}
void draw() {
  frameRate(60);
  //when on the menu page method used to set either start or manual true depending on the button you click 
  if (menu) {
    Menu.mousePressed();
  }
   else if (levels) {
    gamePic.levelDisplay();
    //variable check for score and other things 
    gamePic.levelSelection();
  }
  //once start it true draw the effect 
  else if (start) {
    if (effect) {
      gamePic.draw();
    }
    //once the effect is over draw the level1 display and set the game to start 
    else {
      gamePic.backdropS1();
      gameStart = true; 
      start = false;
    }
  }
  //displays the manual when selected 
  else if (manual) {
    gamePic.backdropM();
    gamePic.toGame();
  }
  //starting the game 
  else if (gameStart) {
    //level 1
    if (level1) {
      if (lives>0) {
        //fix rate
        //sound effect
        //draws the zombies to the screen and keeps track of if you hit them
        gaming.draw();
        //if you chose the menu button pushes you back to the menu page
        gaming.exitOption();
        //checks to see if you have lives left if not goes to the gameOver
        gaming.check();
      } else {
        //displays the scoring page and then gives you the option to menu or restar the game directly 
        gaming.gameOver();
      }
    }
    //level2
    //the methods have the same effect as level 1 
    else if (level2) {
      if (lives>0) {
        gaming2.draw();
        gaming2.exitOption();
        gaming2.check();
      } else {
        gaming2.gameOver();
      }
    }
    //level3
    else if (level3) {
      if (lives>0) {
        gaming3.draw();
        gaming3.check();
        gaming3.exitOption();
      } else {
        gaming3.gameOver();
      }
    }
  }
}