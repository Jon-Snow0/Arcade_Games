int intro;//main variable controlling the gamestate
//images for the start screen and pause screen
PImage tronimage, snakeimage, cursor, pause, missileimage, missileback, tetris, crappyimage;
//boolean controlling detection of keys pressed
boolean [] keys=new boolean[8];
//snake and tron variables
int bs, numSegs=2, dirX, dirY;//grid size, number of segments, direction 
int[] segX=new int [numSegs], segY=new int [numSegs];//x and y values of each segment
//snake variables
//head and apple dimensions, number od rows and columns, hue of each segment
int headD=20, appleX, appleY, numBlocksW, numBlocksH, appleW, appleH, hue;
//array controlling whether the width or height is the longer dimension for the segment of the snake
int[] bodyW=new int[numSegs], bodyH=new int[numSegs];
//picture of an apple, the background, different positions for the tongue, the intro screen pic, the end screen X's
PImage apple, grass, tongueup, tonguedown, tonguel, tonguer, snakeintro, ded;
//tron variables
int  numSegs1=1, dirX1, dirY1, winner;//number of segments, direction of lightcycle, int controlling which side wins 
int[] segX1=new int [numSegs1], segY1=new int [numSegs1];//x and y positions fo each segment of the right lightcycle
PImage p1up, p2up, p1down, p2down, p1left, p2left, p1right, p2right, tronintro;//images for each of the lightcycle positions, intro screen image
//missile command variables
PImage  missileintro;//intro screen image
int[] ballD = new int[100]; //array that holds diameter of asteroids                             
float[] ballSX=new float[100], ballSY=new float[100];//x and y speeds of the bombs 
float[] ballX=new float[100];//array that holds the x values of the asteroids
float[] ballY=new float[100];//array that holds the y values of the asteroids
boolean[] ballVisible = new boolean[150];//controls if the asteroid is visible
int bulletW = 3;//width of the bullets                          
int bulletH = 18;//height of the bullets                  
float[] bulletSX=new float[100], bulletSY=new float[100];//x and y speeds of the bullets
int currentBullet = 0; //counter of bullets
float[] bulletX = new float[100];//array that holds x values of bullets
float[] bulletY = new float[100];//array that holds y values of bullets
boolean[] bulletVisible =new boolean[100];//array that controls a bullet's visibility
PImage sky, crosshair;//images for the sky and scope
int posX, posY;//position stored for the explosions
int[] choosecity=new int [100];//chosen city for each bomb
int [] mouseposX=new int[100], mouseposY=new int[100];//array storing every position of the mouse when clicked for the bullet to travel to
int CY;//value of every city's y position
int[] CX=new int[6];//value of every city's x position
boolean[] cityV=new boolean[6];//city visibility array
float []circD=new float[100];//diamater of each bomb
int end=0;//controls if the game is running
boolean fire = false;//explosion for bombs on the city
int score=0;//score
PImage background;//background image
int counter=0;//stops a loop after it runs once to prevent lag
boolean fireCity=false;//fire for city
float[] bulletdist=new float[100];//distance of the bullet to the bomb
int numFrames = 9;//tells the array to store all the frames of the gif
PImage[] explosion = new PImage [numFrames];//array for the gif
PImage[] burning = new PImage [16];//fire gif images
int frame = 1;//current frame for the explosion gif
int frame1=1;//current frame for the fire gif
PImage[] ball=new PImage[100];//array that holds 100 asteroid images
PImage city, hill, gun;//images for the cities, gun, and the hill the gun is on
boolean[] choose=new boolean[100];//array saying if a bomb has chosen a city
boolean[] fireBullet=new boolean[100];//explosion for the bullets
boolean startCheck=false;//starts the check collision
float ballSpeed=2.0;//speed of the bomb
int shoot=1;//allows a bullet to be shot only every 30 frames
//crappy bird variables
PImage crappyintro, background1;//image for the intro screen and first background
int background1W, background1X = 0, background1Y = 0, background2W, background2X ;//variables controlling the scrolling background
PImage background2 ;//the second background
PImage[] wall=new PImage[2], walld=new PImage[2];//arrays for the pipe images
int[] wallX=new int[2], wallL=new int[2];//arrays for the walls x values and length
PImage bird ;//bird image
boolean jump=false;//controls if the bird can still jump
int birdW, birdH, birdX = 300, birdY = 0, birdSpeed, VY=2;//bird dimensions, x and y values, speed of the background and pipes moving toward the bird
boolean mouse=true;//boolean allowing only one jump for each time the mouse is pressed
//sound effects
import ddf.minim.*;
Minim minim;
AudioPlayer playert;//tron main song
AudioPlayer players;//snake main song
AudioSample gameover;//Game over sound
AudioSample moresegs;//snake segment adding sound
AudioSample pausesound;//sound when paused
AudioSample boom;//tron crash
AudioPlayer playerm;//main song
AudioSample pew;//bullet shooting
AudioPlayer main;//main screen song
AudioSample flap;//bird flying sounds
AudioSample hit;//hitmarker sound when the bird hits a pipe
AudioSample point;//coin sound when a point is gained
AudioPlayer splat;//splat sound when the bird hits the ground
void setup()
{
  //sets size and different modes
  //loads and resizes images
  //loads sounds
  //sets variables to their initial values
  size(1000, 700);
  smooth();
  colorMode(RGB);
  apple=loadImage("apple.png");
  grass=loadImage("grass.jpg");
  tetris=loadImage("tetris.png");
  tetris.resize(80, 80);
  grass.resize(width, height);
  tonguel=loadImage("tonguel.png");
  tonguer=loadImage("tonguer.png");
  tongueup=loadImage("tongueup.png");
  tonguedown=loadImage("tonguedown.png");
  imageMode(CENTER);
  intro=1;
  minim=new Minim(this);
  playert=minim.loadFile("tron music.mp3");
  players=minim.loadFile("snake music.mp3");
  main=minim.loadFile("duckremix.mp3");
  boom=minim.loadSample("kaboom.mp3");
  gameover=minim.loadSample("gameOver.mp3");
  pausesound=minim.loadSample("pausesound.mp3");
  moresegs=minim.loadSample("snakeGrow.mp3");
  smooth();
  tronimage=loadImage("tronimage.png");
  snakeimage=loadImage("snakeimage.png");
  missileback=loadImage("missileback.jpg");
  missileback.resize(width, height);
  missileimage=loadImage("missileimage.png");
  crappyimage=loadImage("crappyimage.png");
  snakeintro=loadImage("snakeintro.jpg");
  tronintro=loadImage("tronintro.jpg");
  missileintro=loadImage("missileintro.png");
  ded=loadImage("ded.png");
  ded.resize(25, 25);
  snakeintro.resize(300, 200);
  tronintro.resize(400, 250);
  crappyintro=loadImage("crappyintro.png");
  crappyintro.resize(width, height);
  missileintro.resize(250, 320);
  cursor=loadImage("cursor.png");
  cursor.resize(80, 80);
  crappyimage.resize(350, 180);
  tronimage.resize(350, 180);
  snakeimage.resize(350, 180);
  missileimage.resize(350, 180);
  noStroke();
  p1up=loadImage("p1up.png");
  p2up=loadImage("p2up.png");
  p1down=loadImage("p1down.png");
  p2down=loadImage("p2down.png");
  p1left=loadImage("p1left.png");
  p2left=loadImage("p2left.png");
  p1right=loadImage("p1right.png");
  p2right=loadImage("p2right.png");
  p1up.resize(10, 30);
  p2up.resize(10, 30);
  p1down.resize(10, 30);
  p2down.resize(10, 30);
  p1left.resize(30, 10);
  p2left.resize(30, 10);
  p1right.resize(30, 10);
  p2right.resize(30, 10);
  pause=loadImage("pause.png");
  pause.resize(500, 100);
  for (int i = 1; i<explosion.length; i++)
  {
    String name ="explosion"+i+".png";
    explosion[i] = loadImage(name);
  }
  for (int i = 1; i<burning.length; i++)
  {
    String name1 ="fire"+i+".png";
    burning[i] = loadImage(name1);
  }
  crosshair=loadImage("crosshair.png");
  crosshair.resize(75, 75);
  background = loadImage("sky.jpg"); 
  background.resize(width, height);
  city=loadImage("city.png");
  hill=loadImage("hill.png");
  hill.resize(200, 100);
  city.resize(100, 100);
  gun=loadImage("gunbarrel.png");
  gun.resize(15, 50);
  playerm=minim.loadFile("gamemusic.mp3");
  boom=minim.loadSample("kaboom.mp3");
  pew=minim.loadSample("pew.mp3");
  background1 = loadImage("crappyback.png");
  background1W = background1.width;
  background2X = background1W;
  background2 = loadImage("crappyback.png");
  background2W = background2.width;
  for (int i=0; i<2; i++) {
    wall[i]=loadImage("wall"+i+".png");
    walld[i]=loadImage("walld"+i+".png");
  }
  bird = loadImage("bord.png");
  birdW = bird.width;
  birdH = bird.height;
  birdSpeed = 6;
  birdY = width/2-150;
  wallX[0]=width-100;
  wallL[0]=int(random(100, height-250));
  wallX[1]=wallX[0]+498;
  wallL[1]=int(random(100, height-250));
  for (int i=0; i<2; i++) {
    wall[i].resize(150, wallL[i]);
    walld[i].resize(150, height-wallL[i]-200);
  }
  flap=minim.loadSample("flap.mp3");
  hit=minim.loadSample("hit.mp3");
  point=minim.loadSample("point.mp3");
  splat=minim.loadFile("splat.mp3");
}
void draw()
{
  //calls functions depending on the the value of the intro variable
  //controls the playing and rewinding of the audio players
  if (intro==1)intro1();
  if (intro==2)intro2();
  if (intro==3)intro3();
  if (intro==4)intro4();
  if (intro==5)intro5();
  if (intro==6)intro6();
  if (intro==7)intro7();
  if (intro==8)intro8();
  if (intro==9)intro9();
  if (intro==10)intro10();
  if (intro==11)intro11();
  if (intro==12)intro12();
  if (intro!=2&&intro!=3&&intro!=4)
  {
    players.rewind();
    players.pause();
  } else {
    players.play();
  }
  if (intro!=5&&intro!=6&&intro!=7)
  {
    playert.rewind();
    playert.pause();
  } else {
    playert.play();
  }
  if (intro!=8&&intro!=9&&intro!=10)
  {
    playerm.rewind();
    playerm.pause();
  } else {
    playerm.play();
  }
  if (intro!=1)
  {
    main.rewind();
    main.pause();
  } else {
    main.play();
  }
}
void intro1()//intro screen
{
  main.play();
  if (!main.isPlaying())
  {
    main.rewind();
    main.play();
  }
  frameRate(60);
  noCursor();
  background(0);
  imageMode(CENTER);
  image(tetris, width/2, height/2-50);
  image(tetris, width/2, height/2+30);
  image(tetris, width/2, height/2+110);
  image(tetris, width/2, height/2+190);
  image(tetris, width/2, height/2+270);
  textAlign(CENTER);
  textSize(75);
  fill(#00FF19);
  text("MATTHEW'S ARCADE", width/2, 150);
  textSize(50);
  text("Choose a Game!", width/2, 225);
  fill(150);
  rectMode(CENTER);
  rect((width/2)/2, height-350, 370, 200);
  rect((width/2)+(width/2)/2, height-350, 370, 200);
  rect((width/2)/2, height-130, 370, 200);
  rect((width/2)+(width/2)/2, height-130, 370, 200);
  image(tronimage, (width/2)+(width/2)/2, height-350);
  image(snakeimage, (width/2)/2, height-350);
  image(missileimage, (width/2)/2, height-130);
  image(crappyimage, (width/2)+(width/2)/2, height-130);
  fill(#00FF19);
  text("TRON", (width/2)+(width/2)/2, height-350);
  text("MISSILE", (width/2)/2, height-150);
  text("COMMAND", (width/2)/2, height-100);
  fill(0);
  text("SNAKE", (width/2)/2, height-350);
  text("CRAPPY", (width/2)+(width/2)/2, height-150);
  text("BIRD", (width/2)+(width/2)/2, height-100);
  fill(#00FF19);
  image(cursor, mouseX, mouseY);
  if (mousePressed)
  {
    //detects if the buttons are pressed
    if (mouseX>=((width/2)/2)-(370/2)&&mouseX<=(width/2/2)+(370/2))
    {
      if (mouseY>=height-350-100&&mouseY<=height-350+100)intro=2;
    }
    if (mouseX>=width/2+(width/2)/2-370/2&&mouseX<=width/2+(width/2)/2+370/2)
    {
      if (mouseY>=height-350-100&&mouseY<=height-350+100)intro=5;
    }
    if (mouseX>=(width/2/2)-370/2&&mouseX<=(width/2/2)+370/2)
    {
      if (mouseY>=height-130-100&&mouseY<=height-130+100)intro=8;
    }
    if (mouseX>=width/2+(width/2)/2-370/2&&mouseX<=width/2+(width/2)/2+370/2)
    {
      if (mouseY>=height-130-100&&mouseY<=height-130+100)intro=11;
    }
  }
}
void intro2()//intro screen of snake
{
  colorMode(HSB);
  cursor();
  bs=25;
  numSegs = 2;
  apple.resize(bs, bs);
  appleX=int(random(1, numBlocksW))*bs-(appleW/2);
  appleY=int(random(1, numBlocksH))*bs-(appleH/2);
  numBlocksW=width/bs;
  numBlocksH=height/bs;
  segX=new int[numSegs];
  segY=new int[numSegs];
  segX[0]=width/2;
  segY[0]=height/2;
  dirX=0;
  dirY=0;
  imageMode(CENTER);
  image(grass, width/2, height/2);
  fill(0);
  textSize(50);
  text("Control the snake with the arrow keys", width/2, height/2-250);
  text("Press any key to start", width/2, height/2+50);
  rect(width/2, height/2+200, 400, 200);
  if (mousePressed)
  {
    if (mouseX>=width/2-200&&mouseX<=width/2+200)
    {
      if (mouseY>=height/2+100&&mouseY<=height/2+300) {
        intro=1;
      }
    }
  }
  fill(int(random(255)), 255, 255);
  textSize(65);
  text("MAIN MENU", width/2, height/2+220);
  tongueup.resize(bs/3, bs);
  tonguedown.resize(bs/3, bs);
  tonguel.resize(bs, bs/3);
  tonguer.resize(bs, bs/3);
  image(snakeintro, width/2, height/2-125);
  if (keyPressed)intro=3;
}
void intro3()//snake game screen
{
  noCursor();
  frameRate(12);
  players.play();
  if (!players.isPlaying())
  {
    players.rewind();
    players.play();
  }
  reDraws();
}
void intro4()//snake end screen
{
  colorMode(HSB);
  cursor();
  numSegs = 2;
  segX=new int[numSegs];
  segY=new int[numSegs];
  segX[0]=width/2;
  segY[0]=height/2;
  dirX=0;
  dirY=0;
  fill(0);
  textSize(80);
  text("GAME OVER", width/2, height/2-280);
  textSize(50);
  text("Press any key to restart", width/2, height/2+20);
  rect(width/2, height/2+150, 400, 200);
  fill(int(random(255)), 255, 255);
  textSize(65);
  text("MAIN MENU", width/2, height/2+170);
  if (mousePressed)
  {
    if (mouseX>=width/2-200&&mouseX<=width/2+200)
    {
      if (mouseY>=height/2+50&&mouseY<=height/2+250) {
        intro=1;
      }
    }
  }
  image(snakeintro, width/2, height/2-140);
  image(ded, width/2-110, height/2-210);
  image(ded, width/2-80, height/2-210);
  if (keyPressed)intro=3;
}
void intro5()//tron intro screen
{
  cursor();
  numSegs = 1;
  numSegs1 = 1;
  segX=new int[numSegs];
  segY=new int[numSegs];
  segX1=new int[numSegs1];
  segY1=new int[numSegs1];
  colorMode(RGB);
  background(0, 1, 34);
  fill(255);
  textSize(50);
  text("Left controls are W,A,S,D", width/2, height/2-300);
  text("Right controls are the arrow keys", width/2, height/2-250);
  text("Press any key to start", width/2, height/2+75);
  imageMode(CENTER);
  rect(width/2, height/2+200, 400, 200);
  if (mousePressed)
  {
    if (mouseX>=width/2-200&&mouseX<=width/2+200)
    {
      if (mouseY>=height/2+100&&mouseY<=height/2+300) {
        intro=1;
      }
    }
  }
  colorMode(HSB);
  fill(int(random(255)), 255, 255);
  textSize(65);
  text("MAIN MENU", width/2, height/2+220);
  image(tronintro, width/2, height/2-100);
  bs=10;
  segX[0]=100;
  segY[0]=height/2;
  segX1[0]=width-100;
  segY1[0]=height/2;
  dirX=bs;
  dirY=0;
  dirY1=0;
  dirX1=-bs;
  if (keyPressed)intro=6;
}
void intro6()//tron game screen
{
  noCursor();
  frameRate(30);
  playert.play();
  if (!playert.isPlaying())
  {
    playert.rewind();
    playert.play();
  }
  reDrawt();
}
void intro7()//tron end screen
{
  cursor();
  colorMode(RGB);
  background(0, 1, 34);
  fill(255);
  rect(width/2, height/2+200, 400, 200);
  if (mousePressed)
  {
    if (mouseX>=width/2-200&&mouseX<=width/2+200)
    {
      if (mouseY>=height/2+100&&mouseY<=height/2+300) {
        intro=1;
      }
    }
  }
  colorMode(HSB);
  fill(int(random(255)), 255, 255);
  textSize(65);
  text("MAIN MENU", width/2, height/2+220);
  colorMode(RGB);
  if (winner==1)
  {
    fill(0, 0, 255);
    textSize(75);
    text("Player 1 Wins!", width/2, 100);
  }
  if (winner==2)
  {
    fill(255, 0, 0);
    textSize(75);
    text("Player 2 Wins!", width/2, 100);
  }
  fill(255);
  text("Press space to restart", width/2, 300);
  numSegs = 1;
  numSegs1 = 1;
  segX=new int[numSegs];
  segY=new int[numSegs];
  segX1=new int[numSegs1];
  segY1=new int[numSegs1];
  segX[0]=100;
  segY[0]=height/2;
  segX1[0]=width-100;
  segY1[0]=height/2;
  dirX=bs;
  dirY=0;
  dirY1=0;
  dirX1=-bs;
  if (keyPressed&&key==' ')intro=6;
}
void intro8()//missile command intro screen
{
  if (counter<1) {
    colorMode(RGB);
    playerm.play();
    score=0;
    ballD = new int[100];                         
    ballSX=new float[100];
    ballSY=new float[100];
    ballX=new float[100];
    ballY=new float[100];
    ballVisible = new boolean[150];
    bulletSX=new float[100];
    bulletSY=new float[100];
    currentBullet = 0;
    bulletX = new float[100];
    bulletY = new float[100];
    bulletVisible =new boolean[100];
    choosecity=new int [100];
    mouseposX=new int[100];
    mouseposY=new int[100];
    CX=new int[6];
    cityV=new boolean[6];
    circD=new float[100];
    end=0;
    fire = false;
    fireCity=false;
    bulletdist=new float[100];
    frame = 1;
    frame1=1;
    ball=new PImage[100];
    choose=new boolean[100];
    fireBullet=new boolean[100];
    startCheck=false;
    ballSpeed=2.0;
    shoot=1;
    generateBalls();
    generateBullets();
    frameRate(60);
    counter++;
  }
  cursor();
  image(missileback, width/2, height/2);
  fill(255);
  textSize(50);
  text("Shoot with the mouse", width/2, height/2-300);
  text("Defend the cities!", width/2, height/2-250);
  text("Press SPACE to start", width/2, height/2+200);
  imageMode(CENTER);
  colorMode(HSB);
  fill(int(random(255)), 255, 255);
  textSize(65);
  text("Press M to go to the main menu", width/2, height/2+325);
  image(missileintro, width/2, height/2-30);
  colorMode(RGB);
  if (keyPressed&&key==' ')intro=9;
  if (keyPressed&&key=='m'||keyPressed&&key=='M')intro=1;
}
void intro9() {//missile command game screen
  noCursor();
  if (!playerm.isPlaying())
  {
    playerm.rewind();
    playerm.play();
  }
  redrawm();
}
void intro10() {//missile command end screen
  if (counter<1) {
    ballD = new int[100];                         
    ballSX=new float[100];
    ballSY=new float[100];
    ballX=new float[100];
    ballY=new float[100];
    ballVisible = new boolean[150];
    bulletSX=new float[100];
    bulletSY=new float[100];
    currentBullet = 0;
    bulletX = new float[100];
    bulletY = new float[100];
    bulletVisible =new boolean[100];
    choosecity=new int [100];
    mouseposX=new int[100];
    mouseposY=new int[100];
    CX=new int[6];
    cityV=new boolean[6];
    circD=new float[100];
    end=0;
    fire = false;
    fireCity=false;
    bulletdist=new float[100];
    frame = 1;
    frame1=1;
    ball=new PImage[100];
    choose=new boolean[100];
    fireBullet=new boolean[100];
    startCheck=false;
    ballSpeed=2.0;
    shoot=1;
    generateBalls();
    generateBullets();
    frameRate(60);
    counter++;
  }
  image(missileback, width/2, height/2);
  colorMode(RGB);
  fill(255, 0, 0);
  textSize(80);
  text("GAME OVER", width/2, height/2-280);
  text("PRESS R TO RESTART", width/2, height/2+250);
  fill(0, 255, 0);
  text("Score: "+score, width/2, height/2-180);
  colorMode(HSB);
  fill(int(random(255)), 255, 255);
  textSize(65);
  text("Press M to go to the main menu", width/2, height/2+325);
  image(missileintro, width/2, height/2);
  if (keyPressed&&key=='r'||keyPressed&&key=='R') {
    intro=8;
  }
  if (keyPressed&&key=='m'||keyPressed&&key=='M') {
    intro=1;
  }
}
void intro11() {//flappy bird intro and end screen
  birdY = width/2-150;
  wallX[0]=width-100;
  VY=2;
  wallX[1]=wallX[0]+498;
  birdSpeed=6;
  jump=true;
  background(80);
  frameRate(60);
  imageMode(CENTER);
  image(crappyintro, width/2, height/2);
  imageMode(CORNER);
  textSize(65);
  colorMode(HSB);
  fill(int(random(255)), 255, 255);
  text("Press M to go to the main menu", width/2, height/2+325);
  if (keyPressed&&key=='m'||keyPressed&&key=='M') {
    intro=1;
  }
  if (!mouse) 
  {
    score=0;
    intro=12;
  }
  if (score>0) {
    fill(0);
    textSize(55);
    text("Score: "+score, 250, height-200);
  }
}
void intro12() {//flappy bird game screen
  cursor();
  redrawc();
}
void keyPressed() {
  if (key==CODED && keyCode==RIGHT) keys[0]=true;
  if (key==CODED && keyCode==LEFT) keys[1]=true;
  if (key==CODED && keyCode==UP) keys[2]=true;
  if (key==CODED && keyCode==DOWN) keys[3]=true;
  if (key=='d') keys[4]=true;
  if (key=='a') keys[5]=true;
  if (key=='w') keys[6]=true;
  if (key=='s') keys[7]=true;
  if (key=='o') {
    intro=1;
  }
  if (key=='p')
  {
    if (intro==3)
    {
      if (looping)
      {
        players.pause();
        pausesound.trigger();
        imageMode(CENTER);
        image(pause, width/2, height/2);
        noLoop();
      } else
      {
        pausesound.trigger();
        players.play();
        loop();
      }
    }
    if (intro==6)
    {
      if (looping)
      {
        playert.pause();
        pausesound.trigger();
        image(pause, width/2, height/2);
        noLoop();
      } else
      {
        pausesound.trigger();
        playert.play();
        loop();
      }
    }
    if (intro==9)
    {
      if (looping)
      {
        playerm.pause();
        pausesound.trigger();
        image(pause, width/2, height/2);
        noLoop(); 
      } else
      {
        pausesound.trigger();
        playerm.play();
        loop();
      }
    }
    if (intro==12)
    {
      if (looping)
      {
        pausesound.trigger();
        image(pause, width/2, height/2);
        noLoop();
      } else
      {
        pausesound.trigger();
        loop();
      }
    }
  }
}
void keyReleased() {//sets the boolean for when keys are pressed to false
  if (key==CODED && keyCode==RIGHT) keys[0]=false;
  if (key==CODED && keyCode==LEFT) keys[1]=false;
  if (key==CODED && keyCode==UP) keys[2]=false;
  if (key==CODED && keyCode==DOWN) keys[3]=false;
  if (key=='d') keys[4]=false;
  if (key=='a') keys[5]=false;
  if (key=='w') keys[6]=false;
  if (key=='s') keys[7]=false;
}