//
//  GameViewController.swift
//  return
//
//  Created by kayama on 2014/11/26.
//  Copyright (c) 2014年 kayama. All rights reserved.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController, DDEditorDelegate {

    var ad : AppDelegate!
    
    var interpreter: MyInterpreter!
    var gmMaster: GameMaster!
    
    var debugArea: UITextView!
    var ddEditorCover : UIButton!
    var ddEditor: DDEditor!
    
    var skView: SKView!
    var gmScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // AppDelegate
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        // SKView
        skView = SKView(frame: CGRectMake(0,0, ad.SWidth, ad.SHeight))
        skView.showsFPS = true;
        skView.showsNodeCount = true
        self.view.addSubview(skView)
        
        // Tools
        interpreter = MyInterpreter()
        gmMaster = GameMaster()
        
        // DDEditor
        ddEditor = DDEditor(frame: ad.window!.frame)
        
        // DebugArea
        debugArea = UITextView(frame: CGRectMake(ad.WWidth / 2.0, ad.SHeight, ad.WWidth / 2.0, ad.WHeight - ad.SHeight))
        debugArea.layer.borderWidth = 2
        debugArea.layer.borderColor = UIColor.redColor().CGColor
        debugArea.layer.cornerRadius = 4
        debugArea.editable = false
        self.view.addSubview(debugArea)
        
        // ddEditorを覆う透明なCover
        ddEditorCover = UIButton(frame: ddEditor.tblView.tableView.frame)
        ddEditorCover.addTarget(self, action: "pushCover:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(ddEditorCover)
        

     }
    

    func initGameScene()
    {
        
        // DDEditor
        ddEditor.clearTable()
        ddEditor.setTableViewMode("debugView", setView: self.view)
        ddEditor.delegate = self
        
        self.view.addSubview(ddEditorCover)
        
        // DebugArea
        self.view.addSubview(debugArea)
        
        // SKScene
        //scene1
        gmScene = GameScene(dataName: "data2")
        gmScene.backgroundColor = SKColor.grayColor()
        skView.presentScene(gmScene)
        
    }
    
     
    func pushCover(sender:UIButton)
    {
        ddEditor.setTableViewMode("inputView", setView: ddEditor.view)
        self.presentViewController(ddEditor, animated: true, completion: nil)
    }
    
    //delegate実装
    func editFinish() {
        
        ddEditor.setTableViewMode("debugView", setView: self.view)
        ddEditor.delegate = self
        // ddEditorを覆う透明なCover
        let ddEditorCover : UIButton = UIButton(frame: ddEditor.tblView.tableView.frame)
        ddEditorCover.addTarget(self, action: "pushCover:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(ddEditorCover)
        
        gmScene.isAnimated = true
        
        let strArr:NSArray = ddEditor.tblView.getSourceData()
        self.interpreter.setRawLine(strArr)
        
        self.gmMaster.execCmd()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
