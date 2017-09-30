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
open class UnityiOSPluginAppDelegate: NSObject {
    @objc
    open class func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        LineAdapter.handleLaunchOptions(launchOptions)
        return true
    }
    @objc
    open class func application(_ app: UIApplication, url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        let source: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        let annotaion: Any = options[UIApplicationOpenURLOptionsKey.annotation] as Any
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        LineAdapter.handleOpen(url)
        let singIn: GIDSignIn = GIDSignIn.sharedInstance()
        singIn.handle(url, sourceApplication: source, annotation: annotaion)
        return true
    }
    @objc
    open class func application(_ application: UIApplication, url: URL) -> Bool {
        return LineAdapter.handleOpen(url)
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
