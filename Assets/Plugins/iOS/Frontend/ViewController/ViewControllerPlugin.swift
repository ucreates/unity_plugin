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
public class ViewControllerPlugin: NSObject {
    public static let VIEWCONTROLLER_ID: Int = 1
    @objc
    public class func getInstance() -> UIViewController {
        return UnityGetGLViewController()
    }
}