//
//  StartScene.swift
//  Push Ball
//
//  Created by Connie Waffles on 14/08/2024.
//

import SpriteKit
import Foundation

class StartScene: SKScene {
    override func didMove(to view: SKView) {
        scene?.backgroundColor = .systemMint
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = SKScene(fileNamed: "GameScene")
        
        gameScene?.scaleMode = .aspectFill
        
        self.view?.presentScene(gameScene!, transition: SKTransition.fade(withDuration: 0.5))
    }
}
