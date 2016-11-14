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
public class PathPlugin: NSObject {
    static var instance: PathPlugin!
    var dataPath: String!
    var persistentDataPath: String!
    var streamingAssetsPath: String!
    var temporaryCachePath: String!
    var enableFill: Bool!
    private override init() {
        self.dataPath = ""
        self.persistentDataPath = ""
        self.streamingAssetsPath = ""
        self.temporaryCachePath = ""
        self.enableFill = true
        return
    }
    @objc
    public class func getInstance() -> PathPlugin {
        if (nil == PathPlugin.instance) {
            PathPlugin.instance = PathPlugin()
        }
        return PathPlugin.instance
    }
    @objc
    public func fill(dataPath: String, persistentDataPath: String, streamingAssetsPath: String, temporaryCachePath: String) -> Void {
        if (false == self.enableFill) {
            return
        }
        self.dataPath = dataPath
        self.persistentDataPath = persistentDataPath
        self.streamingAssetsPath = streamingAssetsPath
        self.temporaryCachePath = temporaryCachePath
        self.enableFill = false
        return
    }
    public func getDataPath() -> String! {
        return self.dataPath
    }
    public func getPersistentDataPath() -> String! {
        return self.persistentDataPath
    }
    public func getStreamingAssetsPath() -> String! {
        return self.streamingAssetsPath
    }
    public func getTemporaryCachePath() -> String! {
        return self.temporaryCachePath
    }
    public func dump() {
        print("dataPath in iOSPlugin::" + self.dataPath)
        print("persistentDataPath in iOSPlugin::" + self.persistentDataPath)
        print("streamingAssetsPath in iOSPlugin::" + self.streamingAssetsPath)
        print("temporaryCachePath in iOSPlugin::" + self.temporaryCachePath)
        return
    }
}