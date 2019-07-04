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
open class LocalNotifierPlugin: BaseNotifierPlugin, UNUserNotificationCenterDelegate {
    fileprivate static let MIN_INTERVAL_SECOND: TimeInterval = 1
    fileprivate static let IDENTIFIER: String = "NOTIFICATION"
    fileprivate static var instance: LocalNotifierPlugin?
    fileprivate override init() {}
    @objc
    open static func getInstance() -> LocalNotifierPlugin! {
        if (nil == LocalNotifierPlugin.instance) {
            LocalNotifierPlugin.instance = LocalNotifierPlugin()
        }
        return LocalNotifierPlugin.instance!
    }
    @objc
    open override func register() -> Void {
        if #available(iOS 10.0, *) {
            func callback(granted: Bool, error: Error?) -> Void {
                if (nil != error) {
                    print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.debugDescription)
                    self.enable = false
                } else {
                    self.enable = granted
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
    @objc
    open override func noitfy(title: String, body: String, interval: TimeInterval) -> Void {
        if (false == self.enable) {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "LocalNotifierPlugin is not granted.")
            return
        }
        if (interval < LocalNotifierPlugin.MIN_INTERVAL_SECOND) {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "not supported interval. which is higher than 1(time unit is second)")
            return
        }
        if #available(iOS 10.0, *) {
            let content: UNMutableNotificationContent = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default()
            let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
            let request: UNNotificationRequest = UNNotificationRequest(identifier: LocalNotifierPlugin.IDENTIFIER, content: content, trigger: trigger)
            let center: UNUserNotificationCenter = UNUserNotificationCenter.current()
            center.add(request)
        } else {
            let notification: UILocalNotification = UILocalNotification()
            notification.alertTitle = title
            notification.alertBody = body
            notification.alertAction = "OK"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.timeZone = NSTimeZone.default
            notification.fireDate = Date(timeIntervalSinceNow: interval)
            let app: UIApplication = UIApplication.shared
            app.scheduleLocalNotification(notification)
        }
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "execute local notification.")
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        self.noitfy(userInfo: userInfo)
        completionHandler([.alert, .badge, .sound])
        return
    }
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "press local notification message in notify area.")
        let userInfo: [AnyHashable: Any] = response.notification.request.content.userInfo
        self.noitfy(userInfo: userInfo)
        completionHandler()
        return
    }
}
