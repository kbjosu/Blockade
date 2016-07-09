//
//  Paddle.swift
//  Blockade
//
//  Created by Kyle Johnson on 5/4/16.
//  Copyright © 2016 Kyle Johnson. All rights reserved.
//

import Foundation
import SpriteKit

class Paddle: SKSpriteNode {
    
    enum Motions {
        case Right
        case Left
        case None
    }
    
    static let Category: UInt32 = 0x1 << 2
    let Texture: SKTexture = SKTexture(imageNamed: "paddle")
    let Size: CGSize = CGSizeMake(300, 50)
    let Speed: CGFloat = 5
    
    var score: Int = 0
    var motion: Motions = .None
    
    init () {
        super.init(texture: Texture, color: SKColor.clearColor(), size: Size)
        self.name = "paddle node"
        self.position.x = SceneWidth / 2
        self.position.y = SceneHeight / 10
        setPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Size.width, height: Size.height))
        if let body = self.physicsBody {
            body.usesPreciseCollisionDetection = true
            body.categoryBitMask = Paddle.Category
            body.collisionBitMask = Paddle.Category | Ball.Category | GameScene.WallCategory
            body.contactTestBitMask = Paddle.Category | Ball.Category
            body.affectedByGravity = false
            body.restitution = 0
            body.allowsRotation = false
            body.friction = 0
            body.mass = 100000000
        } else {
            print("Paddle physics body not initialized")
        }
    }
    
    func move(location: CGPoint) {
        self.physicsBody!.velocity = CGVector(dx: (location.x - self.position.x) * Speed, dy: 0)
    }
    
    func stop() {
        self.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func getScore() -> Int {
        return score
    }
    
    func incrementScore() {
        score += 1
    }
}

