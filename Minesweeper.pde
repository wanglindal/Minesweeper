

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    //declare and initialize buttons
    for(int row = 0; row < NUM_ROWS; row++){
        for(int col = 0; col < NUM_COLS; col++){
            buttons[row][col] = new MSButton(row,col);
        }
    }
    setBombs();
}
public void setBombs()
{
    for(int i = 0; i < 40; i++) {
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
        }
    }

}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int row = 0; row < NUM_ROWS; row++){
        for(int col = 0; col < NUM_COLS; col++){
            if(!bombs.contains(buttons[row][col]) && !buttons[row][col].isClicked()){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c].setLabel("L");
        }
    }
}
public void displayWinningMessage()
{
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c].setLabel("W");
        }
    }
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

    public void mousePressed()
    {
        if(mouseButton == LEFT){
            clicked = true;
        }
        if(mouseButton == RIGHT){
            marked = !marked;
        }
        else if(bombs.contains(this)){
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0){
            label = "" + countBombs(r,c);
        }
        else {
            for(int a = -1; a<2; a++){
                for(int b = -1; b<2; b++){
                    if(isValid(r+a,c+b)){
                        if(buttons[r+a][c+b].isClicked() == false){
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
        return (r<NUM_ROWS && r>=0) && (c<NUM_COLS && c>=0);
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int r = -1; r < 2; r++){
            for(int c = -1; c < 2; c++){
                if(isValid(row+r,col+c) && bombs.contains(buttons[row+r][col+c])){
                    numBombs++;
                }
            }
        }
        return numBombs;
    }
}



