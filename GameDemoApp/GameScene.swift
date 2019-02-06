//
//  GameScene.swift

//  GameDemoApp
//
//  Created by Oniel Rosario on 1/12/19.
//

import SpriteKit
import GameplayKit
enum GamePhase {
    case ready
    case inPlay
    case gameOver
}
@objcMembers
class GameScene: SKScene {
   
    var foodThrowTimer = Timer()
    var gamePhase =  GamePhase.ready
    var score = 0
    var best = 0
    var missCount = 0
    var missesMax = 3
    var explodeOverlay = SKShapeNode()
    var promptLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var bestLabel = SKLabelNode()
    var xmarks = XMark()
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        bestLabel = childNode(withName: "bestLabel") as! SKLabelNode
        bestLabel.text = "\(best)"
        promptLabel = childNode(withName: "promptLabel") as! SKLabelNode
        xmarks = XMark(num: missesMax)
        xmarks.position = CGPoint(x: size.width-100, y: size.height-100)
        addChild(xmarks)
        explodeOverlay = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        explodeOverlay.fillColor = .white
        addChild(explodeOverlay)
        explodeOverlay.alpha = 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gamePhase == .ready {
            gamePhase = .inPlay
            startGame()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let previous = t.previousLocation(in: self)
            for node in nodes(at: location) {
                if node.name == "fruit" {
                    score += 1
                    scoreLabel.text = "\(score)"
                    //exploding effect
                    particleEffect(position: node.position)
                    //sound effects
                    node.removeFromParent()
                }
                if node.name == "bomb" {
                    bombExplode()
                    gameOver()
                    particleEffect(position: node.position)
                }
            }
          let line = TrailLine(position: location, lastPos: previous, with: 8, color: .white)
            addChild(line)
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func update(_ currentTime: TimeInterval) {
    }
    override func didSimulatePhysics() {
        for fruit in children {
            if fruit.position.y < -100 {
                fruit.removeFromParent()
                if fruit.name == "fruit" {
                  missFruit()
                }
            }
        }
    }
    
    
    func startGame () {
        score = 0
        scoreLabel.text = "\(score)"
        bestLabel.text = "Best: \(best)"
        missCount = 0
        xmarks.reset()
        promptLabel.isHidden = true
        foodThrowTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in self.createFruits()})
    }
    func createFruits() {
        print("fruits")
        let numberOfFruits = 1 + Int(arc4random_uniform(UInt32(4)))
        for _ in 0..<numberOfFruits {
            let fruit = Fruit()
            fruit.position.x = randomCGFloat(0, size.width)
            fruit.position.y = -100
            addChild(fruit)
            if fruit.position.x < size.width/2 {
                fruit.physicsBody?.velocity.dx = randomCGFloat(0, 200)
                //frames animation
            }
            if fruit.position.x > size.width/2 {
                fruit.physicsBody?.velocity.dx = randomCGFloat(0, -200)
            }
            fruit.physicsBody?.velocity.dy = randomCGFloat(500, 800)
            fruit.physicsBody?.angularVelocity = randomCGFloat(-5, 5)
        }
    }
    
    func missFruit() {
        missCount += 1
    
        xmarks.update(num: missCount)
        if missCount == missesMax {
            gameOver()
        }
    }
    
    func bombExplode() {
        for case let fruit as Fruit in children {
            fruit.removeFromParent()
            particleEffect(position: fruit.position)
        }
        
        
        explodeOverlay.run(SKAction.sequence([
            SKAction.fadeAlpha(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 0, duration: 0)
            ]))
    }
    
    func gameOver() {
        if score > best {
            best = score
        }
        promptLabel.isHidden = false
        promptLabel.text = "Game Over"
        promptLabel.setScale(0)
        promptLabel.run(SKAction.scale(to: 1, duration: 0.3))
        gamePhase = .gameOver
        foodThrowTimer.invalidate()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {_ in self.gamePhase = .ready})
    }
    
    func particleEffect(position: CGPoint) {
        let emitter = SKEmitterNode(fileNamed: "MyParticle.sks")
        emitter?.position = position
        addChild(emitter!)
    }
}
