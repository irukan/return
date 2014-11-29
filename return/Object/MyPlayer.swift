//
//  MyPlayer.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/10/01.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit

enum direction:Int
{
    case right = 0
    case left  = 1
    case up    = 2
    case down  = 3
}


class MyPlayer: MyObjectBase {

    var m_direct:direction!
    
    var frontImgTextures:NSArray!
    var rightImgTextures:NSArray!
    var backImgTextures:NSArray!
    var leftImgTextures:NSArray!
    
    let playerSpeed:NSTimeInterval = 0.5
    
    
    init(cellSize:CGFloat, indexX:Int, indexY:Int)
    {
        super.init(cellSize:cellSize, indexX:indexX, indexY:indexY, isThrough:false)
        
        backImgTextures  = [self.ad.ImgMas.player[0], self.ad.ImgMas.player[1], self.ad.ImgMas.player[2]] as NSArray
        rightImgTextures = [self.ad.ImgMas.player[3], self.ad.ImgMas.player[4], self.ad.ImgMas.player[5]] as NSArray
        leftImgTextures  = [self.ad.ImgMas.player[6], self.ad.ImgMas.player[7], self.ad.ImgMas.player[8]] as NSArray
        frontImgTextures = [self.ad.ImgMas.player[9], self.ad.ImgMas.player[10], self.ad.ImgMas.player[11]] as NSArray

        //最初は、右向き
        m_direct = direction.right
        self.texture = self.ad.ImgMas.player[3] as? SKTexture
        
        self.name = "player"
        

        //playerは一番上に
        self.zPosition = 100.0
                
        //self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        //self.physicsBody?.affectedByGravity = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getPosByIndex() ->(Int, Int)
    {
        return getIndexByPosition(self.position.x, posY: self.position.y)    
    }
    
    func isGoal(goalObj: MyObjectBase)->Bool
    {
        return self.containsPoint(goalObj.position)
    }
    
    func getFront()->String
    {
        let parentScene = self.scene! as GameScene
        var frontPos:CGPoint
        
        if (m_direct == direction.right)
        { frontPos = CGPointMake(self.position.x + m_cell, self.position.y)}
        else if(m_direct == direction.left)
        { frontPos = CGPointMake(self.position.x - m_cell, self.position.y)}
        else if(m_direct == direction.up)
        {frontPos = CGPointMake(self.position.x , self.position.y + m_cell)}
        else
        {frontPos = CGPointMake(self.position.x , self.position.y - m_cell)}
        
        var retName:String = parentScene.nodeAtPoint(frontPos).name!
        
        return retName == parentScene.name ? "Empty" : retName
    }

    func getFrontObject()->String
    {
        let frontName = getFront()
        
        if(frontName == "Empty")
        {
            return "Empty"
        }
        else
        {
            var spName = frontName.componentsSeparatedByString("_")
            return spName[0] 
        }
    }

    
    func isFrontTrough()->Bool
    {
        let parentScene:GameScene = self.scene! as GameScene
        
        var frontPos:CGPoint
        if (m_direct == direction.right)
        { frontPos = CGPointMake(self.position.x + m_cell, self.position.y)}
        else if(m_direct == direction.left)
        { frontPos = CGPointMake(self.position.x - m_cell, self.position.y)}
        else if(m_direct == direction.up)
        {frontPos = CGPointMake(self.position.x , self.position.y + m_cell)}
        else
        {frontPos = CGPointMake(self.position.x , self.position.y - m_cell)}
        
        var frontObject = parentScene.nodeAtPoint(frontPos) as? MyObjectBase

        if (frontObject == nil)
        {
            return false
        }
        return frontObject!.isThrough
    }
    
    // Assembly
    func turnR()
    {
        self.texture = self.ad.ImgMas.player[3] as? SKTexture
        m_direct = direction.right
    }
    func turnL()
    {
        self.texture = self.ad.ImgMas.player[6] as? SKTexture
        m_direct = direction.left
    }
    func turnU()
    {
        self.texture = self.ad.ImgMas.player[0] as? SKTexture
        m_direct = direction.up
    }
    func turnD()
    {
        self.texture = self.ad.ImgMas.player[9] as? SKTexture
        m_direct = direction.down
    }
    
    func moveRight()
    {
        turnR()
        if (!isFrontTrough()){
            return
        }
        
        let actions: NSArray = [SKAction.moveByX(m_cell, y: 0, duration: playerSpeed),
                            SKAction.animateWithTextures(rightImgTextures, timePerFrame: playerSpeed/NSTimeInterval(rightImgTextures.count))]
        
        self.runAction(SKAction.group(actions))

    }
    func moveLeft()
    {
        turnL()
        if (!isFrontTrough()){
            return
        }
        
        let actions: NSArray = [SKAction.moveByX(-m_cell, y: 0, duration: playerSpeed),
            SKAction.animateWithTextures(leftImgTextures, timePerFrame: playerSpeed/NSTimeInterval(rightImgTextures.count))]
        
        self.runAction(SKAction.group(actions))

    }
    func moveUp()
    {
        turnU()
        if (!isFrontTrough()){
            return
        }
        let actions: NSArray = [SKAction.moveByX(0, y: m_cell, duration: playerSpeed),
            SKAction.animateWithTextures(backImgTextures, timePerFrame: playerSpeed/NSTimeInterval(rightImgTextures.count))]
        
        self.runAction(SKAction.group(actions))
      
    }
    func moveDown()
    {
        turnD()
        if (!isFrontTrough()){
            return
        }

        let actions: NSArray = [SKAction.moveByX(0, y: -m_cell, duration: playerSpeed),
            SKAction.animateWithTextures(frontImgTextures, timePerFrame: playerSpeed/NSTimeInterval(rightImgTextures.count))]
        
        self.runAction(SKAction.group(actions))

    }
    
    // Command
    func walk()
    {
        if(m_direct == direction.left)
        {
            moveLeft()
        }
        else if(m_direct == direction.right)
        {
            moveRight()
        }
        else if(m_direct == direction.down)
        {
            moveDown()
        }
        else if(m_direct == direction.up)
        {
            moveUp()
        }
    }

        
}
