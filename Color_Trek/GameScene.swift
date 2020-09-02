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
    
//    Called as scene is presented in the SKView
    override func didMove(to view: SKView) {
        setUpTracks()
        
//        accessed first track(0) and changed color to test if app updated
        tracksArray?.first?.color = UIColor.green
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
