//
//  GameViewController.swift
//  Push Ball
//
//  Created by Connie Waffles on 10/08/2024.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftUI

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let gameUI = GameUIView()
            // 2. embed this view into a ViewController
            let uiController = UIHostingController(rootView: gameUI)
            // 3. add the uiController as a child ViewController to this one
            addChild(uiController)
                                    
                        
            // 4. set the SwiftUI view controller's frame to be the same size as the SpriteKit view
            uiController.view.frame = view.frame
            // 5. set the background color to transparant, otherwise the SwiftUI view contains the standard white background, obscuring the SpriteKit view
            uiController.view.backgroundColor = UIColor.clear
            // 6. add the SwiftUI view as a subview to the SpriteKit view
            view.addSubview(uiController.view)
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "StartScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
