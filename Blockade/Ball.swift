//
//  Ball.swift
//  Blockades
//
//  Created by Kyle Johnson on 5/4/16.
//  Copyright © 2016 Kyle Johnson. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    static let Category: UInt32 = 0x1 << 1
    let Radius: CGFloat = 50
    let Speed: CGFloat = 1000
    
    init() {
        if let Texture: SKTexture = SKTexture(imageNamed: "ball") {
            super.init(texture: Texture, color: SKColor.blackColor(), size: Texture.size())
            self.position.x = SceneWidth / 2
            self.position.y = SceneHeight / 2
            self.name = "ball node"
            setPhysics()
        } else {
            super.init()
            print("invalid ball texture")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        if let body = self.physicsBody {
            body.usesPreciseCollisionDetection = true
            body.categoryBitMask = Ball.Category
            body.collisionBitMask = Ball.Category | Paddle.Category | GameScene.WallCategory
            body.contactTestBitMask = Paddle.Category | Ball.Category
            body.affectedByGravity = false
            body.restitution = 1  //"bounciness" of ball
            body.allowsRotation = true
            body.angularDamping = 0
            body.linearDamping = 0
            body.friction = 0
            body.velocity = randomVelocity()
            body.mass = 1
        } else {
            print("Ball physics body not initialized")
        }
    }
    
    
    //creates vector with random direction within 45-135 degrees and 225-315 degrees scaled by speed
    private func randomVelocity() -> CGVector {
        //let decider = arc4random_uniform(2)
        var dx: CGFloat = 0
        var dy: CGFloat = 0
        /*
        if decider == 0 {
            dx = cos(CGFloat(arc4random_uniform(91) + 45) * CGFloat(M_PI / 180)) * BALL_SPEED
            dy = sin(CGFloat(arc4random_uniform(91) + 45) * CGFloat(M_PI / 180)) * BALL_SPEED
        
        }
        else if decider == 1 {
         */
            dx = cos(CGFloat(arc4random_uniform(91) + 225) * CGFloat(M_PI / 180)) * Speed
            dy = sin(CGFloat(arc4random_uniform(91) + 225) * CGFloat(M_PI / 180)) * Speed
        //}
        return CGVectorMake(dx, dy)
    }
}
