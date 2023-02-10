//
//  GameScene.swift
//  dragRacing
//
//  Created by DEKLAN KIRK on 2/8/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var car : SKSpriteNode!
    var count = 0
    let cam = SKCameraNode()
    
    override func didMove(to view: SKView) {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        car = self.childNode(withName: "car") as? SKSpriteNode
        self.camera = cam
        }
    
    func accelerateCar(){
        count += 300
        car.physicsBody?.velocity = CGVector(dx: count, dy: 0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position.x = car.position.x    }
}
