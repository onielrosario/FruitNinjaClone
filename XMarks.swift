//
//  XMarks.swift
//  GameDemoApp
//
//  Created by Oniel Rosario on 1/14/19.
//

import SpriteKit

class XMark: SKNode {
    
    var xarray = [SKSpriteNode]()
    var numsX = Int()
    let blackXpic = SKTexture(imageNamed: "blackX")
    let redXpic = SKTexture(imageNamed: "redX")
    
    init(num: Int = 0) {
        super.init()
        numsX = num
        for i in 0..<numsX {
            let xMark = SKSpriteNode(imageNamed: "blackX")
            xMark.size = CGSize(width: 60, height: 60)
            xMark.position.x = -CGFloat(i)*70
            addChild(xMark)
            xarray.append(xMark)
        }
    }
    
    public func update(num: Int) {
        if num <= numsX {
             xarray[xarray.count-num].texture = redXpic
        }
       
    }
    public func reset() {
        for x in xarray {
            x.texture = blackXpic
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


