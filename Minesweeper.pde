MineField mf;
Timer t;

public void setup() {
  size(300,400);

  // create new MineField and add mines to it
  mf = new MineField(10,10);
  mf.addMines();

  // create new timer
  t = new Timer();
 } // end of setup

public void draw() {
  background(220);
  mf.drawBoard();
  t.getTime();
  t.resetTimerButton();
  t.startTimerButton();
} // end of draw

public void mousePressed() {
  if (mouseButton == LEFT) {
    // makes sure mouse is on grid and the game has been started
    if (mouseY > mf.offset && t.timerOn) {
      // reveals the cell on grid
      mf.revealCell(mouseX, mouseY);
    }
    else {
      // makes sure mouse is on reset button
      if (mouseX < (width/2) - 50 && mouseX > (width/2) - 130 &&
          mouseY < 55 && mouseY > 25) {
        // executes draw
        loop();
        // restarts the game
        mf.reset();
      }
      // makes sure mouse in on start button
      if (mouseX < (width/2) + 125 && mouseX > (width/2) + 45 &&
          mouseY < 55 && mouseY > 25) {
        // can't press the start button during game time
        if (t.timerOn) {
          // display warning to cheaters
          t.cheaterWarning();
        }
        // otherwise start the timer
        t.start();
      }
    }
  }
 if (mouseButton == RIGHT) {
   // makes sure the mouse on the grid and the game has been started
   if (mouseY > mf.offset && t.timerOn) {
     // flag the cell
     mf.flagCell(mouseX, mouseY);
   }
 }
} // end of mousePressed
