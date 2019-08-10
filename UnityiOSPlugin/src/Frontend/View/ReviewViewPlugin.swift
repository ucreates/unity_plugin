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
import StoreKit
import UIKit
open class ReviewViewPlugin: NSObject {
    @objc
    open class func show(_ appStoreUrl: String, title: String, evalActionTitle: String, noActionTitle: String) -> Void {
        if #available(iOS 10.3, *) {
            if (0 == appStoreUrl.count) {
                SKStoreReviewController.requestReview()
                return
            }
        }
        let alert: UIAlertController = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        func evalCallBack(_ action: UIAlertAction) -> Void {
            let url: URL = URL(string: appStoreUrl)!
            let app: UIApplication = UIApplication.shared
            app.openURL(url)
            return
        }
        let evalAction: UIAlertAction = UIAlertAction(title: evalActionTitle, style: UIAlertActionStyle.default, handler: evalCallBack)
        let noAction: UIAlertAction = UIAlertAction(title: noActionTitle, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(evalAction)
        alert.addAction(noAction)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.present(alert, animated: true, completion: nil)
        return
    }
}
