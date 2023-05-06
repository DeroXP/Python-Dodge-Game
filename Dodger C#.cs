using System;
using System.Drawing;
using System.Windows.Forms;

namespace DodgerGame
{
    public partial class Form1 : Form
    {
        // Initialize the game window
        const int WIDTH = 600;
        const int HEIGHT = 600;
        Bitmap buffer;
        Graphics g;
        Font scoreFont;
        int score;

        // Set up the player
        const int playerWidth = 50;
        const int playerHeight = 50;
        int playerX;
        int playerY;
        double playerSpeed;

        // Set up the enemy
        const int enemyWidth = 50;
        const int enemyHeight = 50;
        int enemyX;
        int enemyY;
        double enemySpeed;

        public Form1()
        {
            InitializeComponent();

            // Initialize the game window
            Width = WIDTH;
            Height = HEIGHT;
            Text = "Dodger Game";

            // Set up the player
            playerX = WIDTH / 2 - playerWidth / 2;
            playerY = HEIGHT - playerHeight - 10;
            playerSpeed = 0.7;

            // Set up the enemy
            Random random = new Random();
            enemyX = random.Next(0, WIDTH - enemyWidth);
            enemyY = -enemyHeight;
            enemySpeed = 0.5;

            // Set up the score
            score = 0;
            scoreFont = new Font("Arial", 50);

            // Create the double buffer
            buffer = new Bitmap(Width, Height);
            g = Graphics.FromImage(buffer);

            // Start the game loop
            timer1.Interval = 10;
            timer1.Enabled = true;
        }

        // Define the game loop
        private void timer1_Tick(object sender, EventArgs e)
        {
            // Move the player
            if (Input.GetKey(Keys.Left) && playerX > 0)
            {
                playerX -= (int)(playerSpeed * timer1.Interval);
            }
            if (Input.GetKey(Keys.Right) && playerX < WIDTH - playerWidth)
            {
                playerX += (int)(playerSpeed * timer1.Interval);
            }

            // Move the enemy
            enemyY += (int)(enemySpeed * timer1.Interval);
            if (enemyY > HEIGHT)
            {
                Random random = new Random();
                enemyX = random.Next(0, WIDTH - enemyWidth);
                enemyY = -enemyHeight;
                score += 1;
            }

            // Check for collisions
            Rectangle playerRect = new Rectangle(playerX, playerY, playerWidth, playerHeight);
            Rectangle enemyRect = new Rectangle(enemyX, enemyY, enemyWidth, enemyHeight);
            if (playerRect.IntersectsWith(enemyRect))
            {
                score = 0;
            }

            // Draw the game objects
            g.Clear(Color.Black);
            g.FillRectangle(Brushes.White, new Rectangle(playerX, playerY, playerWidth, playerHeight));
            g.FillRectangle(Brushes.Red, new Rectangle(enemyX, enemyY, enemyWidth, enemyHeight));
            g.DrawString(score.ToString(), scoreFont, Brushes.White, new PointF(10, 10));

            // Update the display
            Graphics graphics = CreateGraphics();
            graphics.DrawImageUnscaled(buffer, 0, 0);
            graphics.Dispose();
        }
    }
}