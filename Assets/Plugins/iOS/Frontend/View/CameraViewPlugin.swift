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
import AVFoundation
open class CameraViewPlugin: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    fileprivate static let CAPTURE_QUALITY: CGFloat = 0
    fileprivate static let DISPATCH_QUEUE_NAME: String = "CAPTURE"
    fileprivate var session: AVCaptureSession!
    fileprivate var output: AVCaptureVideoDataOutput!
    fileprivate var camera: AVCaptureDevice!
    fileprivate var view: UIView!
    fileprivate var texture: String!
    fileprivate var queue: DispatchQueue!
    fileprivate var context: CIContext! = nil
    fileprivate var created: Bool = false
    @objc
    open func create() {
        func callback (granted: Bool) -> Void {
            if (false == granted || false != self.created) {
                return
            }
            let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
            if (status != AVAuthorizationStatus.authorized) {
                return
            }
            let deviceList: [AnyObject] = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as [AnyObject]
            for device: AnyObject in deviceList {
                if device.position == AVCaptureDevicePosition.back {
                    self.camera = device as! AVCaptureDevice
                    break
                }
            }
            if (nil == self.camera) {
                return
            }
            self.context = CIContext.init()
            self.queue = DispatchQueue(label: CameraViewPlugin.DISPATCH_QUEUE_NAME, attributes: [])
            self.output = AVCaptureVideoDataOutput()
            self.output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA)]
            self.output.setSampleBufferDelegate(self, queue: self.queue)
            self.output.alwaysDiscardsLateVideoFrames = true
            self.session = AVCaptureSession()
            self.session.sessionPreset = AVCaptureSessionPresetMedium
            self.texture = nil
            do {
                let supportedFrameRateRanges: NSArray = self.camera.activeFormat.videoSupportedFrameRateRanges as NSArray
                var duration: AVFrameRateRange = supportedFrameRateRanges[0] as! AVFrameRateRange
                for supportedFrameRateRange in supportedFrameRateRanges {
                    if ((supportedFrameRateRange as AnyObject).maxFrameRate > duration.maxFrameRate) {
                        duration = supportedFrameRateRange as! AVFrameRateRange
                    }
                }
                try self.camera.lockForConfiguration()
                self.camera.activeVideoMinFrameDuration = duration.minFrameDuration
                self.camera.activeVideoMaxFrameDuration = duration.maxFrameDuration
                self.camera.unlockForConfiguration()
            } catch {
                return
            }
            let capture: AVCaptureInput!
            do {
                capture = try AVCaptureDeviceInput.init(device: self.camera) as AVCaptureInput
                self.session.addInput(capture)
                self.session.addOutput(self.output)
            } catch {
                capture = nil
            }
            self.created = true
            self.session.startRunning()
        };
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: callback)
        return
    }
    @objc
    open func show() {
        if (nil == self.session) {
            return
        }
        self.session.startRunning()
        return
    }
    @objc
    open func update(_ suspend: Bool) {
        if (nil == self.session) {
            return
        }
        if (false != suspend) {
            self.hide()
        } else {
            self.show()
        }
        return
    }
    @objc
    open func hide() {
        if (nil == self.session) {
            return
        }
        self.session.stopRunning()
        return
    }
    @objc
    open func destroy() {
        if (nil == self.camera || false == self.created || nil == self.output || nil == self.session) {
            return
        }
        for output: Any in self.session.outputs {
            let avOutPut: AVCaptureOutput = output as! AVCaptureOutput
            self.session.removeOutput(avOutPut)
        }
        for input: Any in self.session.inputs {
            let avInPut: AVCaptureInput = input as! AVCaptureInput
            self.session.removeInput(avInPut)
        }
        self.session = nil
        self.output = nil
        self.camera = nil
        self.texture = nil
        self.created = false
        return
    }
    @objc
    open func getTexture() -> String! {
        return self.texture
    }
    open func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if (nil == sampleBuffer || false == self.created) {
            return
        }
        let dispatcher: () -> () = {
            autoreleasepool {
                let buffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
                CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
                let pixelBufferWidth: Int = CVPixelBufferGetWidth(buffer)
                let pixelBufferHeight: Int = CVPixelBufferGetHeight(buffer)
                let imageWidth: CGFloat = CGFloat(pixelBufferWidth)
                let imageHeight = CGFloat(pixelBufferHeight)
                let rect: CGRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
                let ciimage = CIImage(cvPixelBuffer: buffer)
                let cgimage = self.context.createCGImage(ciimage, from: rect)
                let image = UIImage(cgImage: cgimage!)
                let data: Data = UIImageJPEGRepresentation(image, CameraViewPlugin.CAPTURE_QUALITY)!
                CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
                self.texture = data.base64EncodedString(options: [])
            }
        }
        self.queue.async(execute: dispatcher)
    }
}
