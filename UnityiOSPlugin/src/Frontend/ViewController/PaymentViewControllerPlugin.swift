// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import UIKit
import StoreKit
open class PaymentViewControllerPlugin: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @objc
    public static let VIEWCONTROLLER_ID: Int = 6
    fileprivate var userId: String!
    fileprivate var productId: String!
    fileprivate var service: PaymentServicePlugin!
    open override func viewDidLoad() -> Void {
        super.viewDidLoad()
        self.service = PaymentServicePlugin()
        let ret: Bool = service.request(prodctId: self.productId, paymentViewController: self)
        if (false == ret) {
            self.dismiss(animated: true, completion: nil)
        }
        return
    }
    open func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) -> Void {
        self.service.request(response: response, paymentViewController: self)
        return
    }
    open func request(_ request: SKRequest, didFailWithError error: Error) -> Void {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "didFailWithError::" + error.localizedDescription)
        return
    }
    open func requestDidFinish(_ request: SKRequest) -> Void {
        return
    }
    open func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) -> Void {
        self.service.payment(userId: self.userId, transactions: transactions)
        return
    }
    open func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) -> Void {
        self.service.destroy(paymentViewController: self)
        self.dismiss(animated: true, completion: nil)
        return
    }
    open func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) -> Void {
        self.service.update(downloads: downloads)
        return
    }
    open func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) -> Void {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "restoreCompletedTransactionsFailedWithError::" + error.localizedDescription)
        self.dismiss(animated: true, completion: nil)
        return
    }
    open func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) -> Void {
        self.service.destroy(paymentViewController: self)
        self.dismiss(animated: true, completion: nil)
        return
    }
    @objc
    open func setParameter(_ unityUserId: String, unityProductId: String) -> Void {
        self.productId = unityProductId
        self.userId = unityUserId
        return
    }
}
