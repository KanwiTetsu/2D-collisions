player player1 = new player();
float wall_height, wall_width;

void setup()
{
    size(1000,1000,P2D);
    player1.acceleration[0] = 0;
    player1.acceleration[1] = 0;

    player1.position[0] = (width/2);
    player1.position[1] = (height/2);
    frameRate(60);

    wall_height = height/walls[0].length;
    wall_width = width/walls.length;
}

void draw()
{
    background(255);  

    

    stroke(0);
    fill(0);
    player1.update();

    fill(0);

    //--

    stroke(255);

    for(int i = 0; i < walls.length; i++)
    {   for(int j = 0; j < walls[0].length; j++)
        {
            if (walls[i][j] == 1)
            {
                beginShape();
                vertex((wall_height*j)    , wall_width*(i+1));
                vertex((wall_height*j)    , wall_width*i    );
                vertex((wall_height*(j+1)), wall_width*i    );
                vertex((wall_height*(j+1)), wall_width*(i+1));
                endShape();             
            }
        }
    }

    fill(125);
    text(" VELOCITY : x: " + player1.velocity[0] + " ,y: " + player1.velocity[1], 10, 10);
    text(" POSITION : x: " + player1.position[0] + " ,y: " + player1.position[1], 10 ,20);
    text(" FPS: " + frameRate, 10, 30);

    player1.display(0); 

}

//key pressing stuffs

    void keyPressed() 
    {
        player1.PressCheck_ACCELERATION_COMPLETE(1);
    }

    void keyReleased()
    {
        player1.PressCheck_ACCELERATION_COMPLETE(-1);
    }