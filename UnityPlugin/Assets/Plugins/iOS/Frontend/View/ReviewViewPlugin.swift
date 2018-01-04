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
open class ReviewViewPlugin: NSObject {
    @objc
    open class func show(_ appStoreUrl: String) -> Void {
        let alert: UIAlertController = UIAlertController(title: "Review", message: "", preferredStyle: UIAlertControllerStyle.alert)
        func evalCallBack(_ action: UIAlertAction) -> Void {
            let url: URL = URL(string: appStoreUrl)!
            let app: UIApplication = UIApplication.shared
            app.openURL(url)
            return
        }
        let evalAction: UIAlertAction = UIAlertAction(title: "このアプリを評価する", style: UIAlertActionStyle.default, handler: evalCallBack)
        let noAction: UIAlertAction = UIAlertAction(title: "いいえ、結構です", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(evalAction)
        alert.addAction(noAction)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.present(alert, animated: true, completion: nil)
        return
    }
}
