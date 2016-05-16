//
//  Ball.swift
//  Blockades
//
//  Created by Kyle Johnson on 5/4/16.
//  Copyright © 2016 Kyle Johnson. All rights reserved.
//

import Foundation
import SpriteKit

let BALL_TEXTURE: SKTexture = SKTexture(imageNamed: "ball")
let BALL_RADIUS: CGFloat = 50
let BALL_SPEED: CGFloat = 1000

class Ball: SKSpriteNode {
    
    init() {
        super.init(texture: BALL_TEXTURE, color: SKColor.clearColor(), size: CGSizeMake(BALL_RADIUS * 2, BALL_RADIUS * 2))
        setPosition()
        setPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPosition() {
        self.position.x = SCENE_WIDTH / 2
        self.position.y = SCENE_HEIGHT / 2
    }
    
    private func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: BALL_RADIUS)
        if let body = self.physicsBody {
            body.affectedByGravity = false
            body.restitution = 1.0  //"bounciness" of ball
            body.allowsRotation = true
            body.angularDamping = 0
            body.linearDamping = 0
            body.friction = 0
            body.velocity = randomVelocity()
            body.mass = 0
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
            dx = cos(CGFloat(arc4random_uniform(91) + 225) * CGFloat(M_PI / 180)) * BALL_SPEED
            dy = sin(CGFloat(arc4random_uniform(91) + 225) * CGFloat(M_PI / 180)) * BALL_SPEED
        //}
        return CGVectorMake(dx, dy)
    }
}
