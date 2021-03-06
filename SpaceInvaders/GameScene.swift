//
//  GameScene.swift
//  SpaceInvaders
//
//  Created by iD Student on 8/3/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let hero = SKSpriteNode(imageNamed: "Spaceship")
    
    //Gesture Recognizer Funcs
    func swipedUp(sender: UISwipeGestureRecognizer) {
        print("Up")
    }
    func swipedDown(sender: UISwipeGestureRecognizer) {
        print("Down")
    }
    func swipedLeft(sender: UISwipeGestureRecognizer) {
        print("Left")
    }
    func swipedRight(sender: UISwipeGestureRecognizer) {
        print("Right")
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        let xCoord = size.width * 0.5
        let yCoord = size.height * 0.5
        
        hero.size.height = 50
        hero.size.width = 50
        
        hero.position = CGPoint(x: xCoord, y: yCoord)
        
        addChild(hero)
        
        
    //Gesture Recognizer
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    //When the touch ends (effect of a touch)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bullet = SKSpriteNode()
        
        //Color, size, and position of bullet
        bullet.color = UIColor.red
        
        bullet.size = CGSize(width: 5, height: 5)
        
        bullet.position = CGPoint(x: hero.position.x, y: hero.position.y)
        
        //Create bullet
        addChild(bullet)
        
            //Vector movement method
            guard let touch = touches.first else { return }
        
            let touchLocation = touch.location(in: self)
        
            let vector = CGVector(dx: -(hero.position.x - touchLocation.x), dy: -(hero.position.y - touchLocation.y))
        
            //SKActions (making the bullet move)
            let projectileAction = SKAction.sequence ([
                SKAction.repeat(SKAction.move(by: vector, duration: 0.5), count: 10),
                SKAction.wait(forDuration: 0.5),
                SKAction.removeFromParent()
                ])
        //Do bullet action
        bullet.run(projectileAction)
        
        
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


// Get label node from scene and store it for use later
//self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//if let label = self.label {
//label.alpha = 0.0
//label.run(SKAction.fadeIn(withDuration: 2.0))
//}

// Create shape node to use during mouse interaction
//let w = (self.size.width + self.size.height) * 0.05
//self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)

//if let spinnyNode = self.spinnyNode {
//spinnyNode.lineWidth = 2.5

//spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//SKAction.fadeOut(withDuration: 0.5),
//SKAction.removeFromParent()]))
//}

