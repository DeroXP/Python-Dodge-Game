local love = require("love")
local random = math.random

-- Set up the game window
local WIDTH = 600
local HEIGHT = 600
function love.conf(t)
    t.window.width = WIDTH
    t.window.height = HEIGHT
    t.window.title = "Dodger Game"
end

-- Set up the player
local player_width = 50
local player_height = 50
local player_x = WIDTH // 2 - player_width // 2
local player_y = HEIGHT - player_height - 10
local player_speed = 0.7

-- Set up the enemy
local enemy_width = 50
local enemy_height = 50
local enemy_x = random(0, WIDTH - enemy_width)
local enemy_y = -enemy_height
local enemy_speed = 0.5

-- Set up the score
local score = 0
local score_font = love.graphics.newFont(50)

-- Define the game loop
function love.update(dt)
    -- Move the player
    if love.keyboard.isDown("left") and player_x > 0 then
        player_x = player_x - player_speed
    end
    if love.keyboard.isDown("right") and player_x < WIDTH - player_width then
        player_x = player_x + player_speed
    end

    -- Move the enemy
    enemy_y = enemy_y + enemy_speed
    if enemy_y > HEIGHT then
        enemy_x = random(0, WIDTH - enemy_width)
        enemy_y = -enemy_height
        score = score + 1
    end

    -- Check for collisions
    local player_rect = {x = player_x, y = player_y, w = player_width, h = player_height}
    local enemy_rect = {x = enemy_x, y = enemy_y, w = enemy_width, h = enemy_height}
    if CheckCollision(player_rect, enemy_rect) then
        score = 0
    end
end

function love.draw()
    -- Draw the game objects
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", player_x, player_y, player_width, player_height)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", enemy_x, enemy_y, enemy_width, enemy_height)
    love.graphics.setFont(score_font)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(tostring(score), 10, 10)
end

function CheckCollision(rect1, rect2)
    return rect1.x < rect2.x + rect2.w and
           rect2.x < rect1.x + rect1.w and
           rect1.y < rect2.y + rect2.h and
           rect2.y < rect1.y + rect1.h
end