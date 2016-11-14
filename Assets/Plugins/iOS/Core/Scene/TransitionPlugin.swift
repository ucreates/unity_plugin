// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import UIKit
public class TransitionPlugin: NSObject {
    @objc
    public class func execute(viewControllerId: Int) -> Void {
        let fromViewController: UIViewController = ViewControllerPlugin.getInstance()
        let toViewController: UIViewController = ViewControllerFactoryPlugin.factoryMethod(viewControllerId)
        let navigationController: UINavigationController = UINavigationController(rootViewController: toViewController)
        fromViewController.presentViewController(navigationController, animated: true, completion: nil)
        return
    }
}