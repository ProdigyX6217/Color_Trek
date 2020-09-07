//
//  GameOverScene.swift
//  Color_Trek
//
//  Created by Student Laptop_7/19_1 on 9/7/20.
//  Copyright © 2020 Makeschool. All rights reserved.
//

import SpriteKit

class GameOverScene : SKScene {
    
    var lastScoreLabel:SKLabelNode?
    var bestScoreLabel:SKLabelNode?
    
    var playButton:SKSpriteNode?
    
    var backgroundMusic: SKAudioNode!
    
    override func didMove(to view: SKView) {
        lastScoreLabel = self.childNode(withName: "lastScoreLabel") as? SKLabelNode
        bestScoreLabel = self.childNode(withName: "bestScoreLabel") as? SKLabelNode
    
        lastScoreLabel?.text = "\(GameHandler.sharedInstance.score)"
        bestScoreLabel?.text = "\(GameHandler.sharedInstance.highScore)"
        
        playButton = self.childNode(withName: "startButton") as? SKSpriteNode
        
        if let musicURL = Bundle.main.url(forResource: "MenuHighscoreMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                let transition = SKTransition.fade(withDuration: 1)
                if let gameScene = SKScene(fileNamed: "GameScene") {
                    gameScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameScene, transition: transition)
                }
                
            }
        }
    }
    
}
