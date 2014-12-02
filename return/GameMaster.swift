//
//  GameMaster.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/10/18.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import Foundation
import SPriteKit

class GameMaster: GameSceneDelegate
{
    var scenePtr:GameScene!
    var m_execCmd:Int?
    var ad: AppDelegate!
    
    var parentViewC : GameViewController!
    
    init()
    {
        // AppDelegate
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        parentViewC = ad.gameView
        
    }

    // delegate 実装
    func endAnimation() {
        //アニメーションの終わり
        if(m_execCmd != 0)
        {
            showExecCnt()
        }
        else
        {
            showGameOver()
        }
    }
    // delegate 実装
    func reachGoal()
    {
        showGoal()
        //次のAction 選択作る
    }
    
    func setScene(scene: SKScene)
    {
        scenePtr = scene as GameScene
        scenePtr.Mydelegate = self
    }

    func setExecCnt(cnt:Int)
    {
        m_execCmd = cnt
        showExecCnt()
    }
    
    func execCmd()
    {
        m_execCmd = m_execCmd! - 1
    }
    
    func showExecCnt()
    {
        //前回のやつ消す
        scenePtr.childNodeWithName("ExecCmdLbl")?.removeFromParent()
        
        var lbl:SKLabelNode = SKLabelNode()
        lbl.name = "ExecCmdLbl"
        lbl.fontSize = 20.0
        lbl.fontColor = SKColor.redColor()
        
        lbl.text = "残り : " + "\(m_execCmd!)"
        lbl.position = CGPointMake(50, 10)
        scenePtr.addChild(lbl)
    }
    
    func showStart()
    {
        var lbl = SKLabelNode()
        lbl.name = "StartLbl"
        
        lbl.text = "Game Start!!"
        lbl.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height)
        
        scenePtr.addChild(lbl)
        
        //表示から消すまでのアニメーション
        let moveDown = SKAction.moveTo(CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/2.0), duration: 0.5)
        let wait = SKAction.waitForDuration(0.5)
        let sequence = SKAction.sequence([wait,moveDown, wait])
        
        lbl.runAction(sequence, completion: {() ->Void in
            lbl.removeFromParent()
        })
    }
    
    func showGameOver()
    {
        var lbl = SKLabelNode()
        lbl.name = "GameOverLbl"
        
        lbl.text = "Game over!!"
        lbl.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/2.0)
        
        scenePtr.addChild(lbl)
        
        //表示から消すまでのアニメーション
        let wait = SKAction.waitForDuration(3.0)
        let sequence = SKAction.sequence([wait])


        lbl.runAction(sequence, completion: {() ->Void in
            self.parentViewC.dismissViewControllerAnimated(true, completion:nil)
        })
    }
    
    func showGoal()
    {
//        // Particle 表示
//        let path:String = NSBundle.mainBundle().pathForResource("GoalScene", ofType: "sks")!
//        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as SKEmitterNode
//        particle.particleScale = 0.3
//        particle.particleLifetime = 3.0
//        particle.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/0.7)
//        scenePtr.addChild(particle)
        
        
        
        var lbl = SKLabelNode()
        lbl.name = "GoalLbl"
        
        lbl.text = "Goal !!"
        lbl.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height)

        scenePtr.addChild(lbl)
        //表示から消すまでのアニメーション
        let moveDown = SKAction.moveTo(CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/2.0), duration: 0.5)
        let wait1 = SKAction.waitForDuration(1.0)
        let wait2 = SKAction.waitForDuration(2.0)
        let sequence = SKAction.sequence([moveDown, wait1, wait2])
        
        lbl.runAction(sequence, completion: {() ->Void in
            self.parentViewC.initGameScene("data1")
        })

   
    }
}