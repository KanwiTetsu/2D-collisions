int[][] walls_original = {   {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
                             {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, };
int[][] walls = walls_original;
final float const_acceleration = 1;
final float const_decceleration = 0.9;
final float const_player_size = 50;

public class player
{
    // acceleration[1] for x values and acceleration[2] for y values
    float[] acceleration = new float[2];
    float[] velocity = new float[2];
    float[] position = new float[2];
    boolean DEBUG_INFORMATION = true;
    float[] distances = new float[4];
    int[] direction = new int[2];
    boolean[] update = new boolean[2];

    // 0 = up, 1 = left, 2 = down, 3 = right
    PVector[] corners = new PVector[4];
    PVector[] corners_position = new PVector[4];
    PVector[][] VERTEX_NEIGHBORS = new PVector[4][2];
    int[] neighbors = new int[4];

    void PressCheck_ACCELERATION(char KEY, int acceleration_INDEX, int sign, int DIR_INDEX, int DIR_SIGN)
    {
        if(key == KEY)
        {
            acceleration[acceleration_INDEX] += const_acceleration * sign;
            direction[DIR_INDEX] += 1*DIR_SIGN;
        }
    }

    void PressCheck_ACCELERATION_COMPLETE(int sign)
    {
        PressCheck_ACCELERATION('w',1, -1*sign, 1, 1*sign);
        PressCheck_ACCELERATION('a',0, -1*sign, 0,-1*sign);
        PressCheck_ACCELERATION('s',1,  1*sign, 1,-1*sign);
        PressCheck_ACCELERATION('d',0,  1*sign, 0, 1*sign);
    }

    //Defining the corner neighbors
    // 0 = down left, 1 = up left, 2 = up right, 3 = down right
    // 0 = x axis, 1 = y axis
    void GET_NEIGHBORS_X(int index1, int index2, int index3, int sign)
        {
            VERTEX_NEIGHBORS[index1][index2] = new PVector(corners_position[index3].x + (1*sign), corners_position[index3].y);
        }     
    void GET_NEIGHBORS_Y(int index1,int index2,int index3,int sign)
        {
            VERTEX_NEIGHBORS[index1][index2] = new PVector(corners_position[index3].x, corners_position[index3].y + (1*sign));
        }  
    
    void CHECK_NEIGHBORS_X(int i1, int i2, int i3, int i4, int i5)
    {

        /*fill(147, 52, 235, 50);
        noStroke();
        shape_temp(int(VERTEX_NEIGHBORS[i1][i2].x), int(VERTEX_NEIGHBORS[i1][i2].y));

        fill(235, 52, 217, 50);
        shape_temp(int(VERTEX_NEIGHBORS[i3][i4].x), int(VERTEX_NEIGHBORS[i3][i4].y));*/

        if(VERTEX_NEIGHBORS[i1][i2].y >= 0 && VERTEX_NEIGHBORS[i1][i2].x >= 0 && VERTEX_NEIGHBORS[i3][i4].y >= 0 && VERTEX_NEIGHBORS[i3][i4].x >= 0
        && VERTEX_NEIGHBORS[i1][i2].y <= 19 && VERTEX_NEIGHBORS[i1][i2].x <= 19 && VERTEX_NEIGHBORS[i3][i4].y <= 19 && VERTEX_NEIGHBORS[i3][i4].x <= 19)
        {if(walls[int(VERTEX_NEIGHBORS[i1][i2].y)][int(VERTEX_NEIGHBORS[i1][i2].x)] == 1 
        || walls[int(VERTEX_NEIGHBORS[i3][i4].y)][int(VERTEX_NEIGHBORS[i3][i4].x)] == 1) 
        {
            neighbors[i5]=1;
        }else 
        {
            neighbors[i5]=0;
        }}
    }

    void POSITION_COLLISIONS(int dist_index, int axis_index,int neighbors_index, int DIRECTION_SIGN, int DIRECTION_)
        {
            if (distances[dist_index] < abs(velocity[axis_index])) 
                {
                    if (distances[dist_index] != height+1 && neighbors[neighbors_index] == 1)
                    {
                        if (distances[dist_index] < 10 && direction[axis_index] == DIRECTION_)
                        {
                            velocity[axis_index] = 0;
                            update[1]=false;
                        }
                    }
                }
                else 
                {
                    if(direction[axis_index] == DIRECTION_)
                    {
                    position[axis_index] += velocity[axis_index];
                    }
                }
        }

    void GET_DIST_Y(int DIR_INDEX_, int i1, int i2, int CORNER_INDEX, float offset_sign)
    {
        if (neighbors[DIR_INDEX_] == 1) 
        {
         distances[DIR_INDEX_] = abs((corners[CORNER_INDEX].y ) - (wall_height*(VERTEX_NEIGHBORS[i1][i2].y+(1*offset_sign)))) ;
        }
        else 
        {
            distances[DIR_INDEX_] = height+1;
        }
    }

    void GET_DIST_X(int DIR_INDEX_, int i1, int i2, int CORNER_INDEX, float offset_sign)
    {
        if (neighbors[DIR_INDEX_] == 1) 
        {
         distances[DIR_INDEX_] = abs((corners[CORNER_INDEX].x) - (wall_height*(VERTEX_NEIGHBORS[i1][i2].x+(1*offset_sign))));
        }
        else 
        {
            distances[DIR_INDEX_] = height+1;
        }
    }

    void update()
    {

        update[0] = true;
        update[1] = true;

        float w_wl = width/walls.length;
        float h_hl = height/walls[0].length;

        corners[0] = new PVector(position[0] - const_player_size/2   ,   position[1] + const_player_size/2);
        corners[1] = new PVector(position[0] - const_player_size/2   ,   position[1] - const_player_size/2);
        corners[2] = new PVector(position[0] + const_player_size/2   ,   position[1] - const_player_size/2);
        corners[3] = new PVector(position[0] + const_player_size/2   ,   position[1] + const_player_size/2);

        //Defining the corner position in terms of the walls
        // 0 = down left, 1 = up left, 2 = up right, 3 = down right
        for(int i = 0; i < 4; i++)
        {
            corners_position[i] = new PVector(  (floor(corners[i].x /  w_wl)) ,    (floor(corners[i].y /   h_hl)) );
        }

        //GET NEIGHBOR POSITIONS  

        GET_NEIGHBORS_X(0, 0, 0, -1);
        GET_NEIGHBORS_X(1, 0, 1, -1);
        GET_NEIGHBORS_X(2, 0, 2,  1);
        GET_NEIGHBORS_X(3, 0, 3,  1);

        GET_NEIGHBORS_Y(0, 1, 0,  1);
        GET_NEIGHBORS_Y(1, 1, 1, -1);
        GET_NEIGHBORS_Y(2, 1, 2, -1);
        GET_NEIGHBORS_Y(3, 1, 3,  1);

        //define if each direction has a nearby neighbor
        CHECK_NEIGHBORS_X(1,1,2,1,0);
        CHECK_NEIGHBORS_X(1,0,0,0,1);
        CHECK_NEIGHBORS_X(0,1,3,1,2);
        CHECK_NEIGHBORS_X(2,0,3,0,3);

        //defining the distance from the cube to the wall
        GET_DIST_Y(0, 1, 1, 1, 1);
        GET_DIST_Y(2, 0, 1, 0, 0);

        GET_DIST_X(1, 2, 0, 0, -2);
        GET_DIST_X(3, 3, 0, 2, 0);

        // UPDATING VELOCITY BY ACCELERATION
        velocity[0] += acceleration[0];
        velocity[1] += acceleration[1];

        //UPDATING POSITION BY VELOCITY
        POSITION_COLLISIONS(0, 1, 0, 1, 1);
        POSITION_COLLISIONS(2, 1, 2, -1,-1);

        POSITION_COLLISIONS(1, 0, 1, 1,-1);
        POSITION_COLLISIONS(3, 0, 3, 1, 1);

        if(direction[1] == 0 && distances[0]> 5 && distances[2] > 5)
                {
                    position[1] += velocity[1];
                }

        if(direction[0] == 0 && distances[1] > 5 && distances[3] > 5)
                {
                    position[0] += velocity[0];
                }

        //UPDATING VELOCITY SO IT ALWAYS SLOWS DOWN
        velocity[0] *= const_decceleration;
        velocity[1] *= const_decceleration;
    }

    void display(color SQUARE_COLOR)
    {
        fill(SQUARE_COLOR);
        noStroke();
        beginShape();
        vertex(corners[0].x , corners[0].y);
        vertex(corners[1].x , corners[1].y);
        vertex(corners[2].x , corners[2].y);
        vertex(corners[3].x , corners[3].y);
        endShape();
        //square(position[0], position[1], const_player_size);
        
        if(DEBUG_INFORMATION)
        {        fill(177, 3, 252, 50);

        for(int i = 0; i<4; i++)
        {
            shape_temp(corners_position[i].x, corners_position[i].y);
        }

        fill(52, 235, 225, 50);

        for(int i = 0; i<4; i++)
        {
            for(int j = 0; j<2; j++)
            {
                shape_temp(VERTEX_NEIGHBORS[i][j].x,VERTEX_NEIGHBORS[i][j].y);
            }
        }
        }

    }
}

void shape_temp(float x,float y)
{
    beginShape();
    vertex((wall_height* x)    , wall_width*(y+1));
    vertex((wall_height* x)    , wall_width* y    );
    vertex((wall_height*(x+1)) , wall_width* y    );
    vertex((wall_height*(x+1)) , wall_width*(y+1));
    endShape();
}
