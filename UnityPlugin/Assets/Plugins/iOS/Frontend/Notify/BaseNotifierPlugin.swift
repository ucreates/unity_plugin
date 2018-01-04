// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
import Foundation
import UIKit
open class BaseNotifierPlugin: NSObject {
    var enable: Bool = false
    @objc
    open func register() -> Void {
        return
    }
    @objc
    open func noitfy(title: String, body: String, interval: TimeInterval) -> Void {
        return
    }
    @objc
    open func noitfy(userInfo: [AnyHashable: Any]) -> Void {
        return
    }
    open func reset() -> Void {
        let app: UIApplication = UIApplication.shared
        app.applicationIconBadgeNumber = 0
        return
    }
}
