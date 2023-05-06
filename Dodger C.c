#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <conio.h>
#include <windows.h>

#define WIDTH 600
#define HEIGHT 600

void drawPlayer(int x, int y);
void drawEnemy(int x, int y);
void drawScore(int score);
void clearScreen();

int main() {
    srand(time(NULL));

    int player_width = 50;
    int player_height = 50;
    int player_x = WIDTH / 2 - player_width / 2;
    int player_y = HEIGHT - player_height - 10;
    float player_speed = 0.7;

    int enemy_width = 50;
    int enemy_height = 50;
    int enemy_x = rand() % (WIDTH - enemy_width);
    int enemy_y = -enemy_height;
    float enemy_speed = 0.5;

    int score = 0;

    while (1) {
        // Handle events
        if (kbhit()) {
            int key = getch();
            if (key == 'a' && player_x > 0) {
                player_x -= player_speed;
            }
            if (key == 'd' && player_x < WIDTH - player_width) {
                player_x += player_speed;
            }
        }

        // Move the enemy
        enemy_y += enemy_speed;
        if (enemy_y > HEIGHT) {
            enemy_x = rand() % (WIDTH - enemy_width);
            enemy_y = -enemy_height;
            score++;
        }

        // Check for collisions
        if (player_x < enemy_x + enemy_width &&
            player_x + player_width > enemy_x &&
            player_y < enemy_y + enemy_height &&
            player_y + player_height > enemy_y) {
            score = 0;
        }

        // Draw the game objects
        clearScreen();
        drawPlayer(player_x, player_y);
        drawEnemy(enemy_x, enemy_y);
        drawScore(score);

        Sleep(10);
    }

    return 0;
}

void drawPlayer(int x, int y) {
    for (int i = 0; i < 50; i++) {
        for (int j = 0; j < 50; j++) {
            if (i == 0 || i == 49 || j == 0 || j == 49) {
                printf("*");
            } else if (i >= y && i < y + 50 && j >= x && j < x + 50) {
                printf("#");
            } else {
                printf(" ");
            }
        }
        printf("\n");
    }
}

void drawEnemy(int x, int y) {
    for (int i = 0; i < 50; i++) {
        for (int j = 0; j < 50; j++) {
            if (i == 0 || i == 49 || j == 0 || j == 49) {
                printf("*");
            } else if (i >= y && i < y + 50 && j >= x && j < x + 50) {
                printf("@");
            } else {
                printf(" ");
            }
        }
        printf("\n");
    }
}

void drawScore(int score) {
    printf("Score: %d\n", score);
}

void clearScreen() {
    system("cls");
}