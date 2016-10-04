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
public class IndicatorViewPlugin: NSObject {
    var view: UIActivityIndicatorView!
    public func create() {
        var style: UIActivityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            style = UIActivityIndicatorViewStyle.WhiteLarge
        }
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        self.view = UIActivityIndicatorView()
        self.view.center = controller.view.center
        self.view.activityIndicatorViewStyle = style
        controller.view.addSubview(self.view)
        return
    }
    public func show() {
        if (nil == self.view) {
            return
        }
        self.view.startAnimating()
        return
    }
    public func hide() {
        if (nil == self.view) {
            return
        }
        self.view.stopAnimating()
        return
    }
    public func destroy() {
        if (nil == self.view) {
            return
        }
        self.view.removeFromSuperview()
        return
    }
}
