int[][] walls = {   {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}    };
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

          /*    -+  ++
                --  +-  */   

        corners[0] = new PVector(position[0] - const_player_size/2   ,   position[1] + const_player_size/2);
        corners[1] = new PVector(position[0] - const_player_size/2   ,   position[1] - const_player_size/2);
        corners[2] = new PVector(position[0] + const_player_size/2   ,   position[1] - const_player_size/2);
        corners[3] = new PVector(position[0] + const_player_size/2   ,   position[1] + const_player_size/2);

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
        beginShape();
        vertex(corners[0].x , corners[0].y);
        vertex(corners[1].x , corners[1].y);
        vertex(corners[2].x , corners[2].y);
        vertex(corners[3].x , corners[3].y);
        endShape();
        //square(position[0], position[1], const_player_size);
        fill(SQUARE_COLOR);
    }

}
