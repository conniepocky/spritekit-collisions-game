//
//  GameScene.swift
//  Push Ball
//
//  Created by Connie Waffles on 10/08/2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKShapeNode(circleOfRadius: 20)
    let ground = SKShapeNode(rectOf: CGSize(width: 5000, height: 30))
    
    var bottomBorder = SKShapeNode(rectOf: CGSize(width: 5000, height: 30))
    var topBorder = SKShapeNode(rectOf: CGSize(width: 5000, height: 30))
    var leftBorder = SKShapeNode(rectOf: CGSize(width: 5000, height: 30))
    var rightBorder = SKShapeNode(rectOf: CGSize(width: 5000, height: 30))
    
    let startingPlatform = SKShapeNode(rectOf: CGSize(width: 100, height: 30))
    
    var scoreLabel: SKLabelNode!
    
    
    
    func destroyNode(node: SKNode) {
        let explosionEmitterNode = SKEmitterNode(fileNamed:"Explosion")!
        explosionEmitterNode.position = node.position
        
        let explodeAction = SKAction.run({self.addChild(explosionEmitterNode)
            node.removeFromParent()})
        
        let wait = SKAction.wait(forDuration: 0.1)
        
        let removeExplosion = SKAction.run({explosionEmitterNode.removeFromParent()})
        
        let sequence = SKAction.sequence([explodeAction, wait, removeExplosion])
        
        self.run(sequence)
    }
    
    func createPlatforms() {
        
        startingPlatform.fillColor = .systemMint
        startingPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 30))
        startingPlatform.physicsBody?.affectedByGravity = false
        startingPlatform.physicsBody?.isDynamic = false
        startingPlatform.name = "ground"
        startingPlatform.position = .init(x: 75, y: 640)
        
        addChild(startingPlatform)
        
        player.position.x = startingPlatform.position.x
        player.position.y = startingPlatform.position.y + 50
        
        let level = Globals.level
        
        for i in 0...4 {
            let width = Int.random(in: 150...200)
            let height = 30
            let platform = SKShapeNode(rectOf: CGSize(width: width, height: height))
            
            platform.fillColor = .green
            platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            platform.physicsBody?.affectedByGravity = false
            platform.physicsBody?.isDynamic = false
            platform.name = "ground"
            
            if (Globals.level < Globals.levelPlatformPositions.count) && (i < Globals.levelPlatformPositions[level].count) {
                let currentLevel = Globals.levelPlatformPositions[level]
                platform.position = .init(x: currentLevel[i][0], y: currentLevel[i][1])
            } else {
                platform.position = .init(x: Int.random(in: 0 ... 1024), y: Int.random(in: 0...768))
            }
            
            addChild(platform)
        }
        
        let finalPlatform = SKShapeNode(rectOf: CGSize(width: 100, height: 30))
        finalPlatform.fillColor = .systemMint
        finalPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 30))
        finalPlatform.physicsBody?.affectedByGravity = false
        finalPlatform.physicsBody?.isDynamic = false
        finalPlatform.name = "final"
        finalPlatform.position = .init(x: 912, y: 135)
        
        addChild(finalPlatform)
    }
    
    func resetLevel() {
        
        for child in self.children {
            if child.name != "score" {
                child.removeFromParent()
            }
        }
        
        createPlatforms()
        
        player.fillColor = .red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 1
        player.name = "player"
        
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        
        addChild(player)
    }
    
    override func didMove(to view: SKView) {
        
        scene!.scaleMode = .aspectFit
        physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(fontNamed: "Annai MN")
        scoreLabel.fontSize = 25
        scoreLabel.text = "0"
        scoreLabel.name = "score"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x:20, y:740)
        addChild(scoreLabel)
        
        createPlatforms()
        
        player.fillColor = .red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 1
        player.name = "player"
        
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        
        addChild(player)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print(touch.location(in: self).x, touch.location(in:self).y)
        }
    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//       
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let marble = SKShapeNode(circleOfRadius: 15)
            marble.fillColor = .blue
            
            marble.physicsBody = SKPhysicsBody(circleOfRadius: 15)
            marble.physicsBody?.affectedByGravity = true
            marble.physicsBody?.isDynamic = true
            marble.physicsBody?.mass = 7
            marble.position = touch.location(in: self)
            marble.name = "marble"
            
            marble.physicsBody!.contactTestBitMask = marble.physicsBody!.collisionBitMask
            
            self.addChild(marble)
            
            marble.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -200))
        }
    }
    
    func collisionBetween(marble: SKNode, object: SKNode) {
        if object.name == "ground" {
            marble.physicsBody?.applyImpulse(CGVector(dx: 800, dy: 0))
        } else if object.name == "player" {
            destroyNode(node: marble)
        } else if object.name == "border" || object.name == "final"{
            marble.removeFromParent()
        }
    }
    
    func levelUp() {
        Globals.level += 1
        scoreLabel.text = "\(Globals.level)"
    }
    
    func finishLevel(playerNode: SKNode, object: SKNode) {
        if object.name == "final" {
            levelUp()
            
            resetLevel()
            
        } else if object.name == "border" {
            print("hit border restart")
            
            let action = SKAction.move(to: CGPoint(x: startingPlatform.position.x, y: startingPlatform.position.y+50), duration: 0.1)
            playerNode.physicsBody?.isDynamic = false
            playerNode.run(action)
            playerNode.physicsBody?.isDynamic = true
            playerNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "marble" {
            collisionBetween(marble: nodeA, object: nodeB)
        } else if nodeB.name == "marble" {
            collisionBetween(marble: nodeB, object: nodeA)
        } else if nodeA.name == "player"{
            finishLevel(playerNode: nodeA, object: nodeB)
        } else if nodeB.name == "player" {
            finishLevel(playerNode: nodeB, object: nodeA)
        }
        
    }
    
    func movePlayerToPlatform() {
        let action = SKAction.move(to: CGPoint(x: startingPlatform.position.x, y: startingPlatform.position.y+50), duration: 0.1)
        player.physicsBody?.isDynamic = false
        player.run(action)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func keepNodesInBounds() {
        for child in self.children {
            if child.position.y < 0 {
                if child.name == "player" {
                    movePlayerToPlatform()
                } else {
                    child.removeFromParent()
                }
            }
            if child.position.x < 0 {
                if child.name == "player" {
                    movePlayerToPlatform()
                } else {
                    child.removeFromParent()
                }
            }
            if child.position.x > 1024 {
                if child.name == "player" {
                    movePlayerToPlatform()
                } else {
                    child.removeFromParent()
                }
            }
            if child.position.y > 768 {
                if child.name == "player" {
                    movePlayerToPlatform()
                } else {
                    child.removeFromParent()
                }
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        keepNodesInBounds()
    }
}
