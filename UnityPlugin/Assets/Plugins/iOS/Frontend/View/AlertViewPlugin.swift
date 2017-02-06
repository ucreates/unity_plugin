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
open class AlertViewPlugin: NSObject {
    @objc
    open class func show(_ message: String) -> Void {
        let alert: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(confirmAction)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.present(alert, animated: true, completion: nil)
        return
    }
}
