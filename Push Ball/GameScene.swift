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
        
        scene!.scaleMode = .aspectFit
        
        let startingPlatform = SKShapeNode(rectOf: CGSize(width: 100, height: 30))
        
        startingPlatform.fillColor = .green
        startingPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 30))
        startingPlatform.physicsBody?.affectedByGravity = false
        startingPlatform.physicsBody?.isDynamic = false
        startingPlatform.name = "ground"
        startingPlatform.position = .init(x: -600, y: 300)
        
        print(startingPlatform.position.x)
        addChild(startingPlatform)
        
        player.position.x = startingPlatform.position.x
        player.position.y = startingPlatform.position.y + 50
        
        for _ in 1...5 { // to do make platforms more widely spaced and add final platform to reset + win round
            let width = Int.random(in: 150...250)
            let height = 30
            let platform = SKShapeNode(rectOf: CGSize(width: width, height: height))
            
            platform.fillColor = .green
            platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            platform.physicsBody?.affectedByGravity = false
            platform.physicsBody?.isDynamic = false
            platform.name = "ground"
            platform.position = .init(x: Int.random(in: -600 ... 650), y: Int.random(in: -200...200))
            
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
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
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
            if marble.position.x >= 0 {
                marble.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 0))
            } else {
                marble.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 0))
            }
        } else if object.name == "player" || object.name == "border" {
            marble.removeFromParent()
        }
    }
    
    func finishLevel(player: SKNode, object: SKNode) {
        if object.name == "final" {
            print("next level")
        } else if object.name == "border" {
            print("hit border restart")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if contact.bodyA.node?.name == "marble" {
            collisionBetween(marble: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "marble" {
            collisionBetween(marble: contact.bodyB.node!, object: contact.bodyA.node!)
        } else if contact.bodyA.node?.name == "player"{
            finishLevel(player: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "player" {
            finishLevel(player: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
