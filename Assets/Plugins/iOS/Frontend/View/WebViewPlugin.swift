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
public class WebViewPlugin: NSObject, UIWebViewDelegate {
    var view: UIWebView!
    @objc
    public func create(url: String, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        let req: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        let width: CGFloat = controller.view.frame.width
        let height: CGFloat = controller.view.frame.height
        self.view = UIWebView()
        self.view.frame = CGRectMake(left, top, width - left - right, height - top - bottom)
        self.view.backgroundColor = UIColor.clearColor()
        self.view.opaque = false
        self.view.delegate = self
        self.view.loadRequest(req)
        controller.view.addSubview(self.view)
        return
    }
    @objc
    public func show() {
        self.setVisible(true)
        return
    }
    @objc
    public func hide() {
        self.setVisible(false)
        return
    }
    @objc
    public func setVisible(visible: Bool) {
        if (nil == self.view) {
            return
        }
        self.view.hidden = !visible
        return
    }
    @objc
    public func destroy() {
        if (nil == self.view) {
            return
        }
        self.view.removeFromSuperview()
        return
    }
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + (request.URL?.absoluteString)!)
        return true
    }
}