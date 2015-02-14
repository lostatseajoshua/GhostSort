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
        createInitalScene()
        startGame()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
        }
    }
    
    func updateUI(){
        score.text = "\(gameLogic.score)"
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
    //MARK: CREATE GAME SCENE
    func createInitalScene()
    {
        createBackground()
        createScoreLabel()
        createBlueGrave()
        createRedGrave()
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
        background.zPosition = -2
        self.addChild(background)
    }
    //MARK: START GAME
    func startGame()
    {
        let createBlueGhostsAction = SKAction.runBlock({self.createBlueGhostsAtRandomPointWithActions()})
        let createBlueGhostsAtRandomPoints = SKAction.sequence([createBlueGhostsAction, delayActionByGameSpeed()])
        self.runAction(SKAction.repeatActionForever(createBlueGhostsAtRandomPoints))
        
        let createRedGhostsAction = SKAction.runBlock({self.createRedGhostsAtRandomPointWithActions()})
        let createRedGhostsAtRandomPoints = SKAction.sequence([createRedGhostsAction, delayActionByGameSpeed()])
        self.runAction(SKAction.repeatActionForever(createRedGhostsAtRandomPoints))
        
    }
    //MARK: STOP GAME
    func gameOver()
    {
        self.dropAllGhostNodes()
        self.removeAllActionsForAllNodes()
    }
    //MARK: CREATE NODES
    //MARK: GHOST NODES
    func createBlueGhostsAtRandomPointWithActions()
    {
        let blueGhost = SKSpriteNode(imageNamed: "BlueGhost")
        let ghostRandomPositionPoint = createRandomPoint()
        blueGhost.position = ghostRandomPositionPoint
        blueGhost.name = "BlueGhost"
        blueGhost.alpha = 0
        self.addChild(blueGhost)
        let ghostActionSequence = SKAction.sequence([fadeIn(),moveToRandomPoint(),pulseFade(),die()])
        blueGhost.runAction(ghostActionSequence)
    }
    
    func createRedGhostsAtRandomPointWithActions()
    {
        let redGhost = SKSpriteNode(imageNamed: "RedGhost")
        let ghostRandomPositionPoint = createRandomPoint()
        redGhost.position = ghostRandomPositionPoint
        redGhost.name = "RedGhost"
        redGhost.alpha = 0
        self.addChild(redGhost)
        let ghostActionSequence = SKAction.sequence([fadeIn(),moveToRandomPoint(),pulseFade(),die()])
        redGhost.runAction(ghostActionSequence)
    }
    //MARK: GRAVE NODES
    func createBlueGrave()
    {
        let blueGrave = SKSpriteNode(imageNamed: "BlueGrave")
        blueGrave.anchorPoint = CGPoint(x: 1, y: 0.5)
        blueGrave.position = CGPointMake(CGRectGetMidX(self.view!.frame) - GRAVE_BUFFER_AMOUNT, CGRectGetMidY(self.view!.frame))
        blueGrave.userInteractionEnabled = false
        blueGrave.zPosition = -1
        self.addChild(blueGrave)
    }
    func createRedGrave()
    {
        let redGrave = SKSpriteNode(imageNamed: "RedGrave")
        redGrave.anchorPoint = CGPoint(x: 0, y: 0.5)
        redGrave.position = CGPointMake(CGRectGetMidX(self.view!.frame) + GRAVE_BUFFER_AMOUNT, CGRectGetMidY(self.view!.frame))
        redGrave.userInteractionEnabled = false
        redGrave.zPosition = -1
        self.addChild(redGrave)
    }
    //MARK: SKACTIONS
    func createRandomPoint() -> CGPoint
    {
        let highestX = UInt32(CGRectGetMaxX(self.view!.frame))
        let highestY = UInt32(CGRectGetMaxY(self.view!.frame))
        let randPointX = CGFloat(arc4random_uniform(highestX))
        let randPointY = CGFloat(arc4random_uniform(highestY))
        return CGPointMake(randPointX, randPointY)
    }
    func moveToRandomPoint() -> SKAction
    {
        let randomPoint = createRandomPoint()
        let moveToRandomPoint = SKAction.moveTo(randomPoint, duration: 10)
        return moveToRandomPoint
    }
    func fadeIn() -> SKAction
    {
        return SKAction.fadeInWithDuration(FADE_IN_SPEED)
    }
    func delayActionByGameSpeed() -> SKAction
    {
        return SKAction.waitForDuration(gameLogic.speed, withRange: gameLogic.speedRange)

    }
    func waitForDuration(delayTime: NSTimeInterval) -> SKAction
    {
        return SKAction.waitForDuration(delayTime)
    }
    func fadeAlphaOut() -> SKAction
    {
        return SKAction.fadeAlphaBy(-0.5, duration: 0.4)
    }
    func fadeAlphaIn() -> SKAction
    {
        return SKAction.fadeAlphaBy(0.5, duration: 0.4)
    }
    func pulseFade() -> SKAction
    {
        return SKAction.sequence([fadeAlphaOut(),fadeAlphaIn(),fadeAlphaOut(),fadeAlphaIn(),fadeAlphaOut(),fadeAlphaIn(),fadeAlphaOut(),fadeAlphaIn()])
    }
    func die() -> SKAction
    {
        return SKAction.runBlock({ self.gameOver() })
    }
    //MARK: DROP NODES
    func dropAllNodes()
    {
        self.removeAllChildren()
    }
    func dropAllGhostNodes()
    {
        for node in self.children as [SKNode]
        {
            if node.name == "BlueGhost" || node.name == "RedGhost"
            {
                node.removeFromParent()
            }
        }
    }
    func dropRedGhostNodes()
    {
        for node in self.children as [SKNode]
        {
            if node.name == "RedGhost"
            {
                node.removeFromParent()
            }
        }
    }
    func dropBlueGhostNodes()
    {
        for node in self.children as [SKNode]
        {
            if node.name == "RedGhost"
            {
                node.removeFromParent()
            }
        }
    }
    //MARK: REMOVE ALL ACTIONS
    func removeAllActionsForAllNodes() {
        for node in self.children
        {
            node.removeAllActions()
        }
    }

}
