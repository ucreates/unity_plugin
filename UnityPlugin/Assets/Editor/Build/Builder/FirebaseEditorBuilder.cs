using UnityEngine;
using UnityPlugin.Core.Configure.Sns;
using UnityEditor.iOS.Xcode;
using System.IO;
using System.Diagnostics;
using System.Collections;
namespace Editor.Build {
public class FirebaseEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 6;
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromFrameworkRoot") || false == this.pathDictionary.ContainsKey("destFrameworkRoot")) {
            return;
        }
        string fromFrameworkRootPath = this.pathDictionary["fromFrameworkRoot"];
        string destFrameworkRootPath = this.pathDictionary["destFrameworkRootAbsolute"];
        string[] innerFilePathList = new string[] {
            "Firebase/Firebase.h",
            "Firebase/module.modulemap",
        };
        foreach (string innerFilePath in innerFilePathList) {
            string fromPath = Path.Combine(fromFrameworkRootPath, innerFilePath);
            string destPath = Path.Combine(destFrameworkRootPath, innerFilePath);
            if (false != File.Exists(destPath)) {
                File.Delete(destPath);
            }
            File.Copy(fromPath, destPath);
        }
        project.AddBuildProperty(targetGUID, "SWIFT_INCLUDE_PATHS", "$(PROJECT_DIR)/Frameworks/Plugins/iOS/Frameworks/Firebase");
        return;
    }
}
}
