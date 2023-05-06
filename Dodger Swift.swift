import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var enemy: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        backgroundColor = .black
        
        player = SKSpriteNode(color: .white, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: size.width/2, y: 50)
        addChild(player)
        
        enemy = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        enemy.position = CGPoint(x: CGFloat.random(in: 0..<size.width), y: size.height)
        addChild(enemy)
        
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: 10, y: size.height - 40)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        let moveEnemy = SKAction.moveBy(x: 0, y: -size.height-enemy.size.height, duration: 4)
        let removeEnemy = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([moveEnemy, removeEnemy]))
        
        let spawnEnemy = SKAction.run {
            let newEnemy = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
            newEnemy.position = CGPoint(x: CGFloat.random(in: 0..<self.size.width), y: self.size.height)
            self.addChild(newEnemy)
            let moveEnemy = SKAction.moveBy(x: 0, y: -self.size.height-enemy.size.height, duration: 4)
            let removeEnemy = SKAction.removeFromParent()
            newEnemy.run(SKAction.sequence([moveEnemy, removeEnemy]))
        }
        let spawnDelay = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([spawnDelay, spawnEnemy])
        let spawnEnemies = SKAction.repeatForever(spawnSequence)
        run(spawnEnemies)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let movePlayer = SKAction.moveTo(x: touchLocation.x, duration: 0.1)
        player.run(movePlayer)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == player || contact.bodyB.node == player {
            score = 0
        }
    }
}