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
public class NotifierPlugin: NSObject {
    @objc
    public class func Notify(gameObjectName: String, methodName: String, parameter: String) {
        UnitySendMessage(gameObjectName, methodName, parameter)
        return
    }
}