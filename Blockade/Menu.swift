//
//  Menu.swift
//  Blockade
//
//  Created by Kyle Johnson on 6/1/16.
//  Copyright © 2016 Kyle Johnson. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    
    var playButton: SKSpriteNode!
    
    override init() {
        super.init(size: CGSize(width: SceneWidth, height: SceneHeight))
        self.createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.createContents()
    }
    
    private func createContents() {
        if let background: SKSpriteNode = SKSpriteNode(imageNamed: "background") {
            background.size = CGSize(width: SceneWidth, height: SceneHeight)
            background.position = CGPoint(x: SceneWidth / 2, y: SceneHeight / 2)
            self.addChild(background)
        } else {
            print("background not initializing")
        }
        
        playButton = SKSpriteNode(color: SKColor.greenColor(), size: CGSizeMake(SceneWidth / 4, SceneHeight / 10))
        playButton.position = CGPoint(x: SceneWidth / 2, y: SceneHeight / 2)
        addChild(playButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node == playButton {
                self.removeAllChildren()
                let scene = GameScene()
                let gameView = view! as SKView
                gameView.showsFPS = true
                gameView.showsNodeCount = true
                gameView.ignoresSiblingOrder = false
                scene.scaleMode = .AspectFill
                gameView.presentScene(scene)
            }
        }
    }
}
