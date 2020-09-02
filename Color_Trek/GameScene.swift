//
//  GameScene.swift
//  Color_Trek
//
//  Created by Student Laptop_7/19_1 on 9/1/20.
//  Copyright © 2020 Makeschool. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    Array of SKSpriteNodes(tracks)
    var tracksArray:[SKSpriteNode]? = [SKSpriteNode]()
    var player:SKSpriteNode?
    
    
    func setUpTracks(){
//        Iterates through tracks(child nodes)
        for i in 0 ... 8 {
//     converts tracks(childNodes) into SKSpriteNodes
            if let track = self.childNode(withName: "\(i)") as? SKSpriteNode{
//                appends tracks to array
                tracksArray?.append(track)
            }
        }
    }
    
    
    func createPlayer(){
//        Player Initialized
        player = SKSpriteNode(imageNamed: "player")
//        Create Player Position Constant by using tracks Array
        guard let playerPosition = tracksArray?.first?.position.x else {return}
//        Player Position Orientation
        player?.position = CGPoint(x: playerPosition, y: self.size.height / 2)
        
//        Add to node tree
        self.addChild(player!)
    }
    
    
//    Called as scene is presented in the SKView
    override func didMove(to view: SKView) {
        setUpTracks()
        createPlayer()
        
//        accessed first track(0) and changed color to test if app updated
        tracksArray?.first?.color = UIColor.green
    }
    
    
    func moveVertically (up:Bool) {
        if up {
//            Move Player UP
            let moveAction = SKAction.moveBy(x: 0, y: 3, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        }else{
//            Move Player DOWN
            let moveAction = SKAction.moveBy(x: 0, y: -3, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        Using touches Set and accessing first object
        if let touch = touches.first{
//            Retrieving location from the root node(self
            let location = touch.previousLocation(in: self)
//            Passing in location and getting first touch
            let node = self.nodes(at: location).first
            
            if node?.name == "right" {
                print("RIGHT")
            } else if node?.name == "up"{
                moveVertically(up: true)
            } else if node?.name == "down" {
                moveVertically(up: false)
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
