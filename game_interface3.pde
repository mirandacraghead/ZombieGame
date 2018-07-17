//booleans to check that all the arrays are beyond the screen display before saying that level3 is over 
boolean level3H=false;
boolean level3M=false;
boolean level3E=false;
//hard zombie array x and y locations
float [] x3 = new float [30];
float [] y3 = new float [30];
//easy
float [] xe3 = new float[70];
float [] ye3 = new float[70];
//medium
float [] xm3 = new float[50];
float [] ym3 = new float[50]; 
//people array
float [] px3 = new float[35];
float [] py3 = new float[35];
//bonus target location first called beyond the display until a certain amount of time passes 
float bx3=0;
float by3=height+100;
//counters to keep the number of zombies called in check based on the amount of time that has passed
//hard zombie counter
int counter3=1;
//easy zombie counter
//people count
int counterp3 = 1;
int counter3e =1;
//medium zombie counter
int counter3m =1;
//level three timer
int timer3=0;
//used for the zig zag motion of the medium zombies
//xcounter used to determine if the zombie should go right or left based on the amount of time passed by the tcounter
int xcounter2=0;
int tcounter2=0;
//boolean to help with the altering image effect
boolean changeImage=true; 
//stores the image i want the background to be 
//alternates between two images 
PImage patch;
int mtimer3=0;

public class gameInterface3 {

  //setting each zombie array locations x and y 
  void setup() {
    //hard zombies
    patch = gamePage3;
    for (int i=0; i<30; i++) {
      x3[i]=random(30, 990);
      y3[i] = random(30, 400);
    }
    //easy zombies
    for (int i=0; i<70; i++) {
      xe3[i]=random(30, 990);
      ye3[i]=random(30, 200);
    }
    //medium zombies
    for (int i=0; i<50; i++) {
      xm3[i]=random(30, 990);
      ym3[i]=random(30, 300);
    }
     //people array
    for (int i=0; i<35; i++) {
      px3[i]=random(30, 990);
      py3[i]=random(30, 200);
    }
  }
  void draw() {
    //display
    background(patch);
    fill(255, 0, 0);
    textSize(50);
    text("Score:", 780, 750);
    text(score, 905, 750);
    text("Lives:",30,770);
    text(lives,140,770);
    rect(10, 10, 60, 20);
    fill(0);
    textSize(20);
    //menu button choice to go back to the main page
    text("Menu", 13, 28);
    //calling bonus target picture to the screen after a certain amount of time has passed
    tint(255, 255);
    image(bonus, bx3, by3, 50, 50);
    textSize(40);
    fill(255, 0, 0);
    text("Level 3", 460, 40);
    frameRate(5);
    fill(0, 255, 100);
    //gun
    image(gunImage, 500, 700);
    tint(255, 255);
    //easy zombies
    //calling a certain amount of zombies to the screen at a time 
    for (int i=0; i<counter3e; i++) {
      image(zombieHead, xe3[i]-25, ye3[i]-25, 50, 50);
      ye3[i]+=5;
      //if the easy zombies hit the bottom of the display flash red and lose a life 
      //also lose 5 points 
      if (ye3[i]>height-25) {
        if (ye3[i]<height-20) {
          lives--;
          fill(255, 0, 0, 100);
          rect(0, 0, 1000, 800);
          score-=5;
        }
      }
    }
    //collision detection 
    if (mousePressed  && !((mouseX>10 && mouseX<70) &&(mouseY>10 && mouseY<30))) {
      fill(255, 0, 0);
      //laser effect
      ellipse(mouseX, mouseY, 5, 5);
      stroke(255, 0, 0);
      //laser originates from the gun to the selected spot 
      line(520, 720, mouseX, mouseY);
      stroke(0);
      //gun sound effect
      gun.play();
      mtimer3++;
      //detecting if the person is just holding down the mouse the entire time rather than shooting
      //if you cheat you score starts to zero
      if(mtimer3>10){
        textSize(100);
        text("cheater",400,400);
        score=0;
      }
      //easy zombie collision detection
      for (int i=0; i<counter3e; i++) {
        if (sqrt(sq(mouseX-xe3[i])+sq(mouseY-ye3[i]))<25) {
          score+=10; 
          ye3[i]=height+100;
        }
      }
      //medium zombie collision detection 
      for (int i=0; i<counter3m; i++) {
        if (sqrt(sq(mouseX-xm3[i])+sq(mouseY-ym3[i]))<20) {
          score+=25;
          ym3[i]=height+100;
        }
      }
      //hard zombie collision detection 
      for (int i=0; i<counter3; i++) {
        if (sqrt(sq(mouseX-x3[i])+sq(mouseY-y3[i]))<20) {
          score+=35;
          y3[i]=height+100;
        }
      }
      //people hit detection 
      for (int i=0; i<counterp3; i++) {
        if (sqrt(sq(mouseX-px3[i])+sq(mouseY-py3[i]))<20) {
          score-=10;
          py3[i]=height+100;
        }
      }
      //bonus target collision detection 
      if (sqrt(sq(mouseX-(bx3+25))+sq(mouseY-(by3+25)))<25) {
        by3=height+100;
        score+=30;
      }
    }
    else{
     mtimer3=0; 
    }

    fill(0, 255, 255);
    //medium zombies
    tint(255, 255);
    for (int i=0; i<counter3m; i++) {
      image(zombieHead2, xm3[i]-20, ym3[i]-20, 40, 40);
      ym3[i]+=5;
      tcounter2++;
      //moving diagonal 
      if (xcounter2==0) {
        xm3[i]-=5;
        //constrained not to leave the display window
        constrain(xm3[i], 40, 960);
        if (tcounter2>100) {
          tcounter2=0;
          xcounter2=1;
        }
      } else if (xcounter2==1) {
        xm3[i]+=5;
        //constrained not to leave the display window
        constrain(xm3[i], 40, 960);
        if (tcounter2>100) {
          tcounter2=0;
          xcounter2=0;
        }
      }
      //edge detection if the zombie wasn't hit and hit the bottom of the screen lose a life, points, and have the screen flash red 
      if (ym3[i]>height-20) {
        if (ym3[i]<height-15) {
          lives--;
          fill(255, 0, 0, 100);
          rect(0, 0, 1000, 800);
          score-=10;
        }
      }
    }
     //display people heads
      fill(0, 255, 100);
    for (int i=0; i<counterp3; i++) {
      image(personHead, px3[i]-25, py3[i]-25, 60, 85);
      py3[i]+=10;
      //if person head makes it across screen, gain points 
      if (py3[i]>height-25) {
        if (py3[i]<height-20) {
          score+=10;
        }
      }
    }
    //hard zombies
    fill(0, 0, 255);
    tint(255, 255);
    for (int i=0; i<counter3; i++) {
      image(zombieHead3, x3[i]-20, y3[i]-20, 40, 40);
      y3[i]+=3;
      //sliding movement of the hard zombies 
      x3[i]=x3[i] + random(-20, 20);
      //constrain so x cannot be negative 
      constrain(x3[i], 40, 960);
      //edge detection if it hits the bottom of the screen lose  a life, points, and flash red 
      if (y3[i]>height-20) {
        if (y3[i]<height-15) {
          lives--;
          fill(255, 0, 0, 100);
          rect(0, 0, 1000, 800);
          score-=15;
        }
      }
    }
    //after 6 seconds pass add 1 new hard zombie, 3 easy zombies, and 2 medium zombies
    //change the image every 6 seconds 
    if (timer3%30==0) {
       counterp3+=1;
      counter3+=1;
      counter3e+=3;
      counter3m+=2;
     //altering the image effect every 6 seconds 
      if (changeImage) {
        patch = gamePage32;
        changeImage=false;
      } else if (changeImage!=true) {
        patch=gamePage3;
        changeImage=true;
      }
      //making sure not to get outside of arrays
      //hard zombies
      if (counter3>30) {
        counter3=30;
      }
      //medium zombies
      if (counter3m>50) {
        counter3m=50;
      }
      //counter for people
      if(counterp3 > 35){
        counterp3 = 35;
      }
      //easy zombies
      if (counter3e>70) {
        counter3e=70;
      }
    }
    //after 12 seconds have the bonus get a new position 
    //increase bonus points for level 2 and level 3
    if (timer3%60==0) {
      bx3=random(30, 970);
      by3=random(30, 770);
    }
    //after 6 seconds have the bonus target disappear if not hit 
    if (timer3%90==0) {
      by3=height+100;
    }


    timer3++;
  }
  //checking to see if all the arrays are outside of the display window with lives left
  //if so level 3 is over and you win 
  void check() {
    //checking the hard zombie array
    for (int i=0; i<40; i++) {
      if (y3[i]>height+10 && lives>=1) {
        level3H=true;
      } else {
        level3H=false;
        break;
      }
    }
    //easy zombie array
    for (int i=0; i<70; i++) {
      if (ye3[i]>height+25 && lives>=1) {
        level3E=true;
      } else {
        level3E=false;
        break;
      }
    }
    //medium zombie array
    for (int i=0; i<50; i++) {
      if (ym3[i]>height+15 && lives>=1) {
        level3M=true;
      } else {
        level3M=false;
        break;
      }
    }
    //when all the arrays are beyond the display window you win this is
    //the scoring/winning display 
    if (level3E && level3M && level3H) {
      //go to the scoring page
      background(scoringPage);
      //text
      textSize(60);
      fill(255, 0, 0);
      text("Zombie Slayer.. You Win!!", 240, 80);
      rect(10, 20, 70, 30);
      rect(10, 60, 70, 30);
      textSize(30);
      fill(0);
      //option to go back to the menu or quit the game 
      text("Menu", 13, 44);
      text("Quit", 18, 84);
      textSize(40);
      fill(255, 0, 0);
      text("Score:", 750, 700);
      text(score, 850, 700);
      //button to quit or go to the menu
      if (mousePressed && (mouseX>10 && mouseX<80)&&(mouseY>20 && mouseY<50)) {
        menuRestart();
        menuPage.loop();
      }
      if (mousePressed && (mouseX>10 && mouseX<80) &&(mouseY>60 && mouseY<90)) {
        exit();
      }
    }
  }
  //resetting the variables if you want to restart the game 
  //select menu before the game is over
  void exitOption() {
    if (mousePressed && (mouseX>10 && mouseX<70)&&(mouseY>10 && mouseY<30)) {
      menuRestart();
      menuPage.loop();
    }
  }
  //you lose the game 
  void gameOver() {
    //display 
    background(scoringPage);
    fill(255, 0, 0);
    rect(10, 10, 60, 20);
    fill(0);
    textSize(20);
    //button to direct you to the main menu 
    text("Menu", 15, 28);
    fill(255, 0, 0);
    rect(10, 40, 60, 20);
    fill(0);
    //button to direct you directly to the game 
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
  //reseting the varialbes based on the button picked 
  void menuRestart() {
    start=false;
    manual=false;
    effect=true;
    gameStart=false;
    level1=true;
    level2=false;
    levels=false;
    level3=false;
    level2E=false;
    by=height+100;
    by2=height+100;
    by3=height+100;
    menu=true;
    level2M=false;
    Menu.menu();
    score=0;
      counterp1 = 1;
        counterp2 = 1;
    counter2=1;
    counter2e=1;
    timer2=0;
    lives=3;
    mtimer=0;
    setup();
    level3M=false;
    level3E=false;
    level3H=false;
    mtimer2=0;
    counter3=1;
    counter3e =1;
    counter3m =1;
    counterp3 = 1;
    timer3=0;
    changeImage=true;
    xcounter2=0;
    tcounter2=0;
    counter=1;
     mtimer3=0;
    timer=0;
    xcounter=0;
    tcounter=0;
    gaming.setup();
    gaming2.setup();
  }
  void gameRestart() {
    start=true;
    manual=false;
      counterp2 = 1;
    effect=true;
    changeImage=true;
    gameStart=false;
    counterp3 = 1;
    level1=true;
    level2=false;
    mtimer2=0;
    level3=false;
    level2E=false;
    by=height+100;
     mtimer3=0;
      counterp1 = 1;
    by2=height+100;
    by3=height+100;
    menu=false;
    level2M=false;
    mtimer=0;
    levels=false;
    score=0;
    counter2=1;
    counter2e=1;
    timer2=0;
    lives=3;
    setup();
    level3M=false;
    level3E=false;
    level3H=false;
    counter3=1;
    counter3e =1;
    counter3m =1;
    timer3=0;
    xcounter2=0;
    tcounter2=0;
    counter=1;
    timer=0;
    xcounter=0;
    tcounter=0;
    gaming.setup();
    gaming2.setup();
  }
}