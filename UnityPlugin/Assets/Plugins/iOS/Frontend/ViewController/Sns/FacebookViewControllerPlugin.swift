// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import UIKit
open class FacebookViewControllerPlugin: UIViewController, FBSDKSharingDelegate {
    open static let VIEWCONTROLLER_ID: Int = 4
    fileprivate var authorized: Bool = false
    fileprivate var imageData: Data!
    open override func viewDidAppear(_ animated: Bool) -> Void {
        super.viewDidAppear(animated)
        if (false != self.authorized) {
            return
        }
        self.authorized = true
        let service: FacebookServicePlugin = FacebookServicePlugin()
        func callback() -> Void {
            if (false == service.hasPermission(permission: "publish_actions")) {
                let controller: UIViewController = ViewControllerPlugin.getInstance()
                controller.dismiss(animated: true, completion: nil)
                return
            }
            let image: UIImage = UIImage(data: imageData)!
            let sharePhoto: FBSDKSharePhoto = FBSDKSharePhoto(image: image, userGenerated: true)
            let photoContent: FBSDKSharePhotoContent = FBSDKSharePhotoContent()
            let photoContentCopy: Any = sharePhoto.copy()
            photoContent.photos = [photoContentCopy]
            FBSDKShareDialog.show(from: self, with: photoContent, delegate: self)
            return
        }
        if (false == service.isLoggedIn()) {
            service.logIn(facebookViewController: self, callback: callback)
        } else {
            callback()
        }
        return
    }
    open func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable: Any]!) -> Void {
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismiss(animated: true, completion: nil)
        return
    }
    open func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) -> Void {
        let service: FacebookServicePlugin = FacebookServicePlugin()
        service.logOut()
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismiss(animated: true, completion: nil)
        return
    }
    open func sharerDidCancel(_ sharer: FBSDKSharing!) -> Void {
        let service: FacebookServicePlugin = FacebookServicePlugin()
        service.logOut()
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismiss(animated: true, completion: nil)
        return
    }
    @objc
    open func setParameter(postImageData: Data) -> Void {
        self.imageData = postImageData
        return
    }
}
