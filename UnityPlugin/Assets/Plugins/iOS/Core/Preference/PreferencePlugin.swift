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
open class PreferencePlugin: NSObject {
    @objc
    open class func getSwitchPreference(_ keyName: String) -> Bool {
        let preference: UserDefaults = UserDefaults()
        return preference.bool(forKey: keyName)
    }
    open class func setSwitchPreference(_ keyName: String, value: Bool) -> Void {
        let preference: UserDefaults = UserDefaults()
        preference.set(value, forKey: keyName)
        preference.synchronize()
        return
    }
}
