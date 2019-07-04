using UnityEngine;
using System.Collections;
public class NativeTextureAssetPluginEntity {
    public string fileName {
        get;
        set;
    }
    public int width {
        get;
        set;
    }
    public int height {
        get;
        set;
    }
    public float widthRatio {
        get;
        set;
    }
    public float heightRatio {
        get;
        set;
    }
    public bool enableAlphaChannel {
        get;
        set;
    }
    public NativeTextureAssetPluginEntity(string fileName, bool enableAlphaChannel) : this(fileName, 0, 0, enableAlphaChannel) {
    }
    public NativeTextureAssetPluginEntity(string fileName, int width, int height, bool enableAlphaChannel) {
        this.fileName = fileName;
        this.width = width;
        this.height = height;
        this.widthRatio = 1.0f;
        this.heightRatio = 1.0f;
        if (width > height) {
            this.widthRatio = (float)width / (float)height;
        } else if (height > width) {
            this.heightRatio = (float)height / (float)width;
        }
        this.enableAlphaChannel = enableAlphaChannel;
    }
    public void Reset() {
        this.widthRatio = 1.0f;
        this.heightRatio = 1.0f;
        if (width > height) {
            this.widthRatio = (float)width / (float)height;
        } else if (height > width) {
            this.heightRatio = (float)height / (float)width;
        }
        return;
    }
}
