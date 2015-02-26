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
    var selectedNode: SKNode?
    
    //MARK: Computed Properties
    var blueGraveNode: SKNode!
    {
        get{
            return self.childNodeWithName("BlueGrave")
        }
    }
    
    var redGraveNode: SKNode!
    {
        get{
            return self.childNodeWithName("RedGrave")
        }
    }
    
    override func didMoveToView(view: SKView)
    {
        println("didMoveToView")
        println(view.frame)
        /* Setup your scene here */
        createInitalScene()
        startGame()
    }
    
    func updateUI(){
        score.text = "\(gameLogic.score)"
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        score.text = "\(gameLogic.score)"
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
        score.fontColor = SKColor.whiteColor()
        score.fontName = "AvenirNext-UltraLight"
        score.text = "0"
        self.addChild(score)
    }
    func createBackground()
    {
        let backgroundTexture = SKTexture(imageNamed: "Background")
        let background = SKSpriteNode(texture: backgroundTexture, size: self.view!.frame.size)
        background.position = CGPoint(x: CGRectGetMidX(self.view!.frame), y: CGRectGetMidY(self.view!.frame))
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
        self.runAction(gameOverSound())
    }
    //MARK: CREATE NODES
    //MARK: GHOST NODES
    func createBlueGhostsAtRandomPointWithActions()
    {
        let blueGhost = SKSpriteNode(imageNamed: BLUE_GHOST_NODE_NAME)
        let ghostRandomPositionPoint = createRandomPoint()
        blueGhost.position = ghostRandomPositionPoint
        blueGhost.name = BLUE_GHOST_NODE_NAME
        blueGhost.alpha = 0
        let ghostActionSequence = SKAction.sequence([fadeIn(),moveToRandomPoint()])
        blueGhost.runAction(ghostActionSequence, withKey: "FadeInAndMove")
        blueGhost.runAction(SKAction.sequence([waitForDuration(10),pulseFade(),die()]))
        self.addChild(blueGhost)

    }
    
    func createRedGhostsAtRandomPointWithActions()
    {
        let redGhost = SKSpriteNode(imageNamed: RED_GHOST_NODE_NAME)
        let ghostRandomPositionPoint = createRandomPoint()
        redGhost.position = ghostRandomPositionPoint
        redGhost.name = RED_GHOST_NODE_NAME
        redGhost.alpha = 0
        let ghostActionSequence = SKAction.sequence([fadeIn(),moveToRandomPoint()])
        redGhost.runAction(ghostActionSequence, withKey: "FadeInAndMove")
        redGhost.runAction(SKAction.sequence([waitForDuration(10),pulseFade(),die()]))
        self.addChild(redGhost)
    }
    //MARK: GRAVE NODES
    func createBlueGrave()
    {
        let blueGrave = SKSpriteNode(imageNamed: "BlueGrave")
        blueGrave.name = "BlueGrave"
        blueGrave.anchorPoint = CGPoint(x: 1, y: 0.5)
        blueGrave.position = CGPointMake(CGRectGetMidX(self.view!.frame) - GRAVE_BUFFER_AMOUNT, CGRectGetMidY(self.view!.frame))
        blueGrave.userInteractionEnabled = false
        blueGrave.zPosition = -1
        self.addChild(blueGrave)
    }
    func createRedGrave()
    {
        let redGrave = SKSpriteNode(imageNamed: "RedGrave")
        redGrave.name = "RedGrave"
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
        let moveToRandomPoint = SKAction.moveTo(randomPoint, duration: 6)
        return moveToRandomPoint
    }
    func fadeIn() -> SKAction
    {
        return SKAction.fadeInWithDuration(FADE_IN_SPEED)
    }
    func fadeOut() -> SKAction
    {
        return SKAction.fadeOutWithDuration(FADE_OUT_SPEED)
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
    
    //MARK: SOUNDS
    func gameOverSound() -> SKAction
    {
        return SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: true)
    }
    
    func bluePointSound() -> SKAction
    {
        return SKAction.playSoundFileNamed("bluePoint.mp3", waitForCompletion: true)
    }
    func redPointSound() -> SKAction
    {
        return SKAction.playSoundFileNamed("redPoint.wav", waitForCompletion: true)
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
            if node.name == BLUE_GHOST_NODE_NAME || node.name == RED_GHOST_NODE_NAME
            {
                node.removeFromParent()
            }
        }
    }
    func dropRedGhostNodes()
    {
        for node in self.children as [SKNode]
        {
            if node.name == RED_GHOST_NODE_NAME
            {
                node.removeFromParent()
            }
        }
    }
    func dropBlueGhostNodes()
    {
        for node in self.children as [SKNode]
        {
            if node.name == BLUE_GHOST_NODE_NAME
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

    //MARK: TOUCHES EVENT
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == BLUE_GHOST_NODE_NAME || node.name == RED_GHOST_NODE_NAME
            {
                selectedNode = node
                selectedNode!.paused = true
            }else{
                selectedNode = nil
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if selectedNode?.name == BLUE_GHOST_NODE_NAME || selectedNode?.name == RED_GHOST_NODE_NAME
        {
            selectedNode!.position = touches.anyObject()!.locationInNode(self)
        }
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if let node = selectedNode
        {
            if CGRectIntersectsRect(node.frame, blueGraveNode.frame)
            {
                if node.name == "BlueGhost"
                {
                    gameLogic.match()
                    self.runAction(bluePointSound())
                    node.removeFromParent()
                } else {
                    gameOver()
                    gameLogic.misMatch()
                }
            }else if CGRectIntersectsRect(node.frame, redGraveNode.frame) {
                if node.name == "RedGhost"
                {
                    gameLogic.match()
                    self.runAction(redPointSound())
                    node.removeFromParent()
                } else {
                    gameOver()
                    gameLogic.misMatch()
                }
            }else {
                gameLogic.misMatch()
                node.removeActionForKey("FadeInAndMove")
                node.runAction(moveToRandomPoint(), withKey: "FadeInAndMove")
                node.paused = false
                selectedNode = nil
            }
        }
    }
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        selectedNode?.paused = false
    }
}
