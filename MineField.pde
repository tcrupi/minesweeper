class MineField {

  // number of rows and columns within game
  private int rows;
  private int cols;

  // change in x and y between grid lines
  private int dx;
  private int dy;

  // grid offset to accomodate time & score
  private final int offset = 100;

  // field used for random mine generation
  private final float p = .2;

  // a 2D array indicating where mines are
  private boolean[][] mines;

  // a 2D array indicating which cells are clicked
  private boolean[][] cellClicked;

  // a 2D array indicating which cells are flagged
  private boolean[][] cellFlagged;

  // a 2D array indicating which cells have been
  // checked for surrounding 0's
  private boolean[][] checkedForZeros;

  // default constructor
  public MineField(int rows, int cols) {
    // mine field should be a nxn grid
    if (rows != cols) {
      fill(255,0,0);
      textAlign(CENTER, CENTER);
      text("Number of rows and columns must be equal!", width/2, height/2);
      return;
    }

    // mine field cannot be greater than 20x20 grid
    else if (rows < 4 || rows > 20) {
      fill(255,0,0);
      textAlign(CENTER, CENTER);
      text("Grid cannot be larger than 20x20", width/2, height/2 - 25);
      text("or smaller than 4x4", width/2, height/2);
      return;
    }

    // initialize fields
    this.rows = rows;
    this.cols = cols;
    this.dx = width/cols;
    this.dy = (height-offset)/rows;

    // initialize the helper arrays
    mines = new boolean[rows][cols];
    cellClicked = new boolean[rows][cols];
    cellFlagged = new boolean[rows][cols];
    checkedForZeros = new boolean[rows][cols];

  } // end of MineField constructor

  public void addMines() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j <cols; j++) {

        // randomly generate a # from 0 to 1, and if that # is less
        // than 0.2, true gets assigned to the cell, indicating a mine
        mines[i][j] = (random(0,1) < p);

        // mines are not revealed initially, so set to false
        cellClicked[i][j]= false;
      }
    }

  } // end of addMines

  public void drawBoard() {
    // draw vertical lines
    for (int i = 0; i < width; i += dx) {
      line(i, offset, i, height);
    }

    // draw horizontal lines
    for (int i = offset; i < height; i += dy) {
      line(0, i, width, i);
    }

    // check if cell was clicked
    for (int i=0; i < rows; i++) {
      for (int j=0; j < cols; j++) {

        // cell was flagged
        if (cellFlagged[i][j]) {

          // fill cell with yellow
          fill(255,255,0);
          rect(j*dx, i*dy+offset, dx, dy);
        }

        // cell was clicked
        if (cellClicked[i][j]) {

          // fill cell with black
          fill(0);
          rect(j*dx, i*dy+offset, dx, dy);

          // write the number of adjacent mines in cell
          int adj = adjacentMines(i,j);
          fill(0,255,0);
          text(adj, (j*dx + dx/2), (i*dy + dy/2) + offset);
        }

      }
    }

  } // end of drawBoard

  public boolean allNonMinesFound() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        // cell should have either a mine or be clicked
        // if the cell has both no mine and not been clicked
        // all non mines have not been found
        if (cellClicked[i][j] == false && mines[i][j] == false) {
          return false;
        }
      }
    }
    return true;

  } // end of allNonMinesFound

  public int adjacentMines(int r, int c) {
    int numMines = 0;

    // check number of mines in adjacent cells
    for (int row = r-1; row <= r+1; row++) {
      // check for out of bounds row value
      if (row < 0 || row >= rows) continue;

      for (int col = c-1; col <= c+1; col++) {
        // check for out of bounds col value
        if (col < 0 || col >= cols) continue;

        // mine exists in the row & col, increase # of mines
        if (mines[row][col]) numMines++;
      }
    }
    return numMines;

  } // end of adjacentMines

  public void flagCell(int x, int y) {
    int row, col;
    row = (y - offset) / dy;
    col = x / dx;

    // this switches the flag on/off
    if (cellFlagged[row][col]) {
      cellFlagged[row][col] = false;
    }
    else {
      cellFlagged[row][col] = true;
    }
  } // end of flagCell

  public void gameOver() {
    // stop executing draw
    noLoop();

    // show all mines in red
    for (int i=0; i < rows; i++) {
      for (int j=0; j < cols; j++) {

        // mine exists
        if (mines[i][j]) {

          // fill cell with red
          fill(255,0,0);
          rect(j*dx, i*dy+offset, dx, dy);
        }
      }
    }
    // display game over
    textSize(25);
    textAlign(CENTER);
    fill(255,0,0);
    text(" - GAME OVER  -", width/2, height/5+10);
  } // end of gameOver

  public void youWon() {
    // stop executing draw
    noLoop();

    // display you won
    textSize(25);
    fill(255,0,0);
    textAlign(CENTER);
    text(" - YOU WON - ", width/2, height/5+10);
  } // end of youWon

  public void reset() {
    // display initial setup
    setup();
  }

  public void revealSafeCells(int r, int c) {
    // this function is called when a cell has zero adjacent
    // mines. it checks if the adjacent cells to the
    // original cell also has zero adjacent mines.

    for (int row = r-1; row <= r+1; row++) {
      // check for out of bounds row value
      if (row < 0 || row >= rows) continue;

      for (int col = c-1; col <= c+1; col++) {
        // check for out of bounds col value
        if (col < 0 || col >= cols) continue;

        // adjacent cells are marked as checked
        cellClicked[row][col] = true;

        // one of the adjacent cells have zero adjacent mines
        if (adjacentMines(row, col) == 0) {

          // verify the cell has not been checked already
          if (!checkedForZeros[row][col]) {

            // now mark that the cell as checked
            checkedForZeros[row][col] = true;

            // recursively check for zero adjacent mines
            revealSafeCells(row, col);
          }
        }
      }
    }
  } // end of revealSafeCells

  public void revealCell(int x, int y) {
    int adj, row, col;
    row = (y - offset) / dy;
    col = x / dx;

    // cell is flagged, do not reveal
    if (cellFlagged[row][col]) return;

    // mark the cell as clicked
    cellClicked[row][col] = true;

    // the cell clicked has a mine
    if (mines[row][col]) {

      // display game over, end game
      fill(255,0,0);
      rect(col*dx, row*dy+offset, dx, dy);
      gameOver();
     }

    else {
      // get the number of adjacent mines
      adj = adjacentMines(row, col);
      // cell has zero adjacent mines
      if (adj == 0) {
        // find adjacent mines to current cell
        revealSafeCells(row, col);
      }
    }
    if (allNonMinesFound()) {
      youWon();
    }
  } // end of revealCell

} // end of MineField
