//
//  StartScene.swift
//  Color_Trek
//
//  Created by Student Laptop_7/19_1 on 9/7/20.
//  Copyright © 2020 Makeschool. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    
    var playButton:SKSpriteNode?
    var gameScene:SKScene!
    var backgroundMusic: SKAudioNode!
    
    var scrollingBG:ScrollingBackground?
    
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "startButton") as? SKSpriteNode
        
        scrollingBG = ScrollingBackground.scrollingNodeWithImage(imageName: "loopBG", containerWidth: self.size.width)
        scrollingBG?.scrollingSpeed = 1.5
        scrollingBG?.anchorPoint = .zero
        
        self.addChild(scrollingBG!)
        
        
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
//                Start Game Transition
                let transition = SKTransition.fade(withDuration: 1)
                gameScene = SKScene(fileNamed: "GameScene")
                gameScene.scaleMode = .aspectFit
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if let scrollBG = self.scrollingBG {
            scrollBG.update(currentTime: currentTime)
        }
    }
}
