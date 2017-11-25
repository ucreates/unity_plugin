// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import Foundation
open class VersionPlugin: NSObject {
    @objc
    open class func getVersion() -> Int32 {
        let version: String? = VersionPlugin.getPlist(plistKeyName: "CFBundleVersion")
        return (version?.toInt)!
    }
    @objc
    open class func getVersionName() -> String {
        let versionName: String? = VersionPlugin.getPlist(plistKeyName: "CFBundleShortVersionString")
        return versionName!
    }
    fileprivate class func getPlist(plistKeyName: String) -> String? {
        let plist: String? = Bundle.main.object(forInfoDictionaryKey: plistKeyName) as? String
        return plist
    }
}
