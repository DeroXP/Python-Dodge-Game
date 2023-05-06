#include <iostream>
#include <ctime>
#include <cstdlib>
#include <conio.h>
#include <windows.h>

// Set up the game window
const int WIDTH = 600;
const int HEIGHT = 600;

// Set up the player
const int PLAYER_WIDTH = 50;
const int PLAYER_HEIGHT = 50;
int player_x = WIDTH / 2 - PLAYER_WIDTH / 2;
int player_y = HEIGHT - PLAYER_HEIGHT - 10;
const double PLAYER_SPEED = 0.7;

// Set up the enemy
const int ENEMY_WIDTH = 50;
const int ENEMY_HEIGHT = 50;
int enemy_x = rand() % (WIDTH - ENEMY_WIDTH);
int enemy_y = -ENEMY_HEIGHT;
const double ENEMY_SPEED = 0.5;

// Set up the score
int score = 0;

// Define the game loop
void run_game()
{
    while (true)
    {
        // Handle player input
        if (_kbhit())
        {
            char ch = _getch();
            if (ch == 'a' && player_x > 0)
            {
                player_x -= PLAYER_SPEED;
            }
            if (ch == 'd' && player_x < WIDTH - PLAYER_WIDTH)
            {
                player_x += PLAYER_SPEED;
            }
        }

        // Move the enemy
        enemy_y += ENEMY_SPEED;
        if (enemy_y > HEIGHT)
        {
            enemy_x = rand() % (WIDTH - ENEMY_WIDTH);
            enemy_y = -ENEMY_HEIGHT;
            score += 1;
        }

        // Check for collisions
        if (player_x < enemy_x + ENEMY_WIDTH &&
            player_x + PLAYER_WIDTH > enemy_x &&
            player_y < enemy_y + ENEMY_HEIGHT &&
            player_y + PLAYER_HEIGHT > enemy_y)
        {
            score = 0;
        }

        // Draw the game objects
        system("cls");
        for (int i = 0; i < WIDTH + 2; i++)
        {
            std::cout << "#";
        }
        std::cout << std::endl;
        for (int i = 0; i < HEIGHT; i++)
        {
            std::cout << "#";
            for (int j = 0; j < WIDTH; j++)
            {
                if (i == player_y && j == player_x)
                {
                    std::cout << "P";
                }
                else if (i == enemy_y && j == enemy_x)
                {
                    std::cout << "E";
                }
                else
                {
                    std::cout << " ";
                }
            }
            std::cout << "#" << std::endl;
        }
        for (int i = 0; i < WIDTH + 2; i++)
        {
            std::cout << "#";
        }
        std::cout << std::endl << "Score: " << score << std::endl;

        // Sleep to control the frame rate
        Sleep(10);
    }
}

int main()
{
    // Seed the random number generator
    srand(time(NULL));

    // Run the game loop
    run_game();

    return 0;
}
