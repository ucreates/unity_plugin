//======================================================================
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
public class ReviewViewPlugin: NSObject {
    public class func show(appStoreUrl: String) {
        let alert: UIAlertController = UIAlertController(title: "Review", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        func evalCallBack (action: UIAlertAction) -> Void {
            let url = NSURL(string: appStoreUrl)
            UIApplication.sharedApplication().openURL(url!)
        }
        let evalAction: UIAlertAction = UIAlertAction(title: "このアプリを評価する", style: UIAlertActionStyle.Default, handler: evalCallBack)
        let noAction: UIAlertAction = UIAlertAction(title: "いいえ、結構です", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(evalAction)
        alert.addAction(noAction)
        let controller = ViewControllerPlugin.getInstance()
        controller.presentViewController(alert, animated: true, completion: nil)
    }
}