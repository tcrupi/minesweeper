# minesweeper
Made in Java using Processing.

#########################
# Setup and How to Play #
#########################

- Set the number of rows and columns you want to play with.
  - By default, the default constructor sets up a 10x10 grid.
  - To change the number of row and columns, in the Minesweeper tab, change
    the following line:

        mf = new MineField(rows,cols);

  - where rows is replaced with the number of rows you want and cols is
    replaced with the number of columns you want.The game does not allow you to
    exceed a 20x20 grid.

- Run the program.

- To start the game, click start. This will start the timer, so you can begin
  playing.
  - If you try to click start at any point during game time, you will get cheater
    message (you obviously can't restart the timer mid-game, it'd be very uncool).

- Play some Minesweeper!
  - This Minesweeper game plays very much like the original.
  - To flag a box, right click on a cell. You can toggle the flag on and off
    this way.
  - To expose a cell, left click on the cell. If a cell is flagged you can not
    expose the cell, you must first remove the flag to the expose it.
  - If you click on a mine, the game ends and all the mines are exposed. Click
    on the reset button to play again!
  - If all non mines were were found, you won! Click on the rest button to play
    again!
