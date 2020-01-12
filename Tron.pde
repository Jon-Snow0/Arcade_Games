void reDrawt()//main draw for tron
{
  colorMode(RGB);
  background(0, 1, 34);
  for (int i=1; i < segX.length; i++) {
    rectMode(CENTER);
    fill(17, 149, 247);
    rect(segX[i], segY[i], bs, bs);
  }
  for (int i=1; i < segX1.length; i++) {
    rectMode(CENTER);
    fill(255, 0, 23);
    rect(segX1[i], segY1[i], bs, bs);
  }
  if (dirX>0)image(p1right, segX[0], segY[0]);
  if (dirX<0)image(p1left, segX[0], segY[0]);
  if (dirY>0)image(p1down, segX[0], segY[0]);
  if (dirY<0)image(p1up, segX[0], segY[0]);
  if (dirX1>0)image(p2right, segX1[0], segY1[0]);
  if (dirX1<0)image(p2left, segX1[0], segY1[0]);
  if (dirY1>0)image(p2down, segX1[0], segY1[0]);
  if (dirY1<0)image(p2up, segX1[0], segY1[0]);
  if (dirX==0&&dirY==0)image(p1right, segX[0], segY[0]);
  if (dirX1==0&&dirY1==0)image(p2left, segX1[0], segY1[0]);
  if (dirX1!=0||dirY1!=0)
  {
    segX1 = append(segX1, segX1[numSegs1-1]);  
    segY1 = append(segY1, segY1[(numSegs1)-1]);
    numSegs1 = numSegs1 + 1;
  }
  if (dirX!=0||dirY!=0)
  {
    segX = append(segX, segX[numSegs-1]);  
    segY = append(segY, segY[numSegs-1]);
    numSegs = numSegs + 1;
  }
  if (keys[4]) {
    if (dirX==0||numSegs==1)
    {
      dirX = bs;
      dirY = 0;
    }
  }

  if (keys[5]) {
    if (dirX==0||numSegs==1)
    {
      dirX = -bs;
      dirY = 0;
    }
  }

  if (keys[6]) {
    if (dirY==0||numSegs==1)
    {
      dirX = 0;
      dirY = -bs;
    }
  }

  if (keys[7]) {
    if (dirY==0||numSegs==1)
    {
      dirX = 0;
      dirY = bs;
    }
  }
  if (keys[0]) {
    if (dirX1==0||numSegs1==1)
    {
      dirX1 = bs;
      dirY1 = 0;
    }
  }

  if (keys[1]) {
    if (dirX1==0||numSegs1==1)
    {
      dirX1 = -bs;
      dirY1 = 0;
    }
  }

  if (keys[2]) {
    if (dirY1==0||numSegs1==1)
    {
      dirX1 = 0;
      dirY1 = -bs;
    }
  }

  if (keys[3]) {
    if (dirY1==0||numSegs1==1)
    {
      dirX1 = 0;
      dirY1 = bs;
    }
  }
  movet();
  walltCollision();
  playerCollision();
}
void playerCollision()//checks collision between lightcycles and the lines they leave behind
{
  for (int i=1; i<numSegs; i++)
  {
    if (numSegs>2)
    {
      if (segX[0]==segX[i]&&segY[0]==segY[i])
      {
        boom.trigger();
        winner=2;
        intro=7;
      }
      if (segX1[0]==segX[i]&&segY1[0]==segY[i])
      {
        boom.trigger();
        winner=1;
        intro=7;
      }
    }
  }
  for (int i=1; i<numSegs1; i++)
  {
    if (numSegs1>2)
    {
      if (segX1[0]==segX1[i]&&segY1[0]==segY1[i])
      {
        boom.trigger();
        winner=1;
        intro=7;
      }
      if (segX[0]==(segX1)[i]&&segY[0]==(segY1)[i])
      {
        boom.trigger();
        winner=2;
        intro=7;
      }
    }
  }
  if (segX[0]==segX1[0]&&segY[0]==segY1[0]) { 
    boom.trigger();
    winner=int(random(1, 3));
    intro=7;
  }
}
void walltCollision()//screen wrap
{
  for (int i=0; i<numSegs; i++)
  {
    if (segX[i]<0-(bs/2))
    {
      segX[i]=width+bs;
    }
    if (segX[i]>width+bs)
    {
      segX[i]=0-bs;
    }
    if (segY[i]>height+bs)
    {
      segY[i]=0-bs;
    }
    if (segY[i]<0-bs)
    {
      segY[i]=height+bs;
    }
  }
  for (int i=0; i<numSegs1; i++)
  {
    if (segX1[i]<0-(bs/2))
    {
      segX1[i]=width+bs;
    }
    if (segX1[i]>width+bs)
    {
      segX1[i]=0-bs;
    }
    if (segY1[i]>height+bs)
    {
      segY1[i]=0-bs;
    }
    if (segY1[i]<0-bs)
    {
      segY1[i]=height+bs;
    }
  }
}
void movet()//moves the lightcycles in the current direction and leaves a trail behind
{
  for (int i = numSegs-1; i > 0; i--) {
    segX[i] = segX[i-1];                 // each segment takes the coordinates of the previous one
    segY[i] = segY[i-1];                 // the first segment takes the coordinates of the lightcycle
  }
  segX[0] = segX[0] + dirX;              // the lightcycle moves one step in the current direction
  segY[0] = segY[0] + dirY;   
  for (int i = numSegs1-1; i > 0; i--) { 
    segX1[i] = segX1[i-1];               
    segY1[i] = segY1[i-1];
  }
  segX1[0] = segX1[0] + dirX1;           
  segY1[0] = segY1[0] + dirY1;
}