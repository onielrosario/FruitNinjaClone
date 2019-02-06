//
//  Fruit.swift
//  GameDemoApp
//
//  Created by Oniel Rosario on 1/13/19.
//

import Foundation
import SpriteKit
class Fruit: SKNode {
    let fruits = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🍅","🍆","🥭","🌽","🥦"]
    let bomb = "💣"
    override init() {
        super.init()
        var emoji = ""
        if randomCGFloat(0, 1) < 0.9 {
            name = "fruit"
            let n = Int(arc4random_uniform(UInt32(fruits.count)))
            emoji = fruits[n]
        } else {
            name = "bomb"
            emoji = bomb
        }
        let label = SKLabelNode(text: emoji)
        label.fontSize = 120
        label.verticalAlignmentMode = .center
        addChild(label)
        physicsBody = SKPhysicsBody()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (Coder:) has not been implemented")
    }
}
