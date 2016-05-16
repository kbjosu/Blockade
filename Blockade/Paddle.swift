//
//  Paddle.swift
//  Blockade
//
//  Created by Kyle Johnson on 5/4/16.
//  Copyright © 2016 Kyle Johnson. All rights reserved.
//

import Foundation
import SpriteKit

let PADDLE_TEXTURE: SKTexture = SKTexture(imageNamed: "paddle")
let PADDLE_SIZE: CGSize = CGSizeMake(300, 50)
let PADDLE_SPEED: CGFloat = 5

class Paddle: SKSpriteNode {
    enum Motions {
        case Right
        case Left
        case None
    }
    
    
    var motion: Motions = .None
    
    init () {
        super.init(texture: PADDLE_TEXTURE, color: SKColor.clearColor(), size: PADDLE_SIZE)
        setPosition()
        setPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setPosition() {
        self.position.x = SCENE_WIDTH / 2
        self.position.y = SCENE_HEIGHT / 10
    }
    
    private func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: PADDLE_SIZE.width, height: PADDLE_SIZE.height))
        if let body = self.physicsBody {
            body.affectedByGravity = false
            body.restitution = 1.0
            body.allowsRotation = false
            body.friction = 0
            body.linearDamping = 1
            body.angularDamping = 1
            body.mass = 100000
        } else {
            print("Paddle physics body not initialized")
        }
    }
    
    func move(location: CGPoint) {
        self.physicsBody!.velocity = CGVector(dx: (location.x - self.position.x) * PADDLE_SPEED, dy: 0)

    }
    
    func stop() {
        self.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
    }
}

