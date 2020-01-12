void reDraws()//main draw for snake
{
  image(grass, width/2, height/2);
  image(apple, appleX, appleY);
  textAlign(CENTER);
  colorMode(HSB);
  if (dirX!=0||dirY!=0)
  {
    for (int i=1; i < segX.length; i++) {
      hue = int(random(0, 255));  
      fill (hue, 255, 255);        
      ellipse (segX[i], segY[i], bodyW[i], bodyH[i]);
    }
    colorMode(RGB);
    fill(0, 255, 0);
    ellipse (segX[0], segY[0], headD, headD);
    if (dirX>0)
    {
      fill(0);
      ellipse(segX[0]+(headD/5), segY[0]-(headD/4), headD/4, headD/4);
      ellipse(segX[0]+(headD/5), segY[0]+(headD/4), headD/4, headD/4);
      fill(255, 0, 0);
      image(tonguer, segX[0]+headD, segY[0]);
    }
    if (dirX<0)
    {
      fill(0);
      ellipse(segX[0]-(headD/5), segY[0]-(headD/4), headD/4, headD/4);
      ellipse(segX[0]-(headD/5), segY[0]+(headD/4), headD/4, headD/4);
      fill(255, 0, 0);
      image(tonguel, segX[0]-headD, segY[0]);
    }
    if (dirY<0)
    {
      fill(0);
      ellipse(segX[0]-(headD/4), segY[0]-(headD/5), headD/4, headD/4);
      ellipse(segX[0]+(headD/4), segY[0]-(headD/5), headD/4, headD/4);
      fill(255, 0, 0);
      image(tongueup, segX[0], segY[0]-headD);
    }
    if (dirY>0)
    {
      fill(0);
      ellipse(segX[0]-(headD/4), segY[0]+(headD/5), headD/4, headD/4);
      ellipse(segX[0]+(headD/4), segY[0]+(headD/5), headD/4, headD/4);
      fill(255, 0, 0);
      image(tonguedown, segX[0], segY[0]+headD);
    }
  } else {
    colorMode(HSB);
    fill(int(random(255)), 255, 255);
    textSize(40);
    text("Press an arrow key to start", width/2, height/2);
  }
  for (int i=1; i<numSegs; i++)
  {
    if (segY[i]==segY[i-1])
    {
      bodyW[i]=bs;
      bodyH[i]=16;
    }
    if (segX[i]==segX[i-1])
    {
      bodyW[i]=16;
      bodyH[i]=bs;
    }
  }  
  if (keys[0]) {
    if (dirX==0||numSegs==1)
    {
      dirX = bs;
      dirY = 0;
    }
  }

  if (keys[1]) {
    if (dirX==0||numSegs==1)
    {
      dirX = -bs;
      dirY = 0;
    }
  }

  if (keys[2]) {
    if (dirY==0||numSegs==1)
    {
      dirX = 0;
      dirY = -bs;
    }
  }

  if (keys[3]) {
    if (dirY==0||numSegs==1)
    {
      dirX = 0;
      dirY = bs;
    }
  }
  moves();
  appleCollision();
  wallCollision();
  snekCollision();
  textSize(40);
  fill(0);
  text("LENGTH: "+numSegs, width/2, height-50);
}
void snekCollision()//checks collision betweem the snake's head and its body
{
  for (int i=1; i<numSegs; i++)
  {
    if (segX[0]==segX[i]&&segY[0]==segY[i])
    {
      if (numSegs>6) {
        gameover.trigger();
        intro=4;
      }
    }
  }
}
void wallCollision()//checks collision between the snakes head and the screen boundaries
{
  if (segX[0]<=0||segX[0]>=width||segY[0]<=0||segY[0]>=height) {
    gameover.trigger();
    intro=4;
  }
}
void appleCollision()//detects if an apple has been eaten
{    
  if (segX[0]==appleX&&segY[0]==appleY)
  {
    for (int i = 0; i<5; i++)
    {
      segX = append(segX, segX[numSegs-1]);  
      segY = append(segY, segY[numSegs-1]);
      bodyW = append(bodyW, 16);  
      bodyH = append(bodyH, 16);
      numSegs = numSegs + 1;
    }
    moresegs.trigger();
    appleX=int(random(1, numBlocksW))*bs-(appleW/2);
    appleY=int(random(1, numBlocksH))*bs-(appleH/2);
    for (int i=0; i<numSegs; i++)
    {
      if (appleX==segX[i]&&appleY==segY[i])
      {
        appleX=int(random(1, numBlocksW))*bs-(appleW/2);
        appleY=int(random(1, numBlocksH))*bs-(appleH/2);
      }
    }
  }
}
void moves()//moves the segments in the current direction
{
  for (int i = numSegs-1; i > 0; i--) { // starting from the tail,
    segX[i] = segX[i-1];                 // each segment takes the coordinates of the previous one
    segY[i] = segY[i-1];                 // the first segment takes the coordinates of the head
  }

  segX[0] = segX[0] + dirX;              // the head moves one step in the 
  segY[0] = segY[0] + dirY;              // current direction
}