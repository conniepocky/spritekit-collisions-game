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
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        addChild(effectNode)
        let effect = SKSpriteNode(texture: texture)
        effect.size = CGSize(width: 40, height: 40)
        effect.color = .orange
        effectNode.shouldRasterize = true
        effect.colorBlendFactor = 1
        effectNode.addChild(effect)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}
