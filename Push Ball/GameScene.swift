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
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        player.fillColor = .red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 1
        player.name = "player"
        player.position = .init(x:0, y:500)
        addChild(player)
        
        ground.fillColor = .green
        ground.strokeColor = .brown
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5000, height: 30))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        ground.name = "ground"
        ground.position = .init(x:0, y:-frame.height/4)
        addChild(ground)
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
