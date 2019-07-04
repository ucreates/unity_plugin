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
open class PaymentServicePlugin: NSObject {
    fileprivate static let VERIFY_RECIPT_URL: String = "https://buy.itunes.apple.com/verifyReceipt"
    fileprivate var downloadProgress: Float?
    fileprivate var downloadAssetPath: String?
    open func request(prodctId: String, paymentViewController: PaymentViewControllerPlugin) -> Bool {
        let ret: Bool = SKPaymentQueue.canMakePayments()
        if (false == ret) {
            return false
        }
        self.clear()
        var productSet: Set<String> = Set<String>()
        productSet.insert(prodctId)
        let req: SKProductsRequest = SKProductsRequest(productIdentifiers: productSet)
        req.delegate = paymentViewController
        req.start()
        return true
    }
    open func request(response: SKProductsResponse, paymentViewController: PaymentViewControllerPlugin) -> Void {
        if (0 < response.invalidProductIdentifiers.count) {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "invalidItem::" + response.invalidProductIdentifiers.debugDescription)
            return
        }
        let queue: SKPaymentQueue = SKPaymentQueue.default()
        queue.add(paymentViewController)
        for product: SKProduct in response.products {
            let payment: SKPayment = SKPayment(product: product)
            queue.add(payment)
        }
        return
    }
    open func payment(userId: String, transactions: [SKPaymentTransaction]) -> Void {
        let queue: SKPaymentQueue = SKPaymentQueue.default()
        for transaction: SKPaymentTransaction in transactions {
            switch (transaction.transactionState) {
            case SKPaymentTransactionState.purchasing:
                break
            case SKPaymentTransactionState.purchased:
                queue.finishTransaction(transaction)
                self.verify(userId: userId)
                break
            case SKPaymentTransactionState.failed:
                queue.finishTransaction(transaction)
                break
            case SKPaymentTransactionState.restored:
                queue.finishTransaction(transaction)
                break
            default:
                queue.finishTransaction(transaction)
                break
            }
        }
        return
    }
    open func verify(userId: String) -> Void {
        let queue: SKPaymentQueue = SKPaymentQueue.default()
        let receiptUrl: URL? = Bundle.main.appStoreReceiptURL
        let receiptData: NSData? = NSData(contentsOf: receiptUrl!)
        if (nil == receiptData) {
            return
        }
        do {
            let receiptDataString: NSString = receiptData!.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithCarriageReturn) as NSString
            let requestParams: NSDictionary = ["receipt-data": receiptDataString] as NSDictionary
            let requestBodyData: Data = try JSONSerialization.data(withJSONObject: requestParams, options: JSONSerialization.WritingOptions.prettyPrinted)
            let storeUrl: URL = URL(string: PaymentServicePlugin.VERIFY_RECIPT_URL)!
            var request = URLRequest(url: storeUrl)
            request.httpMethod = "POST"
            request.httpBody = requestBodyData
            let session: URLSession = URLSession.shared
            func callback(data: Data?, response: URLResponse?, error: Error?) -> Void {
                print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + userId)
                print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + response.debugDescription)
                // send your purchase data.
                return
            }
            let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: callback)
            task.resume()
        } catch {
            print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.localizedDescription)
        }
        return
    }
    open func update(downloads: [SKDownload]) -> Void {
        let queue: SKPaymentQueue = SKPaymentQueue.default()
        for download: AnyObject in downloads {
            let download: SKDownload? = download as? SKDownload
            if (nil == download) {
                continue
            }
            let state: SKDownloadState = (download?.downloadState)!
            switch state {
            case SKDownloadState.active:
                self.downloadProgress = download?.progress
                break
            case SKDownloadState.cancelled:
                self.downloadProgress = 0.0
                break
            case SKDownloadState.failed:
                self.downloadProgress = 0.0
                break
            case SKDownloadState.finished:
                self.downloadAssetPath = download?.contentURL?.relativePath
                queue.finishTransaction((download?.transaction)!)
                break
            case SKDownloadState.paused:
                break
            case SKDownloadState.waiting:
                break
            }
        }
        return
    }
    open func clear() -> Void {
        let queue: SKPaymentQueue = SKPaymentQueue.default()
        if (0 == queue.transactions.count) {
            return
        }
        for transaction: SKPaymentTransaction in queue.transactions {
            if (SKPaymentTransactionState.purchasing == transaction.transactionState) {
                continue
            }
            queue.finishTransaction(transaction)
        }
        return
    }
    open func destroy(paymentViewController: PaymentViewControllerPlugin) -> Void {
        let queue: SKPaymentQueue = SKPaymentQueue.default()
        queue.remove(paymentViewController)
        return
    }
    open func getDownloadProgress() -> Float! {
        return self.downloadProgress
    }
    open func getDownloadedAssetPath() -> String? {
        return self.downloadAssetPath
    }
}
