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
import Fabric
import TwitterKit
open class TwitterViewControllerPlugin: UIViewController, TWTRComposerViewControllerDelegate {
    open static let VIEWCONTROLLER_ID: Int = 3
    fileprivate var authorized: Bool = false
    fileprivate var useTwitterCard: Bool!
    fileprivate var message: String!
    fileprivate var imageData: Data!
    @objc
    open override func viewDidAppear(_ animated: Bool) -> Void {
        super.viewDidAppear(animated)
        if (false != self.authorized) {
            return
        }
        self.authorized = true
        let fabricKitList: [AnyObject] = [Twitter.self]
        Fabric.with(fabricKitList)
        let service: TwitterServicePlugin = TwitterServicePlugin()
        func callback() -> Void {
            if (false == self.useTwitterCard) {
                func callback(_ result: TWTRComposerResult?) -> Void {
                    if (TWTRComposerResult.cancelled == result) {
                        service.logOut()
                    }
                    let controller: UIViewController = ViewControllerPlugin.getInstance()
                    controller.dismiss(animated: true, completion: nil)
                    return
                }
                let composer: TWTRComposer = TWTRComposer()
                let image: UIImage = UIImage(data: imageData)!
                composer.setText(message)
                composer.setImage(image)
                composer.show(from: self, completion: callback)
            } else {
                let service: TwitterServicePlugin = TwitterServicePlugin()
                let userId: String = service.getUserId()!
                if ("" == userId) {
                    service.logOut()
                    return
                }
                let image: UIImage = UIImage(data: imageData)!
                let device: UIDevice = UIDevice.current
                let idiom: UIUserInterfaceIdiom = device.userInterfaceIdiom
                let bundle: Bundle = Bundle.main
                // set your ios app bundle identifier. which is getting from Bundle.bundleIdentifier property. Sets the Apple App Store id for the promoted iPad app shown on iOS displays.
                let bundleId: String? = bundle.bundleIdentifier
                var iPhoneAppId: String? = nil
                var iPadAppId: String? = nil
                if (idiom == UIUserInterfaceIdiom.phone) {
                    iPhoneAppId = bundleId
                } else if (idiom == UIUserInterfaceIdiom.pad) {
                    iPadAppId = bundleId
                }
                let cardConfig = TWTRCardConfiguration.appCardConfiguration(withPromoImage: image, iPhoneAppID: iPhoneAppId, iPadAppID: iPadAppId, googlePlayAppID: nil)
                let composer = TWTRComposerViewController(userID: userId, cardConfiguration: cardConfig)
                composer.delegate = self
                self.present(composer, animated: true, completion: nil)
            }
            return
        }
        if (false == service.isLoggedIn()) {
            service.logIn(callback)
        } else {
            callback()
        }
        return
    }
    open func composerDidSucceed(_ controller: TWTRComposerViewController, with withTweet: TWTRTweet) -> Void {
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismiss(animated: true, completion: nil)
        return
    }
    open func composerDidCancel(_ controller: TWTRComposerViewController) -> Void {
        let service: TwitterServicePlugin = TwitterServicePlugin()
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        service.logOut()
        controller.dismiss(animated: true, completion: nil)
        return
    }
    open func composerDidFail(_ controller: TWTRComposerViewController, withError: Error) -> Void {
        let service: TwitterServicePlugin = TwitterServicePlugin()
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        service.logOut()
        controller.dismiss(animated: true, completion: nil)
        return
    }
    @objc
    open func setParameter(_ post: String, postImageData: Data, enableTwitterCard: Bool) -> Void {
        self.message = post
        self.imageData = postImageData
        self.useTwitterCard = enableTwitterCard
        return
    }
}
