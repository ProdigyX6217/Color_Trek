//
//  GameScene.swift
//  Color_Trek
//
//  Created by Student Laptop_7/19_1 on 9/1/20.
//  Copyright © 2020 Makeschool. All rights reserved.
//

import SpriteKit
import GameplayKit

//  3 Enemy types
enum Enemies: Int{
    case small
    case medium
    case large
}

class GameScene: SKScene {
    
//    Array of SKSpriteNodes(tracks)
    var tracksArray:[SKSpriteNode]? = [SKSpriteNode]()
    var player:SKSpriteNode?
    
//    Tracking which track the player is currently on
    var currentTrack = 0
    var movingToTrack = false
    
//    moveSound
    let moveSound = SKAction.playSoundFileNamed("move.wav", waitForCompletion: false)
    
    let trackVelocities = [180, 200, 250]
    var directionArray = [Bool]()
    var velocityArray = [Int]()
    
    
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
        
        let pulse = SKEmitterNode(fileNamed: "pulse")!
        player?.addChild(pulse)
        pulse.position = CGPoint(x: 0,y: 0)
    }
    
    
    func createEnemy(type: Enemies, forTrack track: Int) -> SKShapeNode?{
        
        let enemySprite = SKShapeNode()
        enemySprite.name = "ENEMY"
        
        switch type {
//            Enemy Sprite defined path, picked color
        case .small:
            enemySprite.path = CGPath(roundedRect: CGRect(x: -10, y: 0, width: 20, height: 70), cornerWidth: 8, cornerHeight: 8, transform: nil)
            enemySprite.fillColor = UIColor(red: 0.4431, green: 0.5529, blue: 0.7451, alpha: 1)
        case .medium:
            enemySprite.path = CGPath(roundedRect: CGRect(x: -10, y: 0, width: 20, height: 100), cornerWidth: 8, cornerHeight: 8, transform: nil)
            enemySprite.fillColor = UIColor(red: 0.7804, green: 0.4039, blue: 0.4039, alpha: 1)
        case .large:
            enemySprite.path = CGPath(roundedRect: CGRect(x: -10, y: 0, width: 20, height: 130), cornerWidth: 8, cornerHeight: 8, transform: nil)
            enemySprite.fillColor = UIColor(red: 0.7804, green: 0.6392, blue: 0.4039, alpha: 1)
        }
        
//        Available Enemy Position
        guard let enemyPosition = tracksArray?[track].position else {return nil}
        
        let up = directionArray[track]
        
        enemySprite.position.x = enemyPosition.x
        enemySprite.position.y = up ? -130 : self.size.height + 130
         
        enemySprite.physicsBody = SKPhysicsBody(edgeLoopFrom: enemySprite.path!)
        enemySprite.physicsBody?.velocity = up ? CGVector(dx: 0, dy: velocityArray[track]) : CGVector(dx: 0, dy: -velocityArray[track])
            
        return enemySprite
    }
    
    
    func spawnEnemies () {
        for i in 1 ... 7 {
            let randomEnemyType = Enemies(rawValue: GKRandomSource.sharedRandom().nextInt(upperBound: 3))!
            if let newEnemy = createEnemy(type: randomEnemyType, forTrack: i) {
                self.addChild(newEnemy)
            }
        }
        
        self.enumerateChildNodes(withName: "ENEMY") {   (node: SKNode, nil) in
            if node.position.y < -150 || node.position.y > self.size.height + 150 {
                node.removeFromParent()
            }
    }
        
    }
        
    
//    Called as scene is presented in the SKView
    override func didMove(to view: SKView) {
        setUpTracks()
        createPlayer()
        
        if let numberOfTracks = tracksArray?.count {
            for _ in 0 ... numberOfTracks {
                let randomVelocity = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
                velocityArray.append(trackVelocities[randomVelocity])
                directionArray.append(GKRandomSource.sharedRandom().nextBool())
            }
    }
        
//        Calling Spawn Enemies()
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.spawnEnemies()
            }, SKAction.wait(forDuration: 2)])))
        
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
    
    
    func moveToNextTrack(){
//        stopping all player actions
        player?.removeAllActions()
        movingToTrack = true

//        Calculate next available track
        guard let nextTrack = tracksArray?[currentTrack + 1].position else {return}

//        Check if player is available/ have player move horizontally
        if let player = self.player {
            let moveAction = SKAction.move(to: CGPoint(x: nextTrack.x, y: player.position.y), duration: 0.2)
            player.run(moveAction, completion: {
                self.movingToTrack = false
            })
            
            currentTrack += 1
            
//            Sound plays when player moves
            self.run(moveSound)
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
                moveToNextTrack()
            } else if node?.name == "up"{
                moveVertically(up: true)
            } else if node?.name == "down" {
                moveVertically(up: false)
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingToTrack{
            player?.removeAllActions()
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
        
}
