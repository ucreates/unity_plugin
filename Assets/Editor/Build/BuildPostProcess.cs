using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;
namespace Editor.Build {
public class BuildPostProcess {
    [PostProcessBuild]
    static void OnPostProcessBuild(BuildTarget buildTarget, string buildPath) {
        if (buildTarget != BuildTarget.iOS) {
            return;
        }
        PBXProject project = new PBXProject();
        string path = PBXProject.GetPBXProjectPath(buildPath);
        project.ReadFromFile(path);
        string target = project.TargetGuidByName(PBXProject.GetUnityTargetName());
        project.SetBuildProperty(target, "EMBEDDED_CONTENT_CONTAINS_SWIFT", "YES");
        project.SetBuildProperty(target, "SWIFT_OBJC_BRIDGING_HEADER", "$(SRCROOT)/Libraries/Plugins/iOS/UnityiOSPlugin.h");
        project.SetBuildProperty(target, "LD_RUNPATH_SEARCH_PATHS", "$(inherited) @executable_path/Frameworks\"");
        project.WriteToFile(path);
    }
}
}
