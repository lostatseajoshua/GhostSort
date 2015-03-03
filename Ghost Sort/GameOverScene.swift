//
//  GameOverScene.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 3/2/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var viewController: UIViewController!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor().hexStringToUIColor("B95BFE")
    }
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == RETRY_NODE_NAME || node.name == RETRY_LABEL_NODE_NAME
            {
                retryGame()
            } else if node.name == HOME_NODE_NAME || node.name == HOME_LABEL_NODE_NAME {
                goToHome()
            }
        }
    }
    
    func goToHome()
    {
        self.removeFromParent()
        self.view?.presentScene(nil)
        viewController.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    func retryGame()
    {
        self.removeFromParent()
        
        let scene = GameScene(size: self.view!.frame.size)
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.view?.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = SKSceneScaleMode.Fill
        
        self.view?.presentScene(scene)
    }
   
}
