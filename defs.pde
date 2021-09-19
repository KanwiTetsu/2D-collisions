int[][] walls_original = {   {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                             {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}   };
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

    // 1 = up, 2 = left, 3 = down, 4 = right
    PVector[] corners = new PVector[4];
    PVector[] corners_position = new PVector[4];
    float[][][] VERTEX_NEIGHBORS = new float[4][2][2];

    void PressCheck_ACCELERATION(char KEY, int acceleration_INDEX, int sign)
    {
        if (key == KEY)
        {
            acceleration[acceleration_INDEX] += const_acceleration * sign;
        }
    }

    void PressCheck_ACCELERATION_COMPLETE(int sign)
    {
        PressCheck_ACCELERATION('w',1, -1*sign);
        PressCheck_ACCELERATION('a',0, -1*sign);
        PressCheck_ACCELERATION('s',1,  1*sign);
        PressCheck_ACCELERATION('d',0,  1*sign);
    }

    void update()
    {

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

        // UPDATING VELOCITY BY ACCELERATION
        velocity[0] += acceleration[0];
        velocity[1] += acceleration[1];

        //UPDATING POSITION BY VELOCITY
        position[0] += velocity[0];
        position[1] += velocity[1];

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
        fill(177, 3, 252, 50);

        for(int i = 0; i<4; i++){beginShape();
        vertex((wall_height* corners_position[i].x)    , wall_width*(corners_position[i].y+1));
        vertex((wall_height* corners_position[i].x)    , wall_width* corners_position[i].y    );
        vertex((wall_height*(corners_position[i].x+1)) , wall_width* corners_position[i].y    );
        vertex((wall_height*(corners_position[i].x+1)) , wall_width*(corners_position[i].y+1));
        endShape(); }

    }

}
