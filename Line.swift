//
//  Line.swift
//  GameDemoApp
//
//  Created by Oniel Rosario on 1/14/19.
//

import SpriteKit


class TrailLine: SKShapeNode {
    var shrinkTimer = Timer()
    init(position: CGPoint, lastPos: CGPoint, with: CGFloat, color: UIColor) {
        super.init()
        let path = CGMutablePath()
        path.move(to: position)
        path.addLine(to: lastPos)
        self.path = path
       lineWidth = with
       strokeColor = color
        shrinkTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { _ in
            self.lineWidth -= 1
            if self.lineWidth == 0 {
                self.shrinkTimer.invalidate()
                self.removeFromParent()
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
