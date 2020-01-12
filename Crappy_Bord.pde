void redrawc() {//main draw for crappy bird
  checkPC();
  checkSC();
  if (!splat.isPlaying()) {
    splat.rewind();
  }
  imageMode(CORNER);
  //background looping
  background1X = background1X - birdSpeed;
  if (background1X <-background1W ) background1X = background1W - birdSpeed;

  background2X = background2X - birdSpeed;
  if (background2X< -background2W) {
    background2X = background2W - birdSpeed;
  }
  imageMode(CORNER);
  image (background1, background1X, background1Y); 
  image (background2, background2X, background1Y);   
  birdY+=VY;
  VY++;
  for (int i=0; i<2; i++) {
    //draws pipes
    image(wall[i], wallX[i], height-(wall[i].height));
    image(walld[i], wallX[i], 0);
    if (birdX==wallX[i]) {
      score++;
      counter=0;
      point.trigger();
    }
    wallX[i]-=birdSpeed;
    if (wallX[i]<0-wall[i].width) {
      wallL[i]=int(random(100, height-250));
      wall[i].resize(150, wallL[i]);
      walld[i].resize(150, height-wallL[i]-200);
      wallX[i]=width+(2);
    }
  }
  image (bird, birdX, birdY);
  fill(0);
  textSize(80);
  textAlign(CENTER);
  text(score, width/2, height-70);
}
void mouseReleased() {//allows only one jump per press
  mouse=true;
}
void checkPC() {//checks collision with the pipes
  ///if the bird hits a pipe, jump boolean turns false
  for (int i=0; i<2; i++) {
    if (birdX>=wallX[i]-(bird.width)&&birdX<=wallX[i]+150) {
      if (birdY<=walld[i].height||birdY>=height-(wall[i].height)-(bird.height)) {
        jump=false;
        hit.trigger();
      }
    }
  }
}
void checkSC() {//checks collision with the screen boundaries
  if (birdY<=0||birdY>=height) {
    jump=false;
    splat.play();
    birdSpeed=0;
    intro=11;
  }
}