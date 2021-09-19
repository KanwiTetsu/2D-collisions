player player1 = new player();
float wall_height, wall_width;

void setup()
{
    size(1000,1000,P2D);
    player1.acceleration[0] = 0;
    player1.acceleration[1] = 0;

    //player1.position[0] = (width/2);
    //player1.position[1] = (height/2);

    player1.position[0] = 100;
    player1.position[1] = 900;

    player1.direction[0] = 0;
    player1.direction[1] = 0;

    player1.DEBUG_INFORMATION = false;

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
                shape_temp(float(j),float(i));          
            }
        }
    }

    fill(125);
    text(" VELOCITY : x: " + ceil(player1.velocity[0]) + " ,y: " + ceil(player1.velocity[1]), 10, 10);
    text(" POSITION : x: " + ceil(player1.position[0]) + " ,y: " + ceil(player1.position[1]), 10 ,20);
    text(" FPS: " + ceil(frameRate), 10, 30);

    text(" up: " + player1.neighbors[0], 10, 60);
    text(" left: " + player1.neighbors[1], 10, 70);
    text(" down: " + player1.neighbors[2], 10, 80);
    text(" right: " + player1.neighbors[3], 10, 90);

    text(" up distance: " + player1.distances[0], 10, 100);
    text(" down distance: " + player1.distances[2], 10, 110);
    text(" left distance: " + player1.distances[1], 10, 120);
    text(" right distance: " + player1.distances[3], 10, 130);
    

    player1.display(0); 

    println(player1.direction[1]);
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