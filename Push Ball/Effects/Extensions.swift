//
//  Extensions.swift
//  Push Ball
//
//  Created by Connie Waffles on 01/09/2024.
//

import Foundation
import SpriteKit

extension SKSpriteNode {

    func addGlow(radius: Float = 30) {
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        
        let effectNode = SKEffectNode()
        
        effectNode.shouldRasterize = true
        addChild(effectNode)
        
        let effect = SKSpriteNode(texture: texture)
        
        effect.size = CGSize(width: 40, height: 40)
        effect.color = .systemPink
        effectNode.shouldRasterize = true
        effect.colorBlendFactor = 1
        
        effect.alpha = 0
        
        effectNode.addChild(effect)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
        effect.removeAllActions()
        
        effect.run(fadeIn)
    }
    
    func removeGlow() {
        
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 1.5)
        
        if !self.children.isEmpty {
            self.children[0].run(fadeOut){
              self.removeAllChildren()
            }
        }
    }
}

extension UIView {
    /// Remove all subview
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    /// Remove all subview with specific type
    func removeAllSubviews<T: UIView>(type: T.Type) {
        subviews
            .filter { $0.isMember(of: type) }
            .forEach { $0.removeFromSuperview() }
    }
}
