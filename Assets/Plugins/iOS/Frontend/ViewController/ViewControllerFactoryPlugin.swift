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
public class ViewControllerFactoryPlugin: NSObject {
    public class func factoryMethod(viewControllerId: Int) -> UIViewController {
        var ret: UIViewController = ViewControllerPlugin.getInstance()
        switch viewControllerId {
        case PreferenceViewControllerPlugin.VIEWCONTROLLER_ID:
            ret = PreferenceViewControllerPlugin()
            break
        default:
            break
        }
        return ret
    }
}