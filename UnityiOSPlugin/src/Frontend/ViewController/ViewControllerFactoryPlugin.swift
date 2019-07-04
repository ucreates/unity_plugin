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
open class ViewControllerFactoryPlugin: NSObject {
    @objc
    open class func factoryMethod(_ viewControllerId: Int) -> UIViewController {
        var ret: UIViewController = ViewControllerPlugin.getInstance()
        switch viewControllerId {
        case PreferenceViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = PreferenceViewControllerPlugin()
            break
        case TwitterViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = TwitterViewControllerPlugin()
            break
        case FacebookViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = FacebookViewControllerPlugin()
            break
        case LineViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = LineViewControllerPlugin()
            break
        case PaymentViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = PaymentViewControllerPlugin()
            break
        case GoogleViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = GoogleViewControllerPlugin()
            break
        default:
            break
        }
        return ret
    }
}
