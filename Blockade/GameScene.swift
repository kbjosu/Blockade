//
//  GameScene.swift
//  Blockade
//
//  Created by Kyle Johnson on 4/25/16.
//  Copyright (c) 2016 Kyle Johnson. All rights reserved.
//

import SpriteKit

let SceneWidth: CGFloat = 1242
let SceneHeight: CGFloat = 2208

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    static let WallCategory: UInt32 = 0x1 << 0
    var ball: Ball!
    var paddle: Paddle!
    var lastTouch: CGPoint?
    var score: SKLabelNode!
    
    override init() {
        super.init(size: CGSize(width: SceneWidth, height: SceneHeight))
        if let scene = self.scene {
            scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: scene.frame)
            if let body = self.physicsBody {
                body.usesPreciseCollisionDetection = true
                body.categoryBitMask = GameScene.WallCategory
                body.collisionBitMask = Ball.Category | Paddle.Category
                body.friction = 0
            } else {
                print("Scene physics body not initialized")
            }
        } else {
            print("Game scene not initialized")
        }
        self.physicsWorld.contactDelegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.createContents()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //let firstNode = contact.bodyA.node as! SKSpriteNode
        //let secondNode = contact.bodyB.node as! SKSpriteNode
        if (contact.bodyA.categoryBitMask == Paddle.Category) && (contact.bodyB.categoryBitMask == Ball.Category) {
            //let contactPoint = contact.contactPoint
            paddle.incrementScore()
            score.text = "Score: " + "\(paddle.getScore())"
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         for touch in touches {
            let location = touch.locationInNode(self)
            lastTouch = location
         }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            lastTouch = location
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouch = nil
    }
    
    override func update(currentTime: CFTimeInterval) {
        if let location = lastTouch {
            paddle.move(location)
        } else {
            paddle.stop()
        }
        
        if ball.position.y < SceneHeight / 20 {
            stopGame()
        }
    }
    
    func stopGame() {
        self.removeAllChildren()
        self.removeAllActions()
        let scene = Menu()
        let menuView = view! as SKView
        menuView.showsFPS = true
        menuView.showsNodeCount = true
        menuView.ignoresSiblingOrder = false
        scene.scaleMode = .AspectFill
        menuView.presentScene(scene)
    }
    
    private func createContents() {
        if let background: SKSpriteNode = SKSpriteNode(imageNamed: "background") {
            background.size = CGSize(width: SceneWidth, height: SceneHeight)
            background.position = CGPoint(x: SceneWidth / 2, y: SceneHeight / 2)
            self.addChild(background)
        } else {
            print("background not initializing")
        }
        
        paddle = Paddle()
        addChild(paddle)
        
        ball = Ball()
        addChild(ball)
        
        score = SKLabelNode(text: "Score: " + "\(paddle.getScore())")
        score.position = CGPoint(x: SceneWidth * 4 / 5, y: SceneHeight * 14 / 15)
        score.fontColor = SKColor.blackColor()
        score.fontSize = 100
        addChild(score)
    }
}
