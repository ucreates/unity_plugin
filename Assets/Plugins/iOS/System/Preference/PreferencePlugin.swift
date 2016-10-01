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
public class PreferencePlugin: NSObject {
    public class func getSwitchPreference(keyName: String) -> Bool {
        let preference: NSUserDefaults = NSUserDefaults()
        return preference.boolForKey(keyName)
    }
    public class func setSwitchPreference(keyName: String, value: Bool) -> Void {
        let preference: NSUserDefaults = NSUserDefaults()
        preference.setBool(value, forKey: keyName)
        preference.synchronize()
        return
    }
}