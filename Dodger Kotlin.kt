import java.awt.*
import java.awt.event.*
import java.util.*
import javax.swing.*

fun main() {
    EventQueue.invokeLater(::initGUI)
}

fun initGUI() {
    val frame = JFrame("Dodger")
    frame.defaultCloseOperation = JFrame.EXIT_ON_CLOSE
    frame.contentPane.add(DodgerPanel())
    frame.pack()
    frame.isVisible = true
}

class DodgerPanel : JPanel(), ActionListener {
    companion object {
        const val WIDTH = 600
        const val HEIGHT = 400
        const val DELAY = 20
        const val RADIUS = 10
        const val ENEMY_RADIUS = 15
        const val ENEMY_SPEED = 2
        const val MAX_ENEMIES = 10
    }

    private var playerX = WIDTH / 2
    private var playerY = HEIGHT / 2
    private var enemies = LinkedList<Point>()
    private var gameTimer = Timer(DELAY, this)

    init {
        preferredSize = Dimension(WIDTH, HEIGHT)
        background = Color.BLACK
        gameTimer.start()
        addKeyListener(object : KeyAdapter() {
            override fun keyPressed(e: KeyEvent) {
                when (e.keyCode) {
                    KeyEvent.VK_LEFT -> playerX -= 5
                    KeyEvent.VK_RIGHT -> playerX += 5
                    KeyEvent.VK_UP -> playerY -= 5
                    KeyEvent.VK_DOWN -> playerY += 5
                }
                playerX = playerX.coerceIn(0, WIDTH)
                playerY = playerY.coerceIn(0, HEIGHT)
            }
        })
        isFocusable = true
    }

    override fun paintComponent(g: Graphics) {
        super.paintComponent(g)
        g.color = Color.WHITE
        g.fillOval(playerX - RADIUS, playerY - RADIUS, 2 * RADIUS, 2 * RADIUS)
        g.color = Color.RED
        for (enemy in enemies) {
            g.fillOval(enemy.x - ENEMY_RADIUS, enemy.y - ENEMY_RADIUS, 2 * ENEMY_RADIUS, 2 * ENEMY_RADIUS)
        }
    }

    override fun actionPerformed(e: ActionEvent) {
        if (enemies.size < MAX_ENEMIES) {
            spawnEnemy()
        }
        for (enemy in enemies) {
            enemy.y += ENEMY_SPEED
        }
        enemies.removeIf { it.y > HEIGHT + ENEMY_RADIUS }
        for (enemy in enemies) {
            if (enemy.distance(playerX.toDouble(), playerY.toDouble()) < ENEMY_RADIUS + RADIUS) {
                gameTimer.stop()
                JOptionPane.showMessageDialog(this, "Game Over")
                System.exit(0)
            }
        }
        repaint()
    }

    private fun spawnEnemy() {
        val rand = Random()
        var x: Int
        var y: Int
        do {
            x = rand.nextInt(WIDTH - 2 * ENEMY_RADIUS) + ENEMY_RADIUS
            y = rand.nextInt(HEIGHT / 2)
        } while (enemies.any { it.distance(x.toDouble(), y.toDouble()) < 2 * ENEMY_RADIUS })
        enemies.add(Point(x, y))
    }
}