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
class LineViewControllerPlugin: UIViewController {
    open static let VIEWCONTROLLER_ID: Int = 5
    fileprivate var authorized: Bool = false
    fileprivate var imageData: Data!
    fileprivate var service: LineServicePlugin? = nil
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (false != self.authorized) {
            return
        }
        self.authorized = true
        self.service = LineServicePlugin()
        NotificationCenter.default.addObserver(self, selector: #selector(LineViewControllerPlugin.authorizationDidChange(_:)), name: NSNotification.Name.LineAdapterAuthorizationDidChange, object: nil)
        if (false == self.service?.isLoggedIn()) {
            self.service?.logIn(lineViewController: self)
        } else {
            let lineAdapter: LineAdapter = (self.service?.getLineAdapter())!
            self.authorizationDidChangeByLineAdapter(lineAdapter)
        }
        return
    }
    func authorizationDidChange(_ notification: Notification) {
        let adapter: LineAdapter = notification.object as! LineAdapter
        if let error = notification.userInfo?["error"] as? NSError {
            func callback() -> Void {
                AlertViewPlugin.show(error.localizedFailureReason!)
                service?.logOut()
                return
            }
            let controller: UIViewController = ViewControllerPlugin.getInstance()
            controller.dismiss(animated: true, completion: callback)
            return
        }
        self.authorizationDidChangeByLineAdapter(adapter)
        return
    }
    func authorizationDidChangeByLineAdapter(_ adapter: LineAdapter) {
        if (false == adapter.isAuthorized) {
            return
        } else if (false == adapter.canAuthorizeUsingLineApp) {
            func callback() -> Void {
                service?.logOut()
                AlertViewPlugin.show("not installed LINE.")
                return
            }
            let controller: UIViewController = ViewControllerPlugin.getInstance()
            controller.dismiss(animated: true, completion: callback)
            return
        }
        let image: UIImage = UIImage(data: imageData)!
        let pngImage: Data = UIImagePNGRepresentation(image)!
        UIPasteboard.general.setData(pngImage, forPasteboardType: "public.png")
        let url = URL(string: "line://msg/image/" + UIPasteboard.general.name.rawValue)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        self.dismiss(animated: true, completion: nil)
        return
    }
    func cancel(_ sender: AnyObject) {
        func callback() -> Void {
            service?.logOut()
            return
        }
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismiss(animated: true, completion: callback)
        return
    }
    @objc
    open func setParameter(postImageData: Data) {
        self.imageData = postImageData
        return
    }
}

