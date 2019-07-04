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
open class GoogleViewControllerPlugin: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    @objc
    public static let VIEWCONTROLLER_ID: Int = 7
    private static let LOGIN: Int = 0
    private static let LOGOUT: Int = 1
    private static let REVOKEACCESS: Int = 2
    fileprivate var service: GoogleServicePlugin!
    fileprivate var clientId: String!
    fileprivate var mode: Int = 0
    open override func viewDidLoad() -> Void {
        super.viewDidLoad()
        self.service = GoogleServicePlugin()
        self.service.buildApiClient(clientId: self.clientId, viewController: self)
        if (GoogleViewControllerPlugin.LOGIN == self.mode) {
            self.service.logIn()
        }
        return
    }
    open override func viewDidAppear(_ animated: Bool) {
        if (GoogleViewControllerPlugin.LOGIN == self.mode) {
            self.service.silentlyLogIn()
        } else if (GoogleViewControllerPlugin.LOGOUT == self.mode) {
            self.service.logOut()
        } else if (GoogleViewControllerPlugin.REVOKEACCESS == self.mode) {
            self.service.revokeAccess()
        }
        return
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            NSLog("%@,error::%@", TagPlugin.UNITY_PLUGIN_IDENTIFIER, error.localizedDescription)
            self.dismiss(animated: true, completion: nil)
            return
        }
        let service: GoogleServicePlugin = GoogleServicePlugin()
        service.send(user: user)
        self.dismiss(animated: true, completion: nil)
        return
    }
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            NSLog("%@,error::%@", TagPlugin.UNITY_PLUGIN_IDENTIFIER, error.localizedDescription)
        }
        self.dismiss(animated: true, completion: nil)
        return
    }
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        viewController.view.layoutIfNeeded()
        self.present(viewController, animated: true, completion: nil)
        return
    }
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
        return
    }
    public func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        return
    }
    @objc
    open func setParameter(clientId: String, mode: Int) -> Void {
        self.clientId = clientId
        self.mode = mode
        return
    }
}
