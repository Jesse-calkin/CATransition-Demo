//
//  TimingCurveView.swift
//  CATransition Demo
//
//  Created by jesse calkin on 3/25/16.
//  Copyright © 2016 Shoshin Boogie. All rights reserved.
//

import UIKit

class TimingCurveViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var curveView: UIView!
    @IBOutlet var handle2: UIView!
    @IBOutlet var handle1: UIView!

    var activeHandle: UIView?

    private let curve = CAShapeLayer()
    private let handleBar1 = CAShapeLayer()
    private let handleBar2 = CAShapeLayer()
    private let cyan = UIColor.cyanColor()

    func updateTimingCurve() {
        let p1 = handle1.center
        let p2 = handle2.center

        let path = UIBezierPath()
        path.moveToPoint(curveView.bounds.origin)
        path.addCurveToPoint(curveView.bounds.maxXmaxY, controlPoint1: p1, controlPoint2: p2)
        curve.path = path.CGPath

        let h1 = UIBezierPath()
        h1.moveToPoint(curveView.bounds.origin)
        h1.addLineToPoint(p1)
        handleBar1.path = h1.CGPath

        let h2 = UIBezierPath()
        h2.moveToPoint(curveView.bounds.maxXmaxY)
        h2.addLineToPoint(p2)
        handleBar2.path = h2.CGPath

        view.setNeedsLayout()
    }

    func grabHandle() {
        activeHandle?.transform = CGAffineTransformMakeScale(2.0, 2.0)
        activeHandle?.layer.shadowOpacity = 1.0
    }

    func dropHandle() {
        activeHandle?.transform = CGAffineTransformIdentity
        activeHandle?.layer.shadowOpacity = 0.0
        activeHandle = nil
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        handle1.backgroundColor = cyan
        handle1.layer.cornerRadius = handle1.bounds.width / 2
        handleBar1.fillColor = UIColor.clearColor().CGColor
        handleBar1.strokeColor = cyan.CGColor
        handleBar1.lineWidth = 2

        handle2.backgroundColor = cyan
        handle2.layer.cornerRadius = handle2.bounds.width / 2
        handleBar2.fillColor = UIColor.clearColor().CGColor
        handleBar2.strokeColor = cyan.CGColor
        handleBar2.lineWidth = 2

        curve.lineWidth = 2
        curve.strokeColor = cyan.CGColor
        curve.fillColor = UIColor.clearColor().CGColor
        curveView.layer.addSublayer(curve)
        curveView.layer.addSublayer(handleBar1)
        curveView.layer.addSublayer(handleBar2)
        curveView.layer.transform = CATransform3DMakeScale(1.0, -1.0, 1.0)

        updateTimingCurve()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)

        guard let location = touches.first?.locationInView(curveView) else { return }

        if handle1.frame.contains(location) {
            activeHandle = handle1
        } else if handle2.frame.contains(location) {
            activeHandle = handle2
        }

        print("Active Handle: \(activeHandle?.center)")
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        dropHandle()
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)

        guard let location = touches.first?.locationInView(curveView), let activeHandle = activeHandle where curveView.bounds.contains(location) else { return }

        activeHandle.center = location
        updateTimingCurve()
    }
}
