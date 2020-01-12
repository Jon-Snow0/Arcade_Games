void choose()//chooses a city to bomb for each asteroid
{
  for (int i = 0; i<100; i++)
  {
    choosecity[i]=int(random(0, 6));
  }
}
void generateBalls() {//initial generation of bombs 
  for (int i=0; i<6; i++) {
    cityV[i]=true;
  }
  CX[0]=50;
  CX[1]=200;
  CX[2]=350;
  CX[3]=width-50;
  CX[4]=width-200;
  CX[5]=width-350;
  CY=height-50;
  choose();
  for (int i = 0; i<100; i++)
  {
    circD[i]=8;
    ball[i]=loadImage("asteroid6.png");//loads 150 of the bomb images
    ballD[i]=int(random(20, 35));//random sizes for asteroids
    ballX[i]=int(random(ballD[i]/2, width-(ballD[i]/2)));//random x values
    ballY[i]=int(random((-32)*height, -50));//y values start above the screen at random numbers
    ballVisible[i]=true;//sets visibility to true
    ball[i].resize(ballD[i], ballD[i]);//resizes asteroid to the random size of the asteroid
  }
}
void generateBullets() {//initial generation of bullets
  for (int i=0; i<100; i++)
  {
    bulletVisible[i]=false;
  }
}
void moveBalls() {//function controlling bomb movement
  for (int i = 0; i<100; i++)
  {
    float angle1 = atan((height-ballY[i])*1.0/(CX[choosecity[i]]-ballX[i]));
    if (CX[choosecity[i]]-ballX[i]<=0) {
      angle1+=PI;
    }
    ballSX[i]=ballSpeed*cos(angle1);
    ballSY[i]=ballSpeed*sin(angle1);
    if (ballVisible[i]) {
      ballX[i]+=ballSX[i];
      ballY[i]+=ballSY[i];
    }
  }
}
int distance (float x1, float y1, float x2, float y2) {//function that calculates distance between bomb and bullet
  return round(sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2)));
}
void moveBullets() {//function controlling bullet movement
  for (int i=0; i<100; i++)
  {
    if (bulletVisible[i]==true)
    {
      bulletdist[i]=distance(bulletX[i], bulletY[i], mouseposX[i], mouseposY[i]);
      if (bulletdist[i]<10) {
        posX=mouseposX[i];
        posY=mouseposY[i];
        bulletSX[i]=0;
        bulletSY[i]=0;
        frame=1;
        fireBullet[i]=true;
        if (frame==9) {
          bulletVisible[i]=false;
        }
        bulletVisible[i]=false;
      } else {
        bulletX[i]+=bulletSX[i];
        bulletY[i]+=bulletSY[i];
      }
    }
  }
}
void checkCollision() {//function checks collision between bomb and bullet and regenerates the asteroid if it is hit
  for (int i = 0; i<100; i++) {
    for (int j=0; j<100; j++) {
      if (ballVisible[i]&&fireBullet[j]&&ballX[i]>=mouseposX[j]-50&&ballX[i]<=mouseposX[j]+50) {
        if (ballY[i]>=mouseposY[j]-50&&ballY[i]<=mouseposY[j]+50) {
          if (ballSpeed<=10)
          {
            ballSpeed*=1.005;
          }
          score+=5;
          ballX[i]=int(random(ballD[i]/2, width-(ballD[i]/2)));
          ballY[i]=int(random((-32)*height, -50));
          choosecity[i]=int(random(0, 6));
          if (!cityV[choosecity[i]]) {
            choosecity[i]=int(random(0, 6));
          }
        }
      }
    }
  }
}
void cityCollision()//checks collision between the cities and the bombs
{
  for (int i = 0; i<100; i++) {
    for (int j =0; j<6; j++) {
      if (ballX[i]>=CX[j]-(50)&&ballX[i]<=CX[j]+(50))
      {
        if (ballY[i]>=CY-(50)&&ballY[i]<=CY+(50)&&ballVisible[i]==true)
        {
          if (cityV[j]) {
            posX=CX[j];
            posY=CY;
            ballX[i]=int(random(ballD[i]/2, width-(ballD[i]/2)));
            ballY[i]=int(random((-32)*height, -50));
            choosecity[i]=int(random(0, 6));
            if (!cityV[choosecity[i]]) {
              choosecity[i]=int(random(0, 6));
            }
            frame =1;
            boom.trigger();
            fireCity=true;
            cityV[j]=false;
          } else {
            ballX[i]=int(random(ballD[i]/2, width-(ballD[i]/2)));
            ballY[i]=int(random((-32)*height, -50));
            choosecity[i]=int(random(0, 6));
            if (!cityV[choosecity[i]]) {
              choosecity[i]=int(random(0, 6));
            }
          }
        }
      }
    }
  }
}
void redrawm()//main draw for missile command
{
  counter=0;
  frame1++;
  if (frame1==16) {
    frame1=1;
  }
  shoot++;
  tint(#FF9100);
  image(background, width/2, height/2);
  noTint();
  image(crosshair, mouseX, mouseY);
  fill(0, 255, 0);
  textSize(40);
  text("Score: "+score, width/2, 40);
  for (int i=0; i<100; i++)
  {  
    if (bulletVisible[i]==true)//bullets
    {
      //no fill, only outline for futuristic look
      stroke(#00FF00);
      noFill();
      rectMode(CENTER);//changes rectmode for easier calculation of distance
      rect(bulletX[i], bulletY[i], bulletW, bulletH);//draws bullet
    }
    if (ballVisible[i]==true)//asteroids
    {
      imageMode(CENTER);
      image(ball[i], ballX[i], ballY[i]);//draws current ball
    }
  }
  end=0;
  for (int j=0; j<6; j++)
  {
    if (cityV[j]==true) {
      image(city, CX[j], CY);
    }
    if (cityV[j]==false) {
      burning[frame1].resize(100, 100);
      image(city, CX[j], CY);
      image(burning[frame1], CX[j], CY);
      end+=1;
    }
  }
  if (end==6&&frame==9) {
    intro=10;
  }
  image(hill, width/2, height);
  fill(0);
  noStroke();
  arc(width/2, height-20, 75, 50, radians(180), radians(360));
  image(gun, width/2, height-70);
  moveBalls();
  moveBullets();
  if (startCheck) {
    checkCollision();
  }
  cityCollision();
  if (frame<9&&fireCity)
  {
    explosion[frame].resize(150, 150);
    image(explosion[frame], posX, posY);
    frame++;
  } else if (frame>=9) {
    fireCity=false;
  }
  for (int k = 0; k<100; k++) {
    if (frame<9&&fireBullet[k])
    {
      explosion[frame].resize(100, 100);
      image(explosion[frame], posX, posY);
      frame++;
    } else {
      fireBullet[k]=false;
    }
  }
}
void mousePressed() {//detects if the mouse is pressed
  if (shoot>=30) {
    startCheck=true;
    bulletX[currentBullet] = width/2;        
    bulletY[currentBullet] =height-115;  
    float angle1 = atan((mouseY-bulletY[currentBullet])*1.0/(mouseX-bulletX[currentBullet]));
    if (mouseX-bulletX[currentBullet]<=0) {
      angle1+=PI;
    }
    bulletSX[currentBullet] = 8.0*cos(angle1);
    bulletSY[currentBullet] = 8.0*sin(angle1);
    pew.trigger();
    bulletVisible[currentBullet] = true;  
    mouseposX[currentBullet]=mouseX;
    mouseposY[currentBullet]=mouseY;
    currentBullet++;
    if (currentBullet == 100) {
      currentBullet = 0;
    }
    shoot=0;
  }
  if (intro==12&&mouse==true||intro==11&&mouse==true) {
    if (jump) {
      VY=-15;
      flap.trigger();
    }
    mouse=false;
  }
}