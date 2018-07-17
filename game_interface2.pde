//multiple arrays to store the x and y locations of the medium difficulty zombies
float [] x2 = new float[40];
float [] y2 = new float[40];
//and easy zombies
float [] xe2 = new float[60];
float [] ye2 = new float[60];
float [] px2 = new float[30];
float [] py2 = new float[30];
//bonus target location first drawn outside of the screen then pushed in after a certain amount of time passes 
float bx2=0;
float by2=height+100;
//used to call only a certain number of medium zombies at a time
int counter2=1;
//call a certain number or people at a time
int counterp2 = 1;
//timer for level2
int timer2=0;
//used to call only a certain number of easy zombies to the screen based on the amount of time that has passed
int counter2e=1;
//used to check when both zombie arrays are completely outside of the display screen to check when to move on to the next level 
boolean level2E=false;
boolean level2M=false;
//used to control the medium zombie zig zag movement 
//xcounter is used to keep track of whether to move right or left based on the tcounter~amount of time that has passed
int xcounter=0;
int tcounter=0;
//used to see if the person is cheating by holding the mouse down and just moving around the screen
//keeps track of how much time has passed while mousepressed is true if too much time has passed score becomes zero 
int mtimer2=0;
public class gameInterface2 {
  void setup() {
    //call every time you reset the game 
    //allocating random locations (x and y) for each zombie difficulty level 
    //medium
    for (int i=0; i<40; i++) {
      x2[i] = random(30, 990); 
      y2[i] = random(30, 400);
    }
    //easy
    for (int i=0; i<60; i++) {
      xe2[i]=random(30, 990);
      ye2[i]=random(30, 200);
    }
      //people
    for (int i=0; i<30; i++) {
      px2[i]=random(30, 990);
      py2[i]=random(30, 200);
    }
  }
  void draw() {
    //display
    background(gamePage2);
    fill(255, 0, 0);
    //menu button to get back to the screen 
    rect(10, 10, 60, 20);
    fill(0);
    textSize(20);
    text("Menu", 13, 28);
    frameRate(5);
    textSize(40);
    fill(255, 0, 0);
    text("Level 2", 460, 40);
    textSize(30);
    //bonus image called to the screen after a certain period of time 
    image(bonus, bx2, by2, 50, 50);
    fill(255, 0, 0);
    text("Score:", 800, 770);
    text(score, 905, 770);
    text("Lives:",30,770);
    text(lives,100,770);
    fill(0, 255, 255);
    //gun
    image(gunImage, 500, 700);
    tint(255, 255);
    //calling the medium zombie heads based on the stored x and y array locations
    for (int i=0; i<counter2; i++) {
      image(zombieHead2, x2[i]-20, y2[i]-20, 40, 40);
      //moving the zombie heads down the screen overtime
      y2[i]+=5;
      tcounter++;
      //if xcounter=0 then the zombie head moves down and to the left by 5
      if (xcounter==0) {
        x2[i]-=5;
        constrain(x2[i], 20, 980);
        //once 20 seconds has passed which the direction to moving right accross the screen by 5
        if (tcounter>100) {
          tcounter=0;
          xcounter=1;
        }
        //keep switching for zig zag motion making it harder to hit the medium zombies
      } else if (xcounter==1) {
        x2[i]+=5;
        constrain(x2[i], 20, 980);
        if (tcounter>100) {
          tcounter=0;
          xcounter=0;
        }
      }
      //if the zombie reaches the buttom of the screen without being hit the screen flashes red, lose points, and you lose a life 
      if (y2[i]>height-20) {
        if (y2[i]<height-15) {
          lives--;
          fill(255, 0, 0, 100);
          rect(0, 0, 1000, 800);
          score-=10;
        }
      }
    }
    //display people heads
      fill(0, 255, 100);
    for (int i=0; i<counterp2; i++) {
      image(personHead, px2[i]-25, py2[i]-25, 45, 64);
      py2[i]+=10;
      //if person head makes it across screen, gain points 
      if (py2[i]>height-25) {
        if (py2[i]<height-20) {
          score+=10;
        }
      }
    }
    //displaying the easy zombie heads to the screen 
    fill(0, 255, 100);
    for (int i=0; i<counter2e; i++) {
      image(zombieHead, xe2[i]-25, ye2[i]-25, 50, 50);
      ye2[i]+=5;
      //same if the zombie head hits the end of the display without being hit you lose a life and the screen flashes red 
      if (ye2[i]>height-25) {
        if (ye2[i]<height-20) {
          lives--;
          fill(255, 0, 0, 100);
          rect(0, 0, 1000, 800);
          score-=5;
        }
      }
    }
    if (timer2%30==0) {
      //every 6 seconds (frameRate(5)) call 2 medium zombies to the display 
      counter2+=2;
      //every 6 seconds 3 new easy zombies are drawn to the screen 
      counter2e+=3;
       //every six seconds sends out 2 peeps
      counterp2 ++;
      //making sure not to go beyond the array limits 
      if (counter2>40) {
        counter2=40;
      }
      if (counter2e>60) {
        counter2e=60;
      }
      //counter for people
      if(counterp2 > 30){
        counterp2 = 30;
      }
    }
    //every 10 seconds get a new position for the bonus target for it to be drawn to the display
    if (timer2%50==0) {
      bx2=random(30, 970);
      by2=random(30, 770);
    }
    //make the bonus target disappear after 4 seconds has passed 
    if (timer2%70==0) {
      by2=height+100;
    }
    //making sure the noise for the gun is only called when going for zombies not for when clicking to go back to the main menu
    if (mousePressed  && !((mouseX>10 && mouseX<70) &&(mouseY>10 && mouseY<30))) {
      //laser
      mtimer2++;
      fill(255, 0, 0);
      ellipse(mouseX, mouseY, 5, 5);
      stroke(255, 0, 0);
      line(520, 720, mouseX, mouseY);
      stroke(0);
      gun.play();
      //detecting if the person is just holding down the mouse the entire time rather than shooting
      //if you cheat you score starts to zero
      if(mtimer2>10){
        textSize(100);
        text("cheater",400,400);
        score=0;
      }
      //easy zombie hit detection if you hit a easy zombie gain 10 points and the zombie is pushed beyond the display window
      for (int i=0; i<counter2e; i++) {
        if (sqrt(sq(mouseX-xe2[i])+sq(mouseY-ye2[i]))<25) {
          score+=20;
          ye2[i]=height+100;
        }
      }
      //medium zombie hit detection 
      for (int i=0; i<counter2; i++) {
        if (sqrt(sq(mouseX-x2[i])+sq(mouseY-y2[i]))<20) {
          score+=25;
          y2[i]=height+100;
        }
      }
         //people hit detection 
      for (int i=0; i<counterp2; i++) {
        if (sqrt(sq(mouseX-px2[i])+sq(mouseY-py2[i]))<20) {
          score-=10;
          py2[i]=height+100;
        }
      }
      //bonus hit detection 
      if (sqrt(sq(mouseX-(bx2+25))+sq(mouseY-(by2+25)))<25) {
        by2=height+100;
        score+=20;
      }
    }
    //reset the timer once the mouse isn't pressed
    else{
     mtimer2=0; 
    }

    timer2++;
  }
  //check for when the second level is done 
  void check() {
    //once both the easy and medium arrays are completely outside of the display window and you still have lives move on to the third level
    for (int i=0; i<60; i++) {
      if (ye2[i]>height+25 && lives>=1) {
        level2E=true;
      } else {
        level2E=false;
        break;
      }
    }
    for (int i=0; i<40; i++) {
      if (y2[i]>height+15 && lives>=1) {
        level2M=true;
      } else {
        level2M=false;
        break;
      }
    }
    //once both arrays are gone move on to the next level 
    if (level2E && level2M) {
      level2=false;
      level3=true;
    }
  }
  //button choice to go back to the main menu also resets the variables 
  void exitOption() {
    if (mousePressed && (mouseX>10 && mouseX<70)&&(mouseY>10 && mouseY<30)) {
      menuRestart();
      menuPage.loop();
    }
  }
  //if you run out of lives 
  void gameOver() {
    //score page display
    background(scoringPage);
    fill(255, 0, 0);
    rect(10, 10, 60, 20);
    fill(0);
    textSize(20);
    //choice between going straight to menu
    text("Menu", 15, 28);
    fill(255, 0, 0);
    rect(10, 40, 60, 20);
    fill(0);
    //or starting the game screen right away 
    text("Restart", 13, 58);
    textSize(40);
    fill(255, 0, 0);
    text("Rise again my Zombie Killer", 300, 80);
    textSize(30);
    text("Score:", 800, 700);
    text(score, 880, 700);
    //reset variables 
    if (mousePressed && (mouseX>10 && mouseX<70) &&(mouseY>10 && mouseY<30)) {
      menuRestart();
      menuPage.loop();
    } else if (mousePressed && (mouseX>10 && mouseX<70)&&(mouseY>40 && mouseY<60)) {
      frameRate(5);
      gameRestart();
    }
  }
  //reseting variable method calls 
  void gameRestart() {
    xcounter=0;
    tcounter=0;
    start=true;
    manual=false;
    effect=true;
    gameStart=false;
    level2=false;
    level2M=false;
    level1=true;
    level3=false;
    menu=false;
    mtimer2=0;
    by2=height+50;
    score=0;
    levels=false;
    counter2=1;
    counter2e=1;
    timer2=0;
      counterp2 = 1;
      counterp1 = 1;
    mtimer=0;
    by=height+50;
    lives=3;
    level2E=false;
    counter=1;
    timer=0;
    setup();
    gaming.setup();
  }
  void menuRestart() {
    xcounter=0;
    tcounter=0;
    start=false;
    manual=false;
    effect=true;
    gameStart=false;
      counterp1 = 1;
    level2=false;
    mtimer=0;
    counterp2 = 1;
    by=height+100;
    level1=true;
    mtimer2=0;
    level3=false;
    by2=height+100;
    menu=true;
    level2M=false;
    Menu.menu();
    score=0;
    counter2=1;
    levels=false;
    counter2e=1;
    timer2=0;
    lives=3;
    level2E=false;
    counter=1;
    timer=0;
    setup();
    gaming.setup();
  }
}