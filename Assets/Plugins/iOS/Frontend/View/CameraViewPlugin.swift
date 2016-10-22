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
public class CameraViewPlugin: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private static let CAPTURE_QUALITY: CGFloat = 0
    private static let DISPATCH_QUEUE_NAME: String = "CAPTURE"
    private var session: AVCaptureSession!
    private var output: AVCaptureVideoDataOutput!
    private var camera: AVCaptureDevice!
    private var view: UIView!
    private var texture: String!
    private var queue: dispatch_queue_t!
    private var context: CIContext! = nil
    private var created: Bool = false
    @objc
    public func create() {
        if (false != self.created) {
            return
        }
        let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        if (status != AVAuthorizationStatus.Authorized) {
            return
        }
        let deviceList: [AnyObject] = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device: AnyObject in deviceList {
            if device.position == AVCaptureDevicePosition.Back {
                self.camera = device as! AVCaptureDevice
                break
            }
        }
        if (nil == self.camera) {
            return
        }
        self.context = CIContext.init()
        self.queue = dispatch_queue_create(CameraViewPlugin.DISPATCH_QUEUE_NAME, DISPATCH_QUEUE_SERIAL)
        self.output = AVCaptureVideoDataOutput()
        self.output.videoSettings = [kCVPixelBufferPixelFormatTypeKey: Int(kCVPixelFormatType_32BGRA)]
        self.output.setSampleBufferDelegate(self, queue: self.queue)
        self.output.alwaysDiscardsLateVideoFrames = true
        self.session = AVCaptureSession()
        self.session.sessionPreset = AVCaptureSessionPresetMedium
        self.texture = nil
        do {
            let supportedFrameRateRanges: NSArray = self.camera.activeFormat.videoSupportedFrameRateRanges
            var duration: AVFrameRateRange = supportedFrameRateRanges[0] as! AVFrameRateRange
            for supportedFrameRateRange in supportedFrameRateRanges {
                if (supportedFrameRateRange.maxFrameRate > duration.maxFrameRate) {
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
        return
    }
    @objc
    public func show() {
        if (nil == self.session) {
            return
        }
        self.session.startRunning()
        return
    }
    @objc
    public func update(suspend: Bool) {
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
    public func hide() {
        if (nil == self.session) {
            return
        }
        self.session.stopRunning()
        return
    }
    @objc
    public func destroy() {
        if (nil == self.camera || false == self.created || nil == self.output || nil == self.session) {
            return
        }
        for output: AnyObject in self.session.outputs {
            let avOutPut: AVCaptureOutput = output as! AVCaptureOutput
            self.session.removeOutput(avOutPut)
        }
        for input: AnyObject in self.session.inputs {
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
    public func getTexture() -> String! {
        return self.texture
    }
    public func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        if (nil == sampleBuffer || false == self.created) {
            return
        }
        let dispatcher: dispatch_block_t = {
            autoreleasepool {
                let buffer: CVImageBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer)!
                CVPixelBufferLockBaseAddress(buffer, 0)
                let pixelBufferWidth: Int = CVPixelBufferGetWidth(buffer)
                let pixelBufferHeight: Int = CVPixelBufferGetHeight(buffer)
                let imageWidth: CGFloat = CGFloat(pixelBufferWidth)
                let imageHeight = CGFloat(pixelBufferHeight)
                let rect: CGRect = CGRectMake(0, 0, imageWidth, imageHeight)
                let ciimage = CIImage(CVPixelBuffer: buffer)
                let cgimage = self.context.createCGImage(ciimage, fromRect: rect)
                let image = UIImage(CGImage: cgimage)
                let data: NSData = UIImageJPEGRepresentation(image, CameraViewPlugin.CAPTURE_QUALITY)!
                CVPixelBufferUnlockBaseAddress(buffer, 0)
                self.texture = data.base64EncodedStringWithOptions([])
            }
        }
        dispatch_async(self.queue, dispatcher)
    }
}