//
//  GameViewController.swift
//  dragRacing
//
//  Created by DEKLAN KIRK on 2/8/23.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {
    
    @IBOutlet weak var raceButton: UIButton!
    
    @IBOutlet weak var acceleratorButton: UIButton!
    
    @IBOutlet weak var shiftButton: UIButton!
    
    
    var counter = 0
    var timer: Timer?
    var play: GameScene!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        
        acceleratorButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)
        acceleratorButton.addTarget(self, action: #selector(buttonUp), for: [.touchUpInside, .touchUpOutside])
        acceleratorButton.setImage(UIImage(named: "gaspedal.png"), for: .normal)
        acceleratorButton.clipsToBounds = true
        acceleratorButton.contentMode = .scaleAspectFit

//        let rpm = GaugeView(frame: CGRect(x: 45, y: 250, width: 128, height: 128))
//        rpm.backgroundColor = .clear
//            view.addSubview(rpm)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            UIView.animate(withDuration: 1) {
//                rpm.value = 33
//            }


    }
    
    @objc func buttonDown(_ sender: UIButton) {
        tinyAccel()
        timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(accelerate), userInfo: nil, repeats: true)
    }

    @objc func buttonUp(_ sender: UIButton) {
        timer?.invalidate()
    }

    func tinyAccel() {
        play.accelerateCar()
    }

    @objc func accelerate() {
        play.accelerateCar()
       // print(play.car.physicsBody?.velocity)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return.landscapeRight
    }
    
    @IBAction func raceAction(_ sender: UIButton) {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                play = scene as?  GameScene
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        raceButton.isHidden = true
        acceleratorButton.isHidden = false
        shiftButton.isHidden = false
        
    }
    
    
    @IBAction func shiftAction(_ sender: UIButton) {
        if play.gear1 == false && (play.car.physicsBody?.velocity.dx)! > 105 * 10{
            play.gear1 = true
            print("Shifted")
        }
    }
    

    
    @IBAction func acceleratorAction(_ gestureRecognizer: UILongPressGestureRecognizer) {

        
    }
    
    

}


