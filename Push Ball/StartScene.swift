//
//  StartScene.swift
//  Push Ball
//
//  Created by Connie Waffles on 14/08/2024.
//

import SpriteKit
import Foundation

class StartScene: SKScene {
    
    var welcomeText: SKLabelNode!
    
    override func didMove(to view: SKView) {
        scene?.backgroundColor = .systemMint
        
        welcomeText = SKLabelNode(fontNamed: "Annai MN")
        welcomeText.fontSize = 25
        welcomeText.text = "Press anywhere to play."
        welcomeText.horizontalAlignmentMode = .center
        welcomeText.position = CGPoint(x:0, y:0)
        addChild(welcomeText)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameScene = SKScene(fileNamed: "GameScene")
        
        gameScene?.scaleMode = .aspectFill
        
        self.view?.presentScene(gameScene!, transition: SKTransition.fade(withDuration: 0.5))
    }
}
