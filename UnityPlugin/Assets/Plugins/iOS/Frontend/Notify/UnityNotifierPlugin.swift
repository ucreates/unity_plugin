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
open class UnityNotifierPlugin: NSObject {
    @objc
    open class func notify(_ gameObjectName: String, methodName: String, parameter: String) -> Void {
        UnitySendMessage(gameObjectName, methodName, parameter)
        return
    }
}
