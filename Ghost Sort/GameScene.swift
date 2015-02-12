//
//  GameScene.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 2/5/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let gameLogic = GameLogic()
    let score = SKLabelNode()
    
    override func didMoveToView(view: SKView)
    {
        println("didMoveToView")
        /* Setup your scene here */
        self.backgroundColor = SKColor.whiteColor()
        createInitalScene()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
        }
    }
   
    func createInitalScene()
    {
        createBackground()
        createScoreLabel()
    }
    
    func updateUI(){
        score.text = "\(gameLogic.score)"
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
    
    func createScoreLabel()
    {
        score.position = CGPoint(x: CGRectGetMidX(self.view!.frame), y: CGRectGetMaxY(self.view!.frame) - 28)
        print(score.position)
        score.fontColor = SKColor.blackColor()
        score.text = "0"
        self.addChild(score)
    }
    func createBackground()
    {
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: CGRectGetMidX(self.view!.bounds), y: CGRectGetMidY(self.view!.bounds))
        let fade = SKAction.fadeInWithDuration(0.5)
        background.runAction(fade)
        background.zPosition = -1
        self.addChild(background)
    }
    
    func dropAllNodes()
    {
        self.removeAllChildren()
        self.removeAllActions()
    }
}
