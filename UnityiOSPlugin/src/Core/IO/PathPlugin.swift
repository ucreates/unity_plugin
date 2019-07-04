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
open class PathPlugin: NSObject {
    static var instance: PathPlugin!
    var dataPath: String!
    var persistentDataPath: String!
    var streamingAssetsPath: String!
    var temporaryCachePath: String!
    var enableFill: Bool!
    fileprivate override init() {
        self.dataPath = ""
        self.persistentDataPath = ""
        self.streamingAssetsPath = ""
        self.temporaryCachePath = ""
        self.enableFill = true
        return
    }
    @objc
    open class func getInstance() -> PathPlugin {
        if (nil == PathPlugin.instance) {
            PathPlugin.instance = PathPlugin()
        }
        return PathPlugin.instance
    }
    @objc
    open func fill(_ dataPath: String, persistentDataPath: String, streamingAssetsPath: String, temporaryCachePath: String) -> Void {
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
    open func getDataPath() -> String! {
        return self.dataPath
    }
    open func getPersistentDataPath() -> String! {
        return self.persistentDataPath
    }
    open func getStreamingAssetsPath() -> String! {
        return self.streamingAssetsPath
    }
    open func getTemporaryCachePath() -> String! {
        return self.temporaryCachePath
    }
    @objc
    open func dump() -> Void {
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "dataPath::" + self.dataPath)
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "persistentDataPath::" + self.persistentDataPath)
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "streamingAssetsPath::" + self.streamingAssetsPath)
        print(TagPlugin.UNITY_PLUGIN_IDENTIFIER + "temporaryCachePath::" + self.temporaryCachePath)
        return
    }
}
