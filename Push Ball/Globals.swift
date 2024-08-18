//
//  Globals.swift
//  Push Ball
//
//  Created by Connie Waffles on 13/08/2024.
//

import Foundation

enum GameConfiguration {
    enum Core {
        static let gameWidth: CGFloat = 960
        static let gameHeight: CGFloat = 540
    }
}

struct Globals {
    static var level = 0
    
    static var levelPlatformPositions = [
    [[170, 538],
     [293, 461],
     [400, 400],
     [570, 310],
     [790, 200]],
    [[-400, 240],
    [100, 200],
    [-150, 50],
    [130, -100],
    [300, -210]]
    ]
}
