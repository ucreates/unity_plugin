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
open class IndicatorViewPlugin: NSObject {
    var view: UIActivityIndicatorView!
    @objc
    open func create() -> Void {
        var style: UIActivityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            style = UIActivityIndicatorViewStyle.whiteLarge
        }
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        self.view = UIActivityIndicatorView()
        self.view.center = controller.view.center
        self.view.activityIndicatorViewStyle = style
        controller.view.addSubview(self.view)
        return
    }
    @objc
    open func show() -> Void {
        if (nil == self.view) {
            return
        }
        self.view.startAnimating()
        return
    }
    @objc
    open func hide() -> Void {
        if (nil == self.view) {
            return
        }
        self.view.stopAnimating()
        return
    }
    @objc
    open func destroy() -> Void {
        if (nil == self.view) {
            return
        }
        self.view.removeFromSuperview()
        return
    }
}
