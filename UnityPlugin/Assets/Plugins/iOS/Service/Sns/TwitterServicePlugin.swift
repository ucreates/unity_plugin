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
import Fabric
import TwitterKit
open class TwitterServicePlugin: NSObject {
    @objc
    open func logIn(_ callback: (() -> Void)? = nil) -> Void {
        func loginCallback(session: TWTRSession?, error: Error?) -> Swift.Void {
            if (nil != session) {
                callback?()
            }
            return
        }
        let twitter: Twitter = Twitter.sharedInstance()
        twitter.logIn(completion: loginCallback)
        return
    }
    @objc
    open func logOut() -> Void {
        let twitter: Twitter = Twitter.sharedInstance()
        let store: TWTRSessionStore! = twitter.sessionStore
        let sessions: [AnyObject] = store.existingUserSessions() as [AnyObject]
        if (0 == sessions.count) {
            return
        }
        let session: TWTRAuthSession! = store.session()!
        if (nil == session) {
            return
        }
        let userID: String = session.userID
        store.logOutUserID(userID)
        return
    }
    @objc
    open func isLoggedIn() -> Bool {
        let twitter: Twitter = Twitter.sharedInstance()
        let store: TWTRSessionStore! = twitter.sessionStore
        let sessions: [AnyObject] = store.existingUserSessions() as [AnyObject]
        var ret = true
        if (0 == sessions.count) {
            ret = false
        }
        return ret
    }
    @objc
    open func getUserId() -> String? {
        let twitter: Twitter = Twitter.sharedInstance()
        let store: TWTRSessionStore! = twitter.sessionStore
        let sessions: [AnyObject] = store.existingUserSessions() as [AnyObject]
        if (0 == sessions.count) {
            return ""
        }
        let session: TWTRAuthSession! = store.session()!
        if (nil == session) {
            return ""
        }
        return session.userID
    }
}
