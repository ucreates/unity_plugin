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
    open static let VIEWCONTROLLER_ID: Int = 7
    fileprivate var clientId: String!
    @objc
    override open func viewDidLoad() -> Void {
        super.viewDidLoad()
        let service: GoogleServicePlugin = GoogleServicePlugin()
        service.buildApiClient(clientId: self.clientId, viewController: self)
        service.revokeAccess()
        service.logIn()
        return
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.localizedDescription)
            return
        }
        let service: GoogleServicePlugin = GoogleServicePlugin()
        service.send(user: user)
        self.dismiss(animated: true, completion: nil)
        return
    }
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.localizedDescription)
        }
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
    @objc
    open func setParameter(clientId: String) -> Void {
        self.clientId = clientId
        return
    }
}
