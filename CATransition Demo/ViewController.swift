//
//  ViewController.swift
//  CATransition Demo
//
//  Created by jesse calkin on 3/22/16.
//  Copyright © 2016 Shoshin Boogie. All rights reserved.
//

import UIKit

enum TransitionType: Int {
    case Fade = 0, MoveIn, Push, Reveal

    func stringValue() -> String {
        switch self {
        case .Fade:
            return kCATransitionFade
        case .MoveIn:
            return kCATransitionMoveIn
        case .Push:
            return kCATransitionPush
        case .Reveal:
            return kCATransitionReveal
        }
    }

    func displayString() -> String {
        switch self {
        case .Fade:
            return "kCATransitionFade"
        case .MoveIn:
            return "kCATransitionMoveIn"
        case .Push:
            return "kCATransitionPush"
        case .Reveal:
            return "kCATransitionReveal"
        }
    }
}

enum TransitionSubType: Int {
    case FromRight = 0, FromLeft, FromTop, FromBottom

    func stringValue() -> String {
        switch self {
        case .FromRight:
            return kCATransitionFromRight
        case .FromLeft:
            return kCATransitionFromLeft
        case .FromTop:
            return kCATransitionFromTop
        case .FromBottom:
            return kCATransitionFromBottom
        }
    }

    func displayString() -> String {
        switch self {
        case .FromRight:
            return "kCATransitionFromRight"
        case .FromLeft:
            return "kCATransitionFromLeft"
        case .FromTop:
            return "kCATransitionFromTop"
        case .FromBottom:
            return "kCATransitionFromBottom"
        }
    }
}

enum Curve: Int {
    case Linear = 0, EaseIn, EaseOut, EaseInOut

    func timingFunction() -> CAMediaTimingFunction {
        switch self {
        case .Linear:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .EaseIn:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case.EaseOut:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case.EaseInOut:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
    }

    func displayString() -> String {
        switch self {
        case .Linear:
            return "kCAMediaTimingFunctionLinear"
        case .EaseIn:
            return "kCAMediaTimingFunctionEaseIn"
        case.EaseOut:
            return "kCAMediaTimingFunctionEaseOut"
        case.EaseInOut:
            return "kCAMediaTimingFunctionEaseInEaseOut"
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var animatedLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!

    let transition = CATransition()

    let text1 = "The Quick Brown Fox"
    let text2 = "Jumps Over The Lazy Dog"
    var fox: UIImage?
    var dog: UIImage?

    var duration: NSTimeInterval = 1.0 {
        didSet {
            transition.duration = duration
            durationLabel.text = String(format: "%\(1.1)fs", duration)
        }
    }

    var transitionType: TransitionType = .Fade {
        didSet {
            transition.type = transitionType.stringValue()
        }
    }

    var transitionSubType: TransitionSubType = .FromRight {
        didSet {
            transition.subtype = transitionSubType.stringValue()
        }
    }

    var transitionCurve: Curve = .Linear {
        didSet {
            transition.timingFunction = transitionCurve.timingFunction()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        fox = UIImage(named: "fox")
        dog = UIImage(named: "lazyDog")

        transition.type = transitionType.stringValue()
        transition.subtype = transitionSubType.stringValue()
        transition.timingFunction = transitionCurve.timingFunction()
        transition.duration = duration
        transition.fillMode = kCAFillModeRemoved
        transition.delegate = self

        imageView.layer.addAnimation(transition, forKey: "transitionAnimation")
        animatedLabel.layer.addAnimation(transition, forKey: "transitionAnimation")

        animatedLabel.text = text1
        imageView.image = fox
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }

        if identifier == "showCodeView" {
            let vc = segue.destinationViewController as! DetailsViewController
            vc.duration = duration
            vc.transitionSubType = transitionSubType.displayString()
            vc.transitionType = transitionType.displayString()
        }
    }

    @IBAction func selectContent(sender: UISegmentedControl) {
        imageView.hidden = sender.selectedSegmentIndex == 0
        animatedLabel.hidden = sender.selectedSegmentIndex == 1
    }

    @IBAction func selectType(sender: UISegmentedControl) {
        guard let type = TransitionType(rawValue: sender.selectedSegmentIndex) else { return }
        transitionType = type
    }

    @IBAction func selectSubType(sender: UISegmentedControl) {
        guard let subtype = TransitionSubType(rawValue: sender.selectedSegmentIndex) else { return }
        transitionSubType = subtype
    }

    @IBAction func selectCurve(sender: UISegmentedControl) {
        guard let curve = Curve(rawValue: sender.selectedSegmentIndex) else { return }
        transitionCurve = curve
    }

    @IBAction func adjustDuration(sender: UISlider) {
        duration = NSTimeInterval(sender.value)
    }

    @IBAction func animate(sender: UIButton) {
        animatedLabel.layer.addAnimation(transition, forKey: "transitionAnimation")
        animatedLabel.text = animatedLabel.text == text1 ? text2 : text1

        imageView.layer.addAnimation(transition, forKey: "")
        imageView.image = imageView.image == fox ? dog : fox

        CATransaction.begin()
        CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        CATransaction.setValue(transitionCurve.timingFunction(), forKey: kCATransactionAnimationTimingFunction)
        progressView.setProgress(1.0, animated: true)
        CATransaction.commit()
    }

    override func animationDidStart(anim: CAAnimation) {
        progressView.hidden = false
        UIView.animateWithDuration(0.25) { () -> Void in
            self.progressView.alpha = 1.0
        }
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.progressView.alpha = 0.0
            }) { (finished) -> Void in
                if finished {
                    self.progressView.hidden = true
                }
        }
        progressView.setProgress(0.0, animated: false)
    }
}
