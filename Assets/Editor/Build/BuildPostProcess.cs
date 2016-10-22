using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;
using System.IO;
namespace Editor.Build {
public class BuildPostProcess {
    [PostProcessBuild]
    static void OnPostProcessBuild(BuildTarget buildTarget, string buildPath) {
        if (buildTarget != BuildTarget.iOS) {
            return;
        }
        PBXProject project = new PBXProject();
        PlistDocument plistDocument = new PlistDocument();
        string projectPath = PBXProject.GetPBXProjectPath(buildPath);
        string plistPath = Path.Combine(buildPath, "Info.plist");
        project.ReadFromFile(projectPath);
        string targetName = PBXProject.GetUnityTargetName();
        string targetGUID = project.TargetGuidByName(targetName);
        project.SetBuildProperty(targetGUID, "EMBEDDED_CONTENT_CONTAINS_SWIFT", "YES");
        project.SetBuildProperty(targetGUID, "SWIFT_OBJC_BRIDGING_HEADER", "$(SRCROOT)/Libraries/Plugins/iOS/UnityiOSPlugin.h");
        project.SetBuildProperty(targetGUID, "LD_RUNPATH_SEARCH_PATHS", "$(inherited) @executable_path/Frameworks\"");
        project.SetBuildProperty(targetGUID, "GCC_OPTIMIZATION_LEVEL", "0");
        project.SetBuildProperty(targetGUID, "SWIFT_OPTIMIZATION_LEVEL", "-Onone");
        project.WriteToFile(projectPath);
        plistDocument.ReadFromFile(plistPath);
        plistDocument.root.SetString("NSCameraUsageDescription", "Allow Access Camera By Unity Camera Plugin.");
        plistDocument.WriteToFile(plistPath);
        return;
    }
}
}
