//
//  GameViewController.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 2/5/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as SKScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    var skView: SKView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Configure the view.
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        println("View Will Appear")
        skView = self.view as SKView
        
        if skView.scene == nil
        {
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsFields = true
            let scene = GameScene(size: self.view.frame.size)
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = SKSceneScaleMode.Fill
            scene.viewController = self
            println(scene.frame)
            skView.presentScene(scene)
        }

    }
    
    
    override func shouldAutorotate() -> Bool
    {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        skView.removeFromSuperview()
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }

    
}
