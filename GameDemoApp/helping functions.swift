//
//  helping functions.swift
//  GameDemoApp
//
//  Created by Oniel Rosario on 1/13/19.
//

import Foundation
import UIKit



func randomCGFloat(_ lowerLimit: CGFloat, _ upperLimit: CGFloat) -> CGFloat {
    return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
}

