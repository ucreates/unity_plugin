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
import UIKit
open class LineServicePlugin: NSObject {
    fileprivate let lineAdapter: LineAdapter = LineAdapter.default()!
    @objc
    open func logIn(lineViewController: LineViewControllerPlugin) -> Void {
        if (false == self.lineAdapter.canAuthorizeUsingLineApp) {
            let viewController = LineAdapterWebViewController(adapter: self.lineAdapter, with: LineAdapterWebViewOrientation.all)
            viewController.navigationItem.leftBarButtonItem = LineAdapterNavigationController.barButtonItem(withTitle: "Cancel", target: lineViewController, action: #selector(LineViewControllerPlugin.cancel(_:)))
            let navigationController = LineAdapterNavigationController(rootViewController: viewController)
            lineViewController.present(navigationController, animated: true, completion: nil)
        } else {
            self.lineAdapter.authorize()
        }
        return
    }
    @objc
    open func logOut() -> Void {
        self.lineAdapter.unauthorize()
        return
    }
    @objc
    open func isLoggedIn() -> Bool {
        return self.lineAdapter.isAuthorized
    }
    @objc
    open func getUserId() -> String {
        return self.lineAdapter.mid
    }
    open func getLineAdapter() -> LineAdapter! {
        return self.lineAdapter
    }
}
