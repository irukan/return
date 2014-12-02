//
//  TitleViewController.swift
//  return
//
//  Created by kayama on 2014/11/25.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

import SpriteKit

class TitleViewController: UIViewController {

    var ad : AppDelegate!
    
    var titleScene : SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // AppDelegate
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Title SKView
        let titleView = SKView(frame: self.view.frame)
        self.view.addSubview(titleView)
        
        // Title Scene
        titleScene = SKScene(size: titleView.frame.size)
        titleScene.name = "title"
        titleView.presentScene(titleScene)
        
        titleScene.backgroundColor = UIColor.whiteColor()
        
        // Title Label
        let title = SKLabelNode(fontNamed: "Arial Bold")
        title.name = "titleLbl"
        title.text = "return;"
        title.fontColor = UIColor.orangeColor()
        title.fontSize = 60
        title.position = CGPointMake(ad.WWidth * 0.5, ad.WHeight * 0.7)
        titleScene.addChild(title)
        
        // GameStart Label
        let start = SKLabelNode(fontNamed: "Arial Bold")
        start.name = "start"
        start.text = "Game Start"
        start.fontColor = UIColor.grayColor()
        start.fontSize = 30
        start.position = CGPointMake(ad.WWidth*0.5, ad.WHeight*0.4)
        titleScene.addChild(start)
        
        // Config Label
        let config = SKLabelNode(fontNamed: "Arial Bold")
        config.name = "config"
        config.text = "Config"
        config.fontColor = UIColor.grayColor()
        config.fontSize = 30
        config.position = CGPointMake(ad.WWidth*0.5, ad.WHeight*0.3)
        titleScene.addChild(config)
        
    }
    
  
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchPos = touch.locationInNode(titleScene)
        let touchNode = titleScene.nodeAtPoint(touchPos)
        
        switch touchNode.name!
        {
            case "start":
                self.presentViewController(ad.gameView, animated: true, completion: nil)
                ad.gameView.initGameScene()
            case "config":
                println("config")
            default :
                // もっといい方法ないか??
                var i = 0
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
