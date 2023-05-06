// Initialize the canvas
const canvas = document.createElement('canvas');
const ctx = canvas.getContext('2d');
canvas.width = 600;
canvas.height = 600;
document.body.appendChild(canvas);

// Set up the player
let playerWidth = 50;
let playerHeight = 50;
let playerX = canvas.width / 2 - playerWidth / 2;
let playerY = canvas.height - playerHeight - 10;
let playerSpeed = 0.7;

// Set up the enemy
let enemyWidth = 50;
let enemyHeight = 50;
let enemyX = Math.floor(Math.random() * (canvas.width - enemyWidth));
let enemyY = -enemyHeight;
let enemySpeed = 0.5;

// Set up the score
let score = 0;
let scoreFont = "50px Arial";

// Define the game loop
function runGame() {
    // Handle events
    window.addEventListener('keydown', function(event) {
        if (event.code === 'ArrowLeft' && playerX > 0) {
            playerX -= playerSpeed;
        }
        else if (event.code === 'ArrowRight' && playerX < canvas.width - playerWidth) {
            playerX += playerSpeed;
        }
    });

    // Move the enemy
    enemyY += enemySpeed;
    if (enemyY > canvas.height) {
        enemyX = Math.floor(Math.random() * (canvas.width - enemyWidth));
        enemyY = -enemyHeight;
        score++;
    }

    // Check for collisions
    let playerRect = {x: playerX, y: playerY, width: playerWidth, height: playerHeight};
    let enemyRect = {x: enemyX, y: enemyY, width: enemyWidth, height: enemyHeight};
    if (playerRect.x < enemyRect.x + enemyRect.width &&
        playerRect.x + playerRect.width > enemyRect.x &&
        playerRect.y < enemyRect.y + enemyRect.height &&
        playerRect.y + playerRect.height > enemyRect.y) {
        score = 0;
    }

    // Draw the game objects
    ctx.fillStyle = '#000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = '#fff';
    ctx.fillRect(playerX, playerY, playerWidth, playerHeight);
    ctx.fillStyle = '#f00';
    ctx.fillRect(enemyX, enemyY, enemyWidth, enemyHeight);
    ctx.fillStyle = '#fff';
    ctx.font = scoreFont;
    ctx.fillText(score, 10, 50);

    // Update the display
    requestAnimationFrame(runGame);
}

// Run the game
runGame();