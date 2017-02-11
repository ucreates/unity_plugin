// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import FBSDKCoreKit
import FBSDKLoginKit
import Foundation
import UIKit
open class FacebookServicePlugin: NSObject {
    @objc
    open func logIn(facebookViewController: UIViewController, callback: (() -> Void)? = nil) -> Void {
        var permissions: [Any] = ["publish_actions"]
        func loginCallback(result: FBSDKLoginManagerLoginResult?, error: Error?) -> Swift.Void {
            if (nil != error) {
                return
            }
            if (false == result?.isCancelled && false != result?.grantedPermissions.contains("publish_actions")) {
                callback?()
            } else {
                let controller: UIViewController = ViewControllerPlugin.getInstance()
                controller.dismiss(animated: true, completion: nil)
            }
            return
        }
        let manager: FBSDKLoginManager = FBSDKLoginManager()
        manager.loginBehavior = FBSDKLoginBehavior.browser
        manager.logIn(withPublishPermissions: permissions, from: facebookViewController, handler: loginCallback)
        return
    }
    @objc
    open func logOut() -> Void {
        let manager: FBSDKLoginManager = FBSDKLoginManager()
        manager.logOut()
        return
    }
    @objc
    open func isLoggedIn() -> Bool {
        var ret: Bool = true
        let token: FBSDKAccessToken? = FBSDKAccessToken.current()
        if (nil == token) {
            ret = false
        }
        return ret
    }
    @objc
    open func getUserId() -> String? {
        var ret: String? = nil
        let token: FBSDKAccessToken? = FBSDKAccessToken.current()
        if (nil != token) {
            ret = token?.userID
        }
        return ret
    }
    @objc
    open func hasPermission(permission: String) -> Bool {
        if (false == self.isLoggedIn()) {
            return false
        }
        let token: FBSDKAccessToken? = FBSDKAccessToken.current()
        if (nil == token) {
            return false
        }
        return token!.hasGranted(permission)
    }
}
