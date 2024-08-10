//
//  GameScene.swift
//  Push Ball
//
//  Created by Connie Waffles on 10/08/2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = SKShapeNode(circleOfRadius: 15)
    let terrain = SKShapeNode(rectOf: CGSize(width: 5000, height: 30))
    
    override func didMove(to view: SKView) {
        
        player.fillColor = .red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 1
        player.position = .init(x:0, y:500)
        addChild(player)
        
        terrain.fillColor = .green
        terrain.strokeColor = .brown
        terrain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5000, height: 30))
        terrain.physicsBody?.affectedByGravity = false
        terrain.physicsBody?.isDynamic = false
        terrain.position = .init(x:0, y:-frame.height/4)
        addChild(terrain)
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
            marble.physicsBody?.mass = 5
            marble.position = touch.location(in: self)
            
            self.addChild(marble)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
