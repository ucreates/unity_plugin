// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import UIKit
open class ViewControllerPlugin: NSObject {
    open static let VIEWCONTROLLER_ID: Int = 1
    @objc
    open class func getInstance() -> UIViewController {
        return UnityGetGLViewController()
    }
}
