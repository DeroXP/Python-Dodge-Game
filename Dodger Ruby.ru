require 'ruby2d'
require 'securerandom'

# Set up the game window
set title: "Dodger Game"
set background: 'black'
set width: 600
set height: 600

# Set up the player
player_width = 50
player_height = 50
player_x = Window.width / 2 - player_width / 2
player_y = Window.height - player_height - 10
player_speed = 5

# Set up the enemy
enemy_width = 50
enemy_height = 50
enemy_x = SecureRandom.random_number(Window.width - enemy_width)
enemy_y = -enemy_height
enemy_speed = 3

# Set up the score
score = 0
score_text = Text.new(score.to_s, x: 10, y: 10, size: 50, color: 'white')

# Define the game loop
update do
  # Move the player
  if key_down?('left') && player_x > 0
    player_x -= player_speed
  end
  if key_down?('right') && player_x < Window.width - player_width
    player_x += player_speed
  end

  # Move the enemy
  enemy_y += enemy_speed
  if enemy_y > Window.height
    enemy_x = SecureRandom.random_number(Window.width - enemy_width)
    enemy_y = -enemy_height
    score += 1
    score_text.text = score.to_s
  end

  # Check for collisions
  player_rect = Rectangle.new(x: player_x, y: player_y, width: player_width, height: player_height)
  enemy_rect = Rectangle.new(x: enemy_x, y: enemy_y, width: enemy_width, height: enemy_height)
  if player_rect.intersect?(enemy_rect)
    score = 0
    score_text.text = score.to_s
  end

  # Draw the game objects
  clear
  player_rect.draw
  enemy_rect.draw(color: 'red')
  score_text.draw
end

# Run the game
show