// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import CoreData
import FBSDKCoreKit
import GoogleSignIn
import UIKit
import LineSDK
open class UnityiOSPluginAppDelegate: NSObject {
    @objc
    open class func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        let infoDictionary: [String : Any]? = Bundle.main.infoDictionary!
        let value: [String:String?]? = infoDictionary?["LineSDKConfig"] as? [String:String?]
        let channelId: String = value?["ChannelId"] as! String
        LoginManager.shared.setup(channelID: channelId, universalLinkURL: nil)
        return true
    }
    @objc
    open class func application(_ app: UIApplication, url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        let source: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        let annotaion: Any = options[UIApplicationOpenURLOptionsKey.annotation] as Any
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        LoginManager.shared.application(app, open: url, options: options)
        let singIn: GIDSignIn = GIDSignIn.sharedInstance()
        singIn.handle(url, sourceApplication: source, annotation: annotaion)
        return true
    }
    @objc
    open class func application(_ application: UIApplication, url: URL) -> Bool {
        return true
    }
    @objc
    open class func reset() -> Void {
        let notifiers: [BaseNotifierPlugin] = [RemoteNotifierPlugin.getInstance()]
        for notifier in notifiers {
            notifier.reset()
        }
        return
    }
}
