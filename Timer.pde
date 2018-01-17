class Timer {
  private int startTime;
  private int stopTime;
  private boolean timerOn;
  
  // default constructor
  public Timer() {
    startTime = 0;
    stopTime = 0;
    timerOn = false;
  }
  
  public void start() {
    startTime = millis();
    timerOn = true;
  }
  public int getElapsedTime() {
    int elapsed;

    // get elapsed time if timer is on
    if (timerOn) {
      elapsed = (millis() - startTime);
    }
    // get elapsed time when timer is turned off
    else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  
  public int getSecond() {
    // return conversion of getElapsedTime in seconds
    return (getElapsedTime() / 1000) % 60;
  }
  
  public int getMinute() {
    // return conversion of getElapsedTime in minutes
    return (getElapsedTime() / (1000*60)) % 60;
  }

  public void getTime() {
    // display for timer
    textSize(20);
    fill(0,0,0); 
    textAlign(CENTER, CENTER);
    text(nf(getMinute(), 2)+":"+nf(getSecond(), 2), width/2, height- 0.9*height);
    textSize(13);
  } //end of getTime
  
  public void resetTimerButton() {
    // reset button for timer
    fill(180);
    rect(width/2 - 130, 25, 80, 35);
    fill(0);
    text("RESET", width/2 - 88, 40);
  }
  
  public void startTimerButton() {
    // start button for timer
    fill(180);
    rect(width/2 + 45, 25, 80, 35);
    fill(0);
    text("START", width/2 + 85, 40);
  }
  
  public void cheaterWarning() {
    // stop executing draw
    noLoop();
    
    // display cheater warning
    fill(0);
    rect(0, (height/2)-50, width, height/2);
    textSize(25);
    fill(255,0,0);
    text("DON'T BE A CHEATER,", width/2, height/2);
    text("YOU CAN'T RESTART", width/2, height/2+25);
    text("THE TIME MID-GAME", width/2, height/2+50);
    text("LIKE THAT -.-", width/2, height/2+75);
  } // end of cheaterWarning
    
} // end of Timer