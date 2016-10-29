package com.system.io;
import android.util.Log;
import com.system.identifier.TagPlugin;
public class PathPlugin {
    private static PathPlugin instance = null;
    private String dataPath;
    private String persistentDataPath;
    private String streamingAssetsPath;
    private String temporaryCachePath;
    private Boolean enableFill;
    private PathPlugin() {
        this.dataPath = "";
        this.persistentDataPath = "";
        this.streamingAssetsPath = "";
        this.temporaryCachePath = "";
        this.enableFill = true;
    }
    public static PathPlugin getInstance() {
        if (null == PathPlugin.instance) {
            PathPlugin.instance = new PathPlugin();
        }
        return PathPlugin.instance;
    }
    public void fill(String dataPath, String persistentDataPath, String streamingAssetsPath, String temporaryCachePath) {
        if (false == this.enableFill) {
            return;
        }
        this.dataPath = dataPath;
        this.persistentDataPath = persistentDataPath;
        this.streamingAssetsPath = streamingAssetsPath;
        this.temporaryCachePath = temporaryCachePath;
        this.enableFill = true;
        return;
    }
    public String getDataPath() {
        return this.dataPath;
    }
    public String getPersistentDataPath() {
        return this.persistentDataPath;
    }
    public String getStreamingAssetsPath() {
        return this.streamingAssetsPath;
    }
    public String getTemporaryCachePath() {
        return this.temporaryCachePath;
    }
    public void dump() {
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "dataPath in AndroidPlugin" + this.dataPath);
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "persistentDataPath in AndroidPlugin" + this.persistentDataPath);
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "streamingAssetsPath in AndroidPlugin" + this.streamingAssetsPath);
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "temporaryCachePath in AndroidPlugin" + this.temporaryCachePath);
        return;
    }
}