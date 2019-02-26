

import de.bezier.guido.*;
public static int NUM_ROWS = 20;
public static int NUM_COLS = 20;
public static int NUM_BOMBS = 50;
private MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    setBombs();
}
public void setBombs()
{
    while (bombs.size() < NUM_BOMBS)
    {
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        MSButton datAss = new MSButton(row, col); 

        if (!bombs.contains(datAss))
        {
            bombs.add(datAss);
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
    //your code here
    return false;
}
public void displayLosingMessage()
{
    System.out.println("die");
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
        if (mouseButton == RIGHT)
        {
            marked = !marked;
        }
        else
        {
            clicked = true;
        }
        if (bombs.contains(this))
        {
            displayLosingMessage();
        }
             else if (countBombs(this.r,this.c)>0)
             {
                setLabel(""+countBombs(this.r,this.c));
             }
                else if (countBombs(this.r,this.c) == 0)
                {
                    for(int x = this.r-1; x <= this.r+1; x++)
                    {
                        for(int y = this.c-1; x<=this.c+1; y++)
                        {
                            if (isValid(x,y) &&  !buttons[x][y].isClicked())
                            {
                                    buttons[x][y].mousePressed();
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
        if (r<=NUM_ROWS && c<NUM_COLS && r >=0 && c>=0)
            {
            return true;
            }
        return false;

    }
    public int countBombs(int row, int col)
    {                
      int z = 0;
        for(int x = row-1; x <= row+1; x++)
            {
                for(int y = col-1; x<=col+1; y++)
                {
                    if (bombs.contains(buttons[x][y]))
                    {
                        z++;
                    }
                }
            }
                  System.out.println("help");
        System.out.println(z);
      return z;

    }
}



