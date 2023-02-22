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
    var car2 : SKSpriteNode!
    var count = 0
    let cam = SKCameraNode()
    var stopRed : SKSpriteNode!
    var stopYellow1 : SKSpriteNode!
    var stopYellow2 : SKSpriteNode!
    var stopGreen : SKSpriteNode!
    var falseStart = true
    let mph = GaugeView(frame: CGRect(x: 45, y: 250, width: 128, height: 128))
    
    
    
    
    
    override func didMove(to view: SKView) {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        car = self.childNode(withName: "car") as? SKSpriteNode
        car2 = self.childNode(withName: "car2") as? SKSpriteNode
        stopRed = self.childNode(withName: "stopRed") as? SKSpriteNode
        stopYellow1 = self.childNode(withName: "stopYellow1") as? SKSpriteNode
        stopYellow2 = self.childNode(withName: "stopYellow2") as? SKSpriteNode
        stopGreen = self.childNode(withName: "stopGreen") as? SKSpriteNode
        
        stopRed.isHidden = true
        stopYellow1.isHidden = true
        stopYellow2.isHidden = true
        stopGreen.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopRed.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.stopRed.isHidden = true
            self.stopYellow1.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.stopYellow1.isHidden = true
            self.stopYellow2.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.stopYellow2.isHidden = true
            self.stopGreen.isHidden = false
            self.falseStart = false
        }
        
        self.camera = cam
        
        mph.backgroundColor = .clear
        view.addSubview(mph)
    }
    
    func resetScene(){
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view! as SKView

            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true

            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.size = skView.bounds.size

            skView.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
        }
    }
    
    func accelerateCar(){
        count += 300
        //car.physicsBody?.velocity = CGVector(dx: count, dy: 0)
        if falseStart == false{
            car.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
        }
        else if falseStart == true{
            //resetScene()
        }
    }
    
    func moveCar2(){
        car2.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
    }
    
    override func update(_ currentTime: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.moveCar2()
        }
        cam.position.x = car.position.x

        //mph.value = Int((car.physicsBody?.velocity.dx)!) / 10
        

    }
}
