PFont menuFont; 
PFont generalFont;

public class menu {
  void menu() {
    //different font styles called 
    generalFont=loadFont("LaBambaLetPlain-48.vlw");
    menuFont =loadFont("RuachLetPlain-48.vlw");
    //general display for the menu page
    textFont(menuFont, 32);
    background(0);
    img = loadImage("zombie.jpg");
    image(img, -30, 50, 1100, 700);
    fill(255, 0, 0);
    textSize(50);
    text("Zombie Attack", 375, height/17);
    //menu buttons
    //start
    rect(150, 720, 200, 70);
    //levels
    rect(400, 720, 200, 70);
    //manual
    rect(650, 720, 200, 70);
    fill(0);
    textFont(generalFont, 50);
    text("Start", 200, 770);
    text("Manual", 665, 770);
    text("Levels", 440, 770);
    fill(255, 0, 0);
    //exit game option 
    rect(20, 40, 70, 30);
    textSize(30);
    fill(0);
    text("Quit", 28, 65);
  }
  //checking which button you click granted you havent already chosen one 
  void mousePressed() {
    frameRate(60);
    if (mousePressed ==true && (start!=true && manual!=true)) {
      //chose to start the game
      if ((mouseX>150 && mouseX<350)&&(mouseY>720 && mouseY<790)) {
        start =true;
        menu=false;
        menuPage.stop();
      }
      //wanted to see the manual first
      else if ((mouseX>650 && mouseX<850)&&(mouseY>720 && mouseY<790)) {
        manual=true;
        menu=false;
        manualSound.loop();
        menuPage.stop();
      }
      //chose a level first 
      else if ((mouseX>400 && mouseX<600) &&(mouseY>720 && mouseY<790)) {
        levels=true;
        menu=false;
        menuPage.stop();
        Levels.loop();
      }
      //exited the game 
      else if ((mouseX>20 && mouseX<90)&&(mouseY>40 && mouseY<70)) {
        exit();
      }
    }
  }
}