// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import Foundation
import UIKit
public class AlertViewPlugin: NSObject {
    @objc
    public class func show(message: String) {
        let alert: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(confirmAction)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.presentViewController(alert, animated: true, completion: nil)
        return
    }
}