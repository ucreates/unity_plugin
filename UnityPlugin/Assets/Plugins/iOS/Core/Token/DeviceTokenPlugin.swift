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
import GLKit
open class DeviceTokenPlugin: NSObject {
    @objc
    open static func toString(deviceToken: Data) -> String {
        var ret: String = ""
        for i in 0 ..< deviceToken.count {
            let arg: CVarArg = deviceToken[i] as CVarArg
            ret += String(format: "%02.2hhx", arg)
        }
        return ret
    }
}
