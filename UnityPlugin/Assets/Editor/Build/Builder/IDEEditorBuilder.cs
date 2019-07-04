using UnityEngine;
using UnityEditor.iOS.Xcode;
using System.Collections;
namespace Editor.Build {
public class IDEEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 1;
    protected override void BuildiOS() {
        if (null == this.project) {
            return;
        }
        this.project.SetBuildProperty(this.targetGUID, "EMBEDDED_CONTENT_CONTAINS_SWIFT", "YES");
        this.project.SetBuildProperty(this.targetGUID, "SWIFT_OBJC_BRIDGING_HEADER", "$(SRCROOT)/Libraries/Plugins/iOS/Source/UnityiOSPlugin.h");
        this.project.SetBuildProperty(this.targetGUID, "LD_RUNPATH_SEARCH_PATHS", "$(inherited) @executable_path/Frameworks\"");
        this.project.SetBuildProperty(this.targetGUID, "GCC_OPTIMIZATION_LEVEL", "0");
        this.project.SetBuildProperty(this.targetGUID, "SWIFT_OPTIMIZATION_LEVEL", "-Onone");
        PlistElementDict rootDict = plist.root;
        rootDict.SetString("NSCameraUsageDescription", "Allow Access Camera By Unity Camera Plugin.");
        return;
    }
}
}
