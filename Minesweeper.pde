import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS=10;
private final static int NUM_COLS=10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r=0; r<buttons.length; r++)
    {
      for (int c=0; c<buttons[r].length; c++)
      {
        buttons[r][c]= new MSButton(r,c);
      }
    }
    
    
    setMines();
    
}
public void setMines()
{
      for (int i=0; i<20; i++)
      {
      int r1 = (int)(Math.random()*NUM_ROWS);
      int r2=(int)(Math.random()*NUM_ROWS);
      
      if(!mines.contains(buttons[r1][r2]))
      {
        mines.add(buttons[r1][r2]);
      }
      }
      
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayLosingMessage();
       
      
}
public boolean isWon()
{
       for(int i=0;i<NUM_ROWS;i++){
        for(int j=0;j<NUM_COLS;j++){
            if(!buttons[i][j].isClicked()==true&&!mines.contains(buttons[i][j])){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
     String lose= "you lose";
  for(int i = 1; i < NUM_COLS; i++){
        buttons[NUM_COLS/2][i].setLabel(lose.substring(i-1,i));
  }
  
  
   
}
public void displayWinningMessage()
{
    
   String win= "you win";
   if (isWon())
  for(int i = 1; i < NUM_COLS; i++){
        buttons[NUM_COLS/2][i].setLabel(win.substring(i-1,i));
  }
}
public boolean isValid(int r, int c)
{
 
  if (r>=0 && c>=0 && c<NUM_COLS && r<NUM_ROWS)
  {
    return true;
  }
  return false;
   
}
public int countMines(int row, int col)
{
      int numMines = 0;
        if(isValid(row-1, col-1))
        {
            if(mines.contains(buttons[row-1][col-1]))
                numMines++;
        }
        if(isValid(row-1, col))
        {
            if(mines.contains(buttons[row-1][col]))
                numMines++;
        }
        if(isValid(row-1, col+1))
        {
            if(mines.contains(buttons[row-1][col+1]))
                numMines++;
        }
        if(isValid(row, col-1))
        {
            if(mines.contains(buttons[row][col-1]))
                numMines++;
        }
        if(isValid(row, col+1))
        {
            if(mines.contains(buttons[row][col+1]))
                numMines++;
        }
        if(isValid(row+1, col-1))
        {
            if(mines.contains(buttons[row+1][col-1]))
                numMines++;
        }
        if(isValid(row+1, col))
        {
            if(mines.contains(buttons[row+1][col]))
                numMines++;
        }
        if(isValid(row+1, col+1))
        {
            if(mines.contains(buttons[row+1][col+1]))
                numMines++;
        }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked=true;
         if(mouseButton == RIGHT)
        {
          flagged=!flagged;
          if (flagged == false)
          clicked= false;
        }
          
        else if(mines.contains(this))
        {
                displayLosingMessage();
        }
            else if (countMines(myRow, myCol)>0)
            {
          
            setLabel(countMines(myRow, myCol));
        }
        
        else
        {
            if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].isFlagged())
            buttons[myRow][myCol-1].mousePressed();
          if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].isFlagged())
            buttons[myRow][myCol+1].mousePressed();
          if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].isFlagged())
            buttons[myRow-1][myCol].mousePressed();
          if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].isFlagged())
            buttons[myRow+1][myCol].mousePressed();
          if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].isFlagged())
            buttons[myRow-1][myCol-1].mousePressed();
          if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].isFlagged())
            buttons[myRow+1][myCol+1].mousePressed();
          if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].isFlagged())
            buttons[myRow-1][myCol+1].mousePressed();
          if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].isFlagged())
            buttons[myRow+1][myCol-1].mousePressed();
        }
         
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
         fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
      return clicked;
    }
}
