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
import LineSDK
open class LineViewControllerPlugin: UIViewController {
    @objc
    public static let VIEWCONTROLLER_ID: Int = 5
    fileprivate let sercice: LineServicePlugin! = LineServicePlugin()
    fileprivate var imageData: Data!
    open override func viewDidAppear(_ animated: Bool) -> Void {
        super.viewDidAppear(animated)
        LoginManager.shared.login(permissions: [.profile], in: self) {
            result in
            switch result {
            case .success(let loginResult):
                let image: UIImage = UIImage(data: self.imageData)!
                let pngImage: Data = UIImagePNGRepresentation(image)!
                UIPasteboard.general.setData(pngImage, forPasteboardType: "public.png")
                let url = URL(string: "line://msg/image/" + UIPasteboard.general.name.rawValue)!
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.sercice.logOut {
                    func callback() -> Void {
                        let controller: UIViewController = ViewControllerPlugin.getInstance()
                        controller.dismiss(animated: true, completion: nil)
                        AlertViewPlugin.show(error.localizedDescription)
                        return
                    }
                    self.dismiss(animated: true, completion: callback)
                }
            }
        }
        return
    }
    @objc
    open func setParameter(postImageData: Data) -> Void {
        self.imageData = postImageData
        return
    }
}
