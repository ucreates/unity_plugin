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
import UIKit
import UserNotifications
open class RemoteNotifierPlugin: BaseNotifierPlugin, UNUserNotificationCenterDelegate {
    fileprivate static var instance: RemoteNotifierPlugin?
    fileprivate override init() {}
    @objc
    open static func getInstance() -> RemoteNotifierPlugin! {
        if (nil == RemoteNotifierPlugin.instance) {
            RemoteNotifierPlugin.instance = RemoteNotifierPlugin()
        }
        return RemoteNotifierPlugin.instance!
    }
    @objc
    open override func register() -> Void {
        if #available(iOS 10.0, *) {
            func callback(granted: Bool, error: Error?) -> Void {
                if (nil != error) {
                    print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.debugDescription)
                } else {
                    let app: UIApplication = UIApplication.shared
                    app.registerForRemoteNotifications()
                }
                return
            }
            let userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
            userNotificationCenter.delegate = self
            userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: callback)
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            let app: UIApplication = UIApplication.shared
            app.registerUserNotificationSettings(settings)
        }
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "execute remote notification.")
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        self.noitfy(userInfo: userInfo)
        self.reset()
        completionHandler([.alert, .badge, .sound])
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "press remote notification message in notify area.")
        let userInfo: [AnyHashable: Any] = response.notification.request.content.userInfo
        self.noitfy(userInfo: userInfo)
        self.reset()
        completionHandler()
        return
    }
}
