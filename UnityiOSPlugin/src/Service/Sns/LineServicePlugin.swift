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
import LineSDK
open class LineServicePlugin: NSObject {
    public func logOut(callback:@escaping ()->Void) -> Void {
        func completion(result: (Result<(), LineSDKError>)) -> Void {
            callback()
        }
        LoginManager.shared.logout(completionHandler: completion)
        return
    }
    public func isLoggedIn() -> Bool {
        return LoginManager.shared.isAuthorized
    }
}
