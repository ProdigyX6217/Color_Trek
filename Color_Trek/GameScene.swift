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
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
