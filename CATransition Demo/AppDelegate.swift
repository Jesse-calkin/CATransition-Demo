//
//  AppDelegate.swift
//  CATransition Demo
//
//  Created by jesse calkin on 3/22/16.
//  Copyright © 2016 Shoshin Boogie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
}

@IBDesignable class GradientView: UIView {
    let gradientLayer = CAGradientLayer()

    @IBInspectable var color1: UIColor = UIColor.magentaColor()
    @IBInspectable var color2: UIColor = UIColor.cyanColor()
    @IBInspectable var location1: CGFloat = 0.0
    @IBInspectable var location2: CGFloat = 1.0


    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(gradientLayer)
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        gradientLayer.colors = [color1.CGColor, color2.CGColor]
        gradientLayer.locations = [location1, location2]
        gradientLayer.frame = frame
        gradientLayer.bounds = bounds
    }
}

