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
    fileprivate static let CAPTURE_SIZE: String = "480x640"
    fileprivate static let DISPATCH_QUEUE_NAME: String = "CAPTURE"
    fileprivate static let COMPLETE_DESTROY_MESSAGE: String = "complete destroy camera"
    fileprivate var camera: AVCaptureDevice!
    fileprivate var created: Bool = false
    fileprivate var output: AVCaptureVideoDataOutput!
    fileprivate var queue: DispatchQueue!
    fileprivate var session: AVCaptureSession!
    fileprivate var view: UIView!
    fileprivate var callbackGameObjectName: String!
    fileprivate var hideCallbackName: String!
    @objc
    open func create(gameObjectName: String, onShowCallbackName: String, onHideCallbackName: String) -> Void {
        if (false != self.created) {
            self.show()
            return
        }
        self.callbackGameObjectName = gameObjectName
        self.hideCallbackName = onHideCallbackName
        func callback(granted: Bool) -> Void {
            if (false == granted) {
                return
            }
            var deviceList: [AnyObject] = [AnyObject]()
            if #available(iOS 10.0, *) {
                var deviceTypes: [AVCaptureDeviceType] = [AVCaptureDeviceType]()
                if #available(iOS 10.2, *) {
                    deviceTypes.append(AVCaptureDeviceType.builtInDualCamera)
                }
                deviceTypes.append(AVCaptureDeviceType.builtInDuoCamera)
                deviceTypes.append(AVCaptureDeviceType.builtInTelephotoCamera)
                deviceTypes.append(AVCaptureDeviceType.builtInWideAngleCamera)
                let deviceSession: AVCaptureDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: deviceTypes, mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified)
                deviceList = deviceSession.devices
            } else {
                deviceList = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as [AnyObject]
            }
            for device: AnyObject in deviceList {
                if device.position == AVCaptureDevicePosition.back {
                    self.camera = device as! AVCaptureDevice
                    break
                }
            }
            if (nil == self.camera) {
                return
            }
            self.queue = DispatchQueue(label: CameraViewPlugin.DISPATCH_QUEUE_NAME, attributes: [])
            self.output = AVCaptureVideoDataOutput()
            self.output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)]
            self.output.setSampleBufferDelegate(self, queue: self.queue)
            self.output.alwaysDiscardsLateVideoFrames = true
            self.session = AVCaptureSession()
            self.session.sessionPreset = AVCaptureSessionPreset640x480
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
                print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.localizedDescription)
                return
            }
            let capture: AVCaptureInput!
            do {
                capture = try AVCaptureDeviceInput(device: self.camera) as AVCaptureInput
                self.session.addInput(capture)
                self.session.addOutput(self.output)
            } catch {
                print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + error.localizedDescription)
                capture = nil
                return
            }
            self.session.beginConfiguration()
            var videoConnection: AVCaptureConnection? = nil
            for connectionObject: Any in self.output.connections {
                let connection: AVCaptureConnection = connectionObject as! AVCaptureConnection
                for portObject: Any in connection.inputPorts {
                    let port: AVCaptureInputPort = portObject as! AVCaptureInputPort
                    if (port.mediaType == AVMediaTypeVideo) {
                        videoConnection = connection
                        break
                    }
                }
            }
            if (false != videoConnection?.isVideoOrientationSupported) {
                videoConnection?.videoOrientation = AVCaptureVideoOrientation.portrait
            }
            self.session.commitConfiguration()
            UnityNotifierPlugin.notify(gameObjectName, methodName: onShowCallbackName, parameter: CameraViewPlugin.CAPTURE_SIZE)
            self.created = true
            self.show()
            return
        }
        let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if (status != AVAuthorizationStatus.authorized) {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: callback)
        } else {
            callback(granted: true)
        }
        return
    }
    @objc
    open func show() -> Void {
        if (nil == self.session || false == self.created) {
            return
        }
        self.session.startRunning()
        return
    }
    @objc
    open func update(_ suspend: Bool) -> Void {
        if (nil == self.session || false == self.created) {
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
    open func hide() -> Void {
        if (nil == self.session || false == self.created) {
            return
        }
        self.session.stopRunning()
        return
    }
    @objc
    open func destroy() -> Void {
        if (nil == self.camera || false == self.created || nil == self.output || nil == self.session) {
            return
        }
        self.hide()
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
        self.created = false
        UnityNotifierPlugin.notify(self.callbackGameObjectName, methodName: self.hideCallbackName, parameter: CameraViewPlugin.COMPLETE_DESTROY_MESSAGE)
        return
    }
    open func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) -> Void {
        if (nil == sampleBuffer || false == self.created) {
            return
        }
        let dispatcher: () -> Void = {
            autoreleasepool {
                let buffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
                let lockFrag: CVPixelBufferLockFlags = CVPixelBufferLockFlags(rawValue: 0)
                CVPixelBufferLockBaseAddress(buffer, lockFrag)
                let baseAddress: UnsafeMutableRawPointer = CVPixelBufferGetBaseAddress(buffer)!
                let pixelBuffer: UnsafeMutablePointer<UInt8> = baseAddress.assumingMemoryBound(to: UInt8.self)
                let pixelBufferWidth: Int = CVPixelBufferGetWidth(buffer)
                let pixelBufferHeight: Int = CVPixelBufferGetHeight(buffer)
                CVPixelBufferUnlockBaseAddress(buffer, lockFrag)
                setPreviewFrameCameraViewPlugin(pixelBuffer, Int32(pixelBufferWidth), Int32(pixelBufferHeight))
            }
        }
        self.queue.async(execute: dispatcher)
        return
    }
}
