//
//  GameScene.swift
//  Food Game
//
//  Created by Brandon Campbell on 4/20/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var scoreLabel: SKLabelNode?
    private var missesLeftLabel: SKLabelNode?
    private var startLabel: SKLabelNode?
    private var gameOverLabel: SKLabelNode?
    private var yourScoreLabel: SKLabelNode?
    private var groceryBagSprite: SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    
    var gameTimer: Timer!
    var gameRunning = false
    
    var foodImagePaths = ["chickenn.jpg", "iceCream.jpg", "lettuce.jpg", "pastaa.jpg", "sushii.jpg"]
    
    
    override func didMove(to view: SKView) {
        
        // Access all game UI elements
        self.scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        self.missesLeftLabel = self.childNode(withName: "missesLeftLabel") as? SKLabelNode
        self.startLabel = self.childNode(withName: "startLabel") as? SKLabelNode
        self.gameOverLabel = self.childNode(withName: "gameOverLabel") as? SKLabelNode
        self.yourScoreLabel = self.childNode(withName: "yourScoreLabel") as? SKLabelNode
        self.groceryBagSprite = self.childNode(withName: "groceryBag") as? SKSpriteNode
        
        // Hide elements
        self.gameOverLabel?.isHidden = true
        self.yourScoreLabel?.isHidden = true
        self.groceryBagSprite?.isHidden = true
        
        // Start game timer
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateGame)
        gameRunning = true
        
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    func updateGame (timer: Timer) {
        print("Timer tick lol")
        
        // Randomly select food image, create sprite, place randomly on upper half of screen
        let foodImagePath = self.foodImagePaths.randomElement()!
        var foodNode: SKSpriteNode
        foodNode = SKSpriteNode(imageNamed: foodImagePath)
        foodNode.name = "Food"
        foodNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: foodNode.frame.width, height: foodNode.frame.width))
        foodNode.physicsBody?.contactTestBitMask = 1
        let width = self.view!.frame.width
        let height = self.view!.frame.height
        let x = Int.random(in: -Int(width)/2 ..< Int(width))
        let y = Int.random(in: 0 ..< Int(height))
        foodNode.position = CGPoint(x: x, y: y)
        self.addChild(foodNode)
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
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
