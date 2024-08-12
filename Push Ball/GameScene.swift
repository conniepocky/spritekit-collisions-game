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
    
    func createPlatforms() {
        
        scene!.scaleMode = .aspectFit
        
        let startingPlatform = SKShapeNode(rectOf: CGSize(width: 100, height: 30))
        
        startingPlatform.fillColor = .green
        startingPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 30))
        startingPlatform.physicsBody?.affectedByGravity = false
        startingPlatform.physicsBody?.isDynamic = false
        startingPlatform.name = "ground"
        startingPlatform.position = .init(x: Int.random(in: -600 ... -400), y: 200)
        
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
        finalPlatform.name = "ground"
        finalPlatform.position = .init(x: 600, y: -400)
        
        addChild(finalPlatform)
        
        
    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        createPlatforms()
        
        player.fillColor = .red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 1
        player.name = "player"
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
        } else if object.name == "player" {
            marble.removeFromParent()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "marble" {
            collisionBetween(marble: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "marble" {
            collisionBetween(marble: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
