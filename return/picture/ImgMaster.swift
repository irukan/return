//
//  ImgMaster.swift
//  return
//
//  Created by kayama on 2014/11/27.
//  Copyright (c) 2014年 kayama. All rights reserved.
//


import Foundation
import SpriteKit

class ImgMaster: NSObject {

    var mapItem : NSMutableArray!
    var player : NSMutableArray!
    
    override init() {
        super.init()

        mapItem = NSMutableArray()
        initImgArr(mapItem, imgName: "mapItem", numX: 8, numY: 11)

        player = NSMutableArray()
        initImgArr(player, imgName: "character", numX: 3, numY: 4)
    }
    

    
    func initImgArr(imgArr : NSMutableArray!, imgName : NSString, numX: Int, numY :Int)
    {
         var picture:SKTexture = SKTexture(imageNamed: imgName)

         let chipsize = CGSizeMake( picture.size().width / CGFloat(numX), picture.size().height / CGFloat(numY) )

         let Wratio = chipsize.width / picture.size().width
         let Hratio = chipsize.height / picture.size().height

         for(var y = 0 ; y < numY; y++){
             for(var x = 0; x < numX; x++){

                 // 切り出し範囲。実際の大きさではなく、割合で指定する
                 let cutRect:CGRect = CGRectMake(Wratio * CGFloat(x), Hratio * CGFloat(y), Wratio, Hratio)
                 let imgCellTemp: SKTexture = SKTexture(rect:cutRect, inTexture: picture)
                 imgArr.addObject(imgCellTemp)
             }

         }

    }

}
