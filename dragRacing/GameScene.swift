//
//  GameScene.swift
//  dragRacing
//
//  Created by DEKLAN KIRK on 2/8/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let rgear = [33.5, 77.5, 137.5, 200, 262.5, 325, 387.5]
    let rpm = GaugeView(frame: CGRect(x: 45, y: 250, width: 128, height: 128))
//    let mph = GaugeView(frame: CGRect(x: 210, y: 250, width: 128, height: 128))
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var car : SKSpriteNode!
    var car2 : SKSpriteNode!
    var count = 1
    let cam = SKCameraNode()
    var stopRed : SKSpriteNode!
    var stopYellow1 : SKSpriteNode!
    var stopYellow2 : SKSpriteNode!
    var stopGreen : SKSpriteNode!
    var winLabel : SKLabelNode!
    var firework1 : SKEmitterNode!
    var firework2 : SKEmitterNode!
    var falseStart = true
    var mphVal = 0
    var gear1 = false
    var gear2 = false
    var gear3 = false
    var gear4 = false
    var gear5 = false
    var gear6 = false
    var pgear0 = false
    var pgear1 = false
    var pgear2 = false
    var pgear3 = false
    var pgear4 = false
    var pgear5 = false
    var pgear6 = false
    var gearcounter = 0
    var raceover = false


    
    override func didMove(to view: SKView) {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        

        
        car = self.childNode(withName: "car") as? SKSpriteNode
        car2 = self.childNode(withName: "car2") as? SKSpriteNode
        stopRed = self.childNode(withName: "stopRed") as? SKSpriteNode
        stopYellow1 = self.childNode(withName: "stopYellow1") as? SKSpriteNode
        stopYellow2 = self.childNode(withName: "stopYellow2") as? SKSpriteNode
        stopGreen = self.childNode(withName: "stopGreen") as? SKSpriteNode
        winLabel = self.childNode(withName: "winLabel") as? SKLabelNode
        firework1 = self.childNode(withName: "firework1") as? SKEmitterNode
        firework2 = self.childNode(withName: "firework2") as? SKEmitterNode


        
        winLabel.isHidden = true
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
        
        rpm.backgroundColor = .clear
        view.addSubview(rpm)
//        mph.backgroundColor = .clear
//        view.addSubview(mph)
        
    }

    
    func restartApplication () {
        let viewController = GameViewController()
        let navCtrl = UINavigationController(rootViewController: viewController)

        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController

        else {
            return
        }

        navCtrl.view.frame = rootViewController.view.frame
        navCtrl.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navCtrl
        })
    }
    
    func accelerateCar(){
        //car.physicsBody?.velocity = CGVector(dx: count, dy: 0)
        if (car.physicsBody?.velocity.dx)! < 75 * 10 && falseStart == false && gear1 == false{
            car.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
        }
        else if gear1 == true && (car.physicsBody?.velocity.dx)! < 155 * 10{
            car.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
        }
        else if gear2 == true && (car.physicsBody?.velocity.dx)! < 275 * 10{
            car.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))

        }
        else if gear3 == true && (car.physicsBody?.velocity.dx)! < 400 * 10{
            car.physicsBody?.applyImpulse(CGVector(dx: 3.4, dy: 0))

        }
        else if gear4 == true && (car.physicsBody?.velocity.dx)! < 525 * 10{
            car.physicsBody?.applyImpulse(CGVector(dx: 3.4, dy: 0))

        }
        else if gear5 == true && (car.physicsBody?.velocity.dx)! < 650 * 10{
            car.physicsBody?.applyImpulse(CGVector(dx: 3.4, dy: 0))

        }
        else if gear6 == true && (car.physicsBody?.velocity.dx)! < 775 * 10{
            car.physicsBody?.applyImpulse(CGVector(dx: 3.5, dy: 0))

        }
        
        if car.position.x > 77500 && car.position.x > car2.position.x && raceover == false{
            print("car1 wins!")
            self.pgear6 = false
            self.pgear5 = false
            self.pgear0 = true
            car.physicsBody?.linearDamping = 150
            car2.physicsBody?.linearDamping = 150
            winLabel.text = "You Win!"
            winLabel.position.x = cam.position.x
            winLabel.isHidden = false
            firework1.position = CGPoint(x: 77030.852, y: -20.012)
            firework2.position = CGPoint(x: 78080, y: -20.012)
            raceover = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
//                self.restart()
//            }



        }
        else if car2.position.x > 77500 && car.position.x < car2.position.x && raceover == false{
            print("car2 wins!")
            self.pgear6 = false
            self.pgear5 = false
            self.pgear0 = true
            winLabel.text = "You Lose :("
            winLabel.position.x = cam.position.x
            winLabel.isHidden = false
            car.physicsBody?.linearDamping = 150
            car2.physicsBody?.linearDamping = 150
            raceover = true

        }
        
        
    }
    
    func moveCar2(){
        if (car2.physicsBody?.velocity.dx)! < 75 * 10 && pgear1 == false{
            car2.physicsBody?.applyImpulse(CGVector(dx: 3.2, dy: 0))
        }
        else if pgear1 == true && (car2.physicsBody?.velocity.dx)! < 155 * 10{
            car2.physicsBody?.applyImpulse(CGVector(dx: 3.3, dy: 0))
        }
        else if pgear2 == true && (car2.physicsBody?.velocity.dx)! < 275 * 10{
            car2.physicsBody?.applyImpulse(CGVector(dx: 3.3, dy: 0))
        }
        else if pgear3 == true && (car2.physicsBody?.velocity.dx)! < 400 * 10{
            car2.physicsBody?.applyImpulse(CGVector(dx: 4.1, dy: 0))
        }
        else if pgear4 == true && (car2.physicsBody?.velocity.dx)! < 525 * 10{
            car2.physicsBody?.applyImpulse(CGVector(dx: 3.5, dy: 0))
        }
        else if pgear5 == true && (car2.physicsBody?.velocity.dx)! < 650 * 10{
            car2.physicsBody?.applyImpulse(CGVector(dx: 3.7, dy: 0))
        }
        else if pgear6 == true && (car2.physicsBody?.velocity.dx)! < 775 * 10{
            car2.physicsBody?.applyImpulse(CGVector(dx: 3.4, dy: 0))
        }
        else if pgear0 == true{
            car2.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.moveCar2()
        }
        cam.position.x = car.position.x
        
        self.rpm.value2 = gearcounter
        self.rpm.value = Int((self.car.physicsBody?.velocity.dx)!) / 10
        mphVal = Int((self.car.physicsBody?.velocity.dx)!)  / 10

        if gear1 == true && pgear1 == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.pgear1 = true
                self.car2.physicsBody?.applyImpulse(CGVector(dx: -1.6, dy: 0))
            }
        }
        if gear2 == true && pgear2 == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.pgear2 = true
                self.car2.physicsBody?.applyImpulse(CGVector(dx: -1.3, dy: 0))
            }
        }
        if gear3 == true && pgear3 == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.pgear3 = true
                self.car2.physicsBody?.applyImpulse(CGVector(dx: -1.1, dy: 0))
            }
        }
        if gear4 == true && pgear4 == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.pgear4 = true
                self.car2.physicsBody?.applyImpulse(CGVector(dx: -0.9, dy: 0))
            }
        }
        if gear5 == true && pgear5 == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.pgear5 = true
                self.car2.physicsBody?.applyImpulse(CGVector(dx: -0.6, dy: 0))
            }
        }
        
        if raceover == true{
            winLabel.position.x = cam.position.x
        }
        
 
        
    }
    
    
    
    
}
