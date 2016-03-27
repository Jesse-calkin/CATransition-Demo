//
//  CGRectExtensions.swift
//  CATransition Demo
//
//  Created by jesse calkin on 3/25/16.
//  Copyright © 2016 Shoshin Boogie. All rights reserved.
//

import UIKit

extension CGRect {
    var minXmaxY: CGPoint { return CGPoint(x: minX, y: maxY) }
    var maxXminY: CGPoint { return CGPoint(x: maxX, y: minY) }
    var maxXmaxY: CGPoint { return CGPoint(x: maxX, y: maxY) }

    var midXminY: CGPoint { return CGPoint(x: midX, y: minY) }
    var midXmaxY: CGPoint { return CGPoint(x: midX, y: maxY) }

    var midXmidY: CGPoint { return CGPoint(x: midX, y: midY) }

    var minXmidY: CGPoint { return CGPoint(x: minX, y: midY) }
    var maxXmidY: CGPoint { return CGPoint(x: maxX, y: midY) }
}

func *(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}