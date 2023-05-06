import sys
import pygame
import random

# Initialize Pygame
pygame.init()

# Set up the game window
WIDTH = 600
HEIGHT = 600
win = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Dodger Game")

# Set up the player
player_width = 50
player_height = 50
player_x = WIDTH // 2 - player_width // 2
player_y = HEIGHT - player_height - 10
player_speed = 0.7

# Set up the enemy
enemy_width = 50
enemy_height = 50
enemy_x = random.randint(0, WIDTH - enemy_width)
enemy_y = -enemy_height
enemy_speed = 0.5

# Set up the score
score = 0
score_font = pygame.font.SysFont("Arial", 50)

# Define the game loop
def run_game():
    global player_x, player_y, score, enemy_x, enemy_y, WIDTH, HEIGHT

    # Run the game loop
    while True:
        # Handle events
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

        # Move the player
        keys = pygame.key.get_pressed()
        if keys[pygame.K_LEFT] and player_x > 0:
            player_x -= player_speed
        if keys[pygame.K_RIGHT] and player_x < WIDTH - player_width:
            player_x += player_speed

        # Move the enemy
        enemy_y += enemy_speed
        if enemy_y > HEIGHT:
            enemy_x = random.randint(0, WIDTH - enemy_width)
            enemy_y = -enemy_height
            score += 1

        # Check for collisions
        player_rect = pygame.Rect(player_x, player_y, player_width, player_height)
        enemy_rect = pygame.Rect(enemy_x, enemy_y, enemy_width, enemy_height)
        if player_rect.colliderect(enemy_rect):
            score = 0

        # Draw the game objects
        win.fill((0, 0, 0))
        pygame.draw.rect(win, (255, 255, 255), (player_x, player_y, player_width, player_height))
        pygame.draw.rect(win, (255, 0, 0), (enemy_x, enemy_y, enemy_width, enemy_height))
        score_text = score_font.render(str(score), True, (255, 255, 255))
        win.blit(score_text, (10, 10))

        # Update the display
        pygame.display.update()

# Set the width and height of the game
WIDTH = 800
HEIGHT = 600

# Resize the game window
win = pygame.display.set_mode((WIDTH, HEIGHT))

# Run the game
run_game()