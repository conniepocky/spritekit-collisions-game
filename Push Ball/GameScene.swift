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
    
    var bottomBorder = SKShapeNode()
    var topBorder = SKShapeNode()
    var leftBorder = SKShapeNode()
    var rightBorder = SKShapeNode()
    
    let startingPlatform = SKShapeNode(rectOf: CGSize(width: 100, height: 30))
    
    var scoreLabel: SKLabelNode!
    
    func createBorders() {
        bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        bottomBorder.physicsBody?.affectedByGravity = false
        bottomBorder.physicsBody?.isDynamic = false
        bottomBorder.position = .init(x: 0, y: -frame.height / 2)
        bottomBorder.name = "border"
        addChild(bottomBorder)
        
        topBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        topBorder.physicsBody?.affectedByGravity = false
        topBorder.physicsBody?.isDynamic = false
        topBorder.position = .init(x: 0, y: frame.height / 2)
        topBorder.name = "border"
        addChild(topBorder)
        
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        leftBorder.physicsBody?.affectedByGravity = false
        leftBorder.physicsBody?.isDynamic = false
        leftBorder.position = .init(x: -frame.width / 2, y: 0)
        leftBorder.name = "border"
        addChild(leftBorder)
        
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightBorder.physicsBody?.affectedByGravity = false
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.position = .init(x: frame.width / 2, y: 0)
        rightBorder.name = "border"
        addChild(rightBorder)
    }
    
    func createPlatforms() {
        
        startingPlatform.fillColor = .systemMint
        startingPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 30))
        startingPlatform.physicsBody?.affectedByGravity = false
        startingPlatform.physicsBody?.isDynamic = false
        startingPlatform.name = "ground"
        startingPlatform.position = .init(x: -600, y: 300)
        
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
            
            if !Globals.levelPlatformPositions[level].isEmpty && (i < Globals.levelPlatformPositions[level].count) {
                let currentLevel = Globals.levelPlatformPositions[level]
                platform.position = .init(x: currentLevel[i][0], y: currentLevel[i][1])
            } else {
                platform.position = .init(x: Int.random(in: -600 ... 650), y: Int.random(in: -200...200))
            }
            
            addChild(platform)
        }
        
        let finalPlatform = SKShapeNode(rectOf: CGSize(width: 100, height: 30))
        finalPlatform.fillColor = .systemMint
        finalPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 30))
        finalPlatform.physicsBody?.affectedByGravity = false
        finalPlatform.physicsBody?.isDynamic = false
        finalPlatform.name = "final"
        finalPlatform.position = .init(x: 600, y: -400)
        
        addChild(finalPlatform)
    }
    
    func resetLevel() {
        
        for child in self.children {
            if child.name != "score" {
                child.removeFromParent()
            }
        }
        
        createBorders()
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
        scoreLabel.fontSize = 50
        scoreLabel.text = "0"
        scoreLabel.name = "score"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x:-650, y:450)
        addChild(scoreLabel)
        
        createPlatforms()
        createBorders()
        
        player.fillColor = .red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 1
        player.name = "player"
        
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        
        addChild(player)
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
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
        }
    }
    
    func collisionBetween(marble: SKNode, object: SKNode) {
        if object.name == "ground" {
            marble.physicsBody?.applyImpulse(CGVector(dx: 800, dy: 0))
        } else if object.name == "player" || object.name == "border" {
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
