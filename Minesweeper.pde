

import de.bezier.guido.*;
private int NUM_ROWS = 20;
private int NUM_COLS = 20; //Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);    
    // make the manager
    Interactive.make( this );
    
   buttons = new MSButton[NUM_ROWS][NUM_COLS]; 
   for(int r = 0; r< NUM_ROWS ; r++)
   { for(int c=0 ; c< NUM_COLS ; c++)
    { buttons[r][c] = new MSButton(r,c) ; }
   }//your code to declare and initialize buttons goes here
    
    setBombs();
}
public void setBombs()
{
    for(int b=0 ; b<35; b++)
    {
   int row= (int) (Math.random()*NUM_ROWS);
   int col = (int)(Math.random()*NUM_COLS);
   if(!bombs.contains(buttons[row][col]))
   { 
    bombs.add(buttons[row][col]) ;
   } 
   }//your code
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
       height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed)
        { marked= !marked; }
        else if(bombs.contains(this))
        { 
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0)
        {
            label = "" + countBombs(r,c);
        }
        else 
        {
            for(int a = -1; a<2; a++)
            {
                for(int b = -1; b<2; b++)
                {
                    if(isValid(r+a,c+b))
                    {
                        if(buttons[r+a][c+b].isClicked() == false)
                        {
                            buttons[r+a][c+b].mousePressed();
                        }
                    }
                }
            }
        }
    }
   

 public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r>=0 && c>=0 && r<=NUM_ROWS && c<=NUM_COLS  )
            { return true;}
        else  {
           return false; 
        }
        
    }
    public int countBombs(int row, int col)
    {
        int numsBombs = 0;
        //your code here
        if(isValid(row-1,col)&& bombs.contains(buttons[row-1][col]))//top
            { numsBombs++;}
       if(isValid(row-1,col+1)&& bombs.contains(buttons[row-1][col+1]))//top,right
            { numsBombs++;}
        if(isValid(row,col+1)&& bombs.contains(buttons[row][col+1]))//right
            { numsBombs++;}
        if(isValid(row+1,col+1)&& bombs.contains(buttons[row+1][col+1]))//right, bottom
            { numsBombs++;}
        if(isValid(row+1,col)&& bombs.contains(buttons[row+1][col]))//bottom
            { numsBombs++;}
       if(isValid(row+1, col-1)&& bombs.contains(buttons[row+1][col-1]))//bottom, left
           { numsBombs++;}
        if(isValid(row ,  col-1)&& bombs.contains(buttons[row][col-1]))// left
           { numsBombs++;}
        if(isValid(row-1, col-1)&& bombs.contains(buttons[row-1][col-1]))//top, left
           { numsBombs++;}
        return numsBombs;
    }

}
