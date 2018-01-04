// ======================================================================
// Project Name    : ios_foundation
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
import Firebase
import FirebaseMessaging
open class FCMNotifierPlugin: BaseNotifierPlugin, UNUserNotificationCenterDelegate, FIRMessagingDelegate {
    fileprivate static var instance: FCMNotifierPlugin?
    fileprivate override init() {}
    open static func getInstance() -> FCMNotifierPlugin! {
        if (nil == FCMNotifierPlugin.instance) {
            FCMNotifierPlugin.instance = FCMNotifierPlugin()
        }
        return FCMNotifierPlugin.instance!
    }
    open override func register() -> Void {
        FIRApp.configure()
        let messaging: FIRMessaging = FIRMessaging.messaging()
        let notificationCenter: NotificationCenter = NotificationCenter.default
        messaging.remoteMessageDelegate = self
        notificationCenter.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: .firInstanceIDTokenRefresh, object: nil)
        if #available(iOS 10.0, *) {
            func callback(granted: Bool, error: Error?) -> Void {
                if (nil != error) {
                    print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.debugDescription)
                } else {
                    let firInstance: FIRInstanceID = FIRInstanceID.instanceID()
                    let fcmToken: String? = firInstance.token()
                    let app: UIApplication = UIApplication.shared
                    app.registerForRemoteNotifications()
                    if (nil != fcmToken) {
                        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "fcmToken::" + fcmToken!)
                    }
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
    open func tokenRefreshNotification(_ notification: Notification) -> Void {
        let firInstance: FIRInstanceID = FIRInstanceID.instanceID()
        let messaging: FIRMessaging = FIRMessaging.messaging()
        let fcmToken: String? = firInstance.token()
        if (nil == fcmToken) {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "fcmToken is null")
            return
        }
        func callback(error: Error?) -> Void {
            if (nil != error) {
                print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.debugDescription)
            } else {
                print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "success connect to fcm")
            }
            return
        }
        messaging.disconnect()
        messaging.connect(completion: callback)
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "fcmToken::" + fcmToken!)
        return
    }
    public func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) -> Void {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + remoteMessage.appData.debugDescription)
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "execute fcm notification.")
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        self.noitfy(userInfo: userInfo)
        completionHandler([.alert, .badge, .sound])
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "press fcm notification message in notify area.")
        let userInfo: [AnyHashable: Any] = response.notification.request.content.userInfo
        self.noitfy(userInfo: userInfo)
        completionHandler()
        return
    }
}
