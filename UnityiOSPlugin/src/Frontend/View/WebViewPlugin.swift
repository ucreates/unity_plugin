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
import WebKit
open class WebViewPlugin: NSObject, WKUIDelegate, WKNavigationDelegate {
    var view: WKWebView!
    @objc
    open func create(_ url: String, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat, baseWidth: CGFloat, baseHeight: CGFloat) -> Void {
        let req: URLRequest = URLRequest(url: URL(string: url)!)
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        let leftMarginRate: CGFloat = left / baseWidth
        let rightMarginRate: CGFloat = right / baseWidth
        let topMarginRate: CGFloat = top / baseHeight
        let bottomMarginRate: CGFloat = bottom / baseHeight
        let leftMargin: CGFloat = UIScreen.main.bounds.size.width * leftMarginRate
        let rightMargin: CGFloat = UIScreen.main.bounds.size.width * rightMarginRate
        let topMargin: CGFloat = UIScreen.main.bounds.size.height * topMarginRate
        let bottomMargin: CGFloat = UIScreen.main.bounds.size.height * bottomMarginRate
        let width: CGFloat = UIScreen.main.bounds.size.width - leftMargin - rightMargin
        let height: CGFloat = UIScreen.main.bounds.size.height - topMargin - bottomMargin
        let frame: CGRect = CGRect(x: leftMargin, y: topMargin, width: width, height: height)
        let webConfiguration: WKWebViewConfiguration = WKWebViewConfiguration()
        self.view = WKWebView(frame: frame, configuration: webConfiguration)
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        self.view.uiDelegate = self
        self.view.navigationDelegate = self
        self.view.load(req)
        controller.view.addSubview(self.view)
        return
    }
    @objc
    open func show() -> Void {
        self.setVisible(true)
        return
    }
    @objc
    open func hide() -> Void {
        self.setVisible(false)
        return
    }
    @objc
    open func setVisible(_ visible: Bool) -> Void {
        if (nil == self.view) {
            return
        }
        self.view.isHidden = !visible
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
    @available(iOS 8.0, *)
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        return
    }
    @available(iOS 8.0, *)
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
        return
    }
}

