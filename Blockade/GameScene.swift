//
//  GameScene.swift
//  Blockade
//
//  Created by Kyle Johnson on 4/25/16.
//  Copyright (c) 2016 Kyle Johnson. All rights reserved.
//

import SpriteKit

let SCENE_WIDTH: CGFloat = 1242
let SCENE_HEIGHT: CGFloat = 2208

class GameScene: SKScene {
    
    var ball: Ball!
    var paddle: Paddle!
    var lastTouch: CGPoint?
    
    override init() {
        super.init(size: CGSize(width: SCENE_WIDTH, height: SCENE_HEIGHT))
        if let scene = self.scene {
            scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: scene.frame)
            if let body = self.physicsBody {
                body.friction = 0
            } else {
                print("Scene physics body not initialized")
            }
        } else {
            print("Scene not initialized")
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.createContents()
        
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
        
        if ball.position.y < SCENE_HEIGHT / 12 {
            stopGame()
        }
    }
    
    func stopGame() {
        self.restartGame()
    }
    
    func restartGame() {
        self.removeAllChildren()
        self.removeAllActions()
        self.createContents()
    }
    
    func createContents() {
        if let background: SKSpriteNode = SKSpriteNode(imageNamed: "background") {
            background.size = CGSize(width: SCENE_WIDTH, height: SCENE_HEIGHT)
            background.position = CGPoint(x: SCENE_WIDTH / 2, y: SCENE_HEIGHT / 2)
            self.addChild(background)
        } else {
            print("background not initializing")
        }
        
        paddle = Paddle()
        addChild(paddle)
        
        ball = Ball()
        addChild(ball)
    }
}
