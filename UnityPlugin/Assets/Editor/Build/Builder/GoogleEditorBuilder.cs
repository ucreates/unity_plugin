using UnityEngine;
using UnityEditor.iOS.Xcode;
using UnityPlugin.Core.Configure.Sns;
using System.Collections;
using System.Diagnostics;
using System.IO;
namespace Editor.Build {
public class GoogleEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 7;
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromiOSPluginRoot") || false == this.pathDictionary.ContainsKey("destiOSProjectRoot")) {
            return;
        }
        string fromiOSRootPath = this.pathDictionary["fromiOSPluginRoot"];
        string destiOSRootPath = this.pathDictionary["destiOSProjectRoot"];
        string[] innerFilePathList = new string[] {
            "GoogleService-Info.plist"
        };
        foreach (string innerFilePath in innerFilePathList) {
            string fromPath = Path.Combine(fromiOSRootPath, innerFilePath);
            string destPath = Path.Combine(destiOSRootPath, innerFilePath);
            if (false != File.Exists(destPath)) {
                File.Delete(destPath);
            }
            File.Copy(fromPath, destPath);
            string bundleGUID = project.AddFile(destPath, innerFilePath, PBXSourceTree.Source);
            project.AddFileToBuild(this.targetGUID, bundleGUID);
        }
        return;
    }
}
}
