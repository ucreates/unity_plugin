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
import UIKit
import GoogleSignIn
open class GoogleServicePlugin: NSObject {
    @objc
    open func buildApiClient(clientId: String!, viewController: UIViewController) -> Void {
        let signIn: GIDSignIn = GIDSignIn.sharedInstance()
        signIn.clientID = clientId
        signIn.delegate = viewController as! GIDSignInDelegate
        signIn.uiDelegate = viewController as! GIDSignInUIDelegate
        return
    }
    @objc
    open func logIn() -> Void {
        let signIn: GIDSignIn = GIDSignIn.sharedInstance()
        if (nil != signIn.currentUser) {
            return
        }
        signIn.signIn()
        return
    }
    @objc
    open func silentlyLogIn() -> Void {
        let signIn: GIDSignIn = GIDSignIn.sharedInstance()
        if (nil == signIn.currentUser) {
            return
        }
        signIn.signInSilently()
        return
    }
    @objc
    open func logOut() -> Void {
        let signIn: GIDSignIn = GIDSignIn.sharedInstance()
        signIn.signOut()
        signIn.disconnect()
        return
    }
    @objc
    open func revokeAccess() -> Void {
        let signIn: GIDSignIn = GIDSignIn.sharedInstance()
        signIn.disconnect()
        return
    }
    @objc
    open func send(user: GIDGoogleUser) -> Void {
        let idToken = user.authentication.idToken
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + idToken!)
        NSLog("%@,idToken::%@", TagPlugin.UNITY_PLUGIN_IDENTIFIER, idToken!)
        return
    }
    @objc
    open func handle(url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let singIn: GIDSignIn = GIDSignIn.sharedInstance()
        return singIn.handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
}
