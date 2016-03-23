//
//  DetailsViewController.swift
//  CATransition Demo
//
//  Created by jesse calkin on 3/22/16.
//  Copyright © 2016 Shoshin Boogie. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextView!

    var duration: NSTimeInterval?
    var transitionType: String?
    var transitionSubType: String?
    var transitionCurve: String?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        var codeSnippet = "let transition = CATransition()\n\n"

        if let transitionType = transitionType {
            codeSnippet += "transition.type = \(transitionType)\n"
        }

        if let transitionSubType = transitionSubType {
            codeSnippet += "transition.subtype = \(transitionSubType)\n"
        }

        if let duration = duration {
            codeSnippet += "transition.duration = \(String(format: "%\(1.1)f", duration))\n"
        }

        if let transitionCurve = transitionCurve {
            codeSnippet += "transition.timingFunction = CAMediaTimingFunction(name: \(transitionCurve))\n"
        }

        codeSnippet += "transition.fillMode = kCAFillModeRemoved\n\n"
        codeSnippet += "view.layer.addAnimation(transition, forKey: \"animatedTransition\")"
    }

    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func showActionSheet(sender: AnyObject) {
        let activityViewController = UIActivityViewController(activityItems: [codeTextField.text], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }

}
