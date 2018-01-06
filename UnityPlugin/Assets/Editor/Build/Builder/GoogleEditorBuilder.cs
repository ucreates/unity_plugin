using UnityEngine;
using UnityPlugin.Core.Configure.Platform;
using UnityEditor.iOS.Xcode;
using System.IO;
using System.Diagnostics;
using System.Collections;
namespace Editor.Build {
public class GoogleEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 7;
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromiOSPluginRoot") || false == this.pathDictionary.ContainsKey("destiOSProjectRoot")) {
            return;
        }
        string fromiOSRootPath = this.pathDictionary["fromiOSPluginRoot"];
        string destiOSRootPath = this.pathDictionary["destiOSProjectRoot"];
        string fromFrameworkRootPath = this.pathDictionary["fromFrameworkRoot"];
        string destFrameworkRootPath = this.pathDictionary["destFrameworkRootAbsolute"];
        string[] innerPlistPathList = new string[] {
            "GoogleService-Info.plist",
        };
        string[] innerModuleFilePathList = new string[] {
            "Google/SignIn/SignIn.h",
            "Google/SignIn/module.modulemap",
        };
        foreach (string innerFilePath in innerPlistPathList) {
            string fromPath = Path.Combine(fromiOSRootPath, innerFilePath);
            string destPath = Path.Combine(destiOSRootPath, innerFilePath);
            if (false != File.Exists(destPath)) {
                File.Delete(destPath);
            }
            File.Copy(fromPath, destPath);
            string bundleGUID = project.AddFile(destPath, innerFilePath, PBXSourceTree.Source);
            project.AddFileToBuild(this.targetGUID, bundleGUID);
        }
        foreach (string innerFilePath in innerModuleFilePathList) {
            string fromPath = Path.Combine(fromFrameworkRootPath, innerFilePath);
            string destPath = Path.Combine(destFrameworkRootPath, innerFilePath);
            if (false != File.Exists(destPath)) {
                File.Delete(destPath);
            }
            File.Copy(fromPath, destPath);
        }
        project.AddBuildProperty(targetGUID, "SWIFT_INCLUDE_PATHS", "$(PROJECT_DIR)/Frameworks/Plugins/iOS/Frameworks/Google/SignIn");
        return;
    }
    public override void BuildiOSURLSchemes(PlistElementArray bundleURLTypesArray) {
        PlistElementDict bundleURLSchemaDict = bundleURLTypesArray.AddDict();
        bundleURLSchemaDict.SetString("CFBundleTypeRole", "Editor");
        PlistElementArray bundleURLSchemaArray = bundleURLSchemaDict.CreateArray("CFBundleURLSchemes");
        bundleURLSchemaArray.AddString(GoogleConfigurePlugin.REVERSED_CLIENT_ID);
        return;
    }
}
}
