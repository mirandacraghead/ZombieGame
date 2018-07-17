//x and y locations of the easy zombies stored in an array
float[] x = new float[40]; 
float[] y = new float[40]; 
//people array
float [] px1 = new float[20];
float [] py1 = new float[20];
//using a counter to only call a certain amount of zombies at a time depending on how much time has passed using the timer
int counter=1;
//people counter
int counterp1 = 1;
int timer=0;
//bonus target location
float bx=0;
float by=height+100;
boolean level1 = true;
//want score and lives available for all classes
public int score=0;
public int lives=3;
//cheater timer checking to see when mouse is pressed how much time passes 
//if you keep pressing no break you are cheating and will lose all your points 
int mtimer=0;

public class gameInterface {
  //reset everytime go to the menu page 
  //getting the locations for the zombies
  void setup() {
    for (int i=0; i<40; i++) {
      x[i] = random(30, 990); 
      y[i] = random(30, 200);
    }
    //setting the location of the array of people 
    for (int i=0; i<20; i++) {
      px1[i]=random(30, 990);
      py1[i]=random(30, 200);
    }
  }

  void draw() {
    frameRate(5);
    //display
    background(gamePage);
    tint(255, 255);
    //bonus image/target called to the screen after a certain period of time 
    image(bonus, bx, by);
    fill(255, 0, 0);
    textSize(30);
    text("Score:", 800, 770 );
    text(score, 905, 770);
    text("Lives:",30,770);
    text(lives,100,770);
    fill(255, 0, 0);
    //go back to menu button
    rect(10, 10, 60, 20);
    fill(0);
    textSize(20);
    text("Menu", 13, 28);
    textSize(40);
    fill(255, 0, 0);
    text("Level 1", 460, 40);
    fill(0);
    //gun
    image(gunImage, 500, 700);
    //drawing the zombies to the screen~a certain amount based on the counter 
    for (int i=0; i<counter; i++) {
      image(zombieHead, x[i]-25, y[i]-25, 50, 50);
      //downward movement of the zombies on the screen
      y[i]+=5;
      //if the zombie reaches the bottom of the screen without being hit you lose a life and the screen flashes red
      //also lose 5 points 
      if (y[i]>height-25) {
        if (y[i]<height-20) {
          lives--; 
          fill(255, 0, 0, 100);
          rect(0, 0, 1000, 800);
          score-=5;
        }
      }
    }
    //drawing people based on the counter
        for (int i=0; i<counterp1; i++) {
      image(personHead,px1[i]-25,py1[i]-25,40,51);
      //downward movement of the people on the screen
      py1[i]+=5;
      //if the zombie reaches the bottom of the screen without being hit you lose a life and the screen flashes red
      //also lose 5 points 
      if(py1[i]>height-25){
       if(py1[i]<height-20){
       score+=10;
       }
       }
      }
    //zombie collision detection
    if (mousePressed && !((mouseX>10 && mouseX<70) &&(mouseY>10 && mouseY<30))) {
      fill(255, 0, 0);
      //check this and reset the value as well as put in doc 
      mtimer++;
      ellipse(mouseX, mouseY, 5, 5);
      stroke(255, 0, 0);
      line(520, 720, mouseX, mouseY);
      stroke(0);
      gun.play();
      //detecting if the person is just holding down the mouse the entire time rather than shooting
      //if you cheat you score starts to zero
      if(mtimer>10){
        textSize(100);
        text("cheater",400,400);
        score=0;
      }
      //detecting which zombie you hit adding the according points to the score and moving that zombie out of view
      for (int i=0; i<counter; i++) {
        if (sqrt(sq(mouseX-x[i])+sq(mouseY-y[i]))<25) {
          score+=10;
          y[i]=height+100;
        }
      }
       //detecting people
      for (int i=0; i<counterp1; i++) {
        if (sqrt(sq(mouseX-px1[i])+sq(mouseY-py1[i]))<25) {
          score-=10;
          //add a sound 
          py1[i]=height+100;
        }
      }
      //bonus target collision detection
      if (sqrt(sq(mouseX-(bx+25))+sq(mouseY-(by+25)))<25) {
        by=height+100;
        score+=20;
      }
    }
    else{
     mtimer=0; 
    }
    //if 6 seconds have past call four more zombies to the screen and call a bonus target
    if (timer%30==0) {
      counterp1+=2;
      counter+=4;
      bx =random(30, 970);
      by = random(30, 770);
      //making sure not to get an out of array bounds error by keeping the counter within the array x and y sizes
      if (counter>40) {
        counter=40;
      }
       if (counterp1>20) {
        counterp1=20;
      }
    }
    //after 6 seconds pass make the bonus target disappear if not hit 
    if (timer%60==0) {
      by=height+100;
    }
    timer++;
  }

  void check() {
    //checking for when the first level is done given you still have lives left
    for (int i=0; i<40; i++) {
      //when all the zombies are beyond the screen display move on to level2
      if (y[i]>height+25 && lives>=1) {
        level1=false;
        level2=true;
      } else {
        level1=true;
        break;
      }
    }
  }
  //back to main menu page
  void exitOption() {
    if (mousePressed && (mouseX>10 && mouseX<70) && (mouseY>10 && mouseY<30)) {
      menuRestart();
      menuPage.loop();
    }
  }
  //go to a scoring page before restarting the game if you lose all your lives 
  //display the score 
  void gameOver() {
    background(scoringPage);
    fill(255, 0, 0);
    rect(10, 10, 60, 20);
    fill(0);
    textSize(20);
    //there is a menu button to push to menu
    text("Menu", 15, 28);
    fill(255, 0, 0);
    rect(10, 40, 60, 20);
    fill(0);
    //also a restart button to go straight into playing the game again 
    text("Restart", 13, 58);
    textSize(40);
    fill(255, 0, 0);
    text("Rise again my Zombie Killer", 300, 80);
    textSize(30);
    text("Score:", 800, 700);
    text(score, 880, 700);
    //reset variables based on the selection of going to the menu or game 
    if (mousePressed && (mouseX>10 && mouseX<70) &&(mouseY>10 && mouseY<30)) {
      menuRestart();
      menuPage.loop();
    } else if (mousePressed && (mouseX>10 && mouseX<70)&&(mouseY>40 && mouseY<60)) {
      gameRestart();
      
    }
  }

  //reset variable method calls 
  void gameRestart() {
    frameRate(5);
    start = true; 
    manual =false; 
    effect = true; 
    gameStart = false; 
    level2 =false;
    level1=true;
    menu = false;
    score=0; 
      counterp1 = 1;
    mtimer=0;
    counter=1;
    timer=0;
    levels=false;
    lives=3;
    setup();
  }
  void menuRestart() {
    start = false; 
    manual =false; 
    effect = true; 
    mtimer=0;
    gameStart = false; 
    levels=false;
    level2 =false;
    level1=true;
    counterp1 = 1;
    menu = true;
    Menu.menu();
    score=0; 
    counter=1;
    timer=0;
    lives=3;
    setup();
  }
}