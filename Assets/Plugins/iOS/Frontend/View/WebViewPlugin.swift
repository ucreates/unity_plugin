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
open class WebViewPlugin: NSObject, UIWebViewDelegate {
    var view: UIWebView!
    @objc
    open func create(_ url: String, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        let req: URLRequest = URLRequest(url: URL(string: url)!)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        let width: CGFloat = controller.view.frame.width
        let height: CGFloat = controller.view.frame.height
        self.view = UIWebView()
        self.view.frame = CGRect(x: left, y: top, width: width - left - right, height: height - top - bottom)
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        self.view.delegate = self
        self.view.loadRequest(req)
        controller.view.addSubview(self.view)
        return
    }
    @objc
    open func show() {
        self.setVisible(true)
        return
    }
    @objc
    open func hide() {
        self.setVisible(false)
        return
    }
    @objc
    open func setVisible(_ visible: Bool) {
        if (nil == self.view) {
            return
        }
        self.view.isHidden = !visible
        return
    }
    @objc
    open func destroy() {
        if (nil == self.view) {
            return
        }
        self.view.removeFromSuperview()
        return
    }
    open func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + (request.url?.absoluteString)!)
        return true
    }
}
