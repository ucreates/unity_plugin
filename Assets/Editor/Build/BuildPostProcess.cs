using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;
using System.IO;
using System.Collections.Generic;
namespace Editor.Build {
public class BuildPostProcess {
    [PostProcessBuild]
    public static void OnPostProcessBuild(BuildTarget buildTarget, string buildPath) {
        int[] builderIdList = new int[] {
            IDEEditorBuilder.BUILDER_ID,
            TwitterEditorBuilder.BUILDER_ID,
            FacebookEditorBuilder.BUILDER_ID,
            LineEditorBuilder.BUILDER_ID,
        };
        if (buildTarget == BuildTarget.iOS) {
            PBXProject project = new PBXProject();
            PlistDocument plist = new PlistDocument();
            string projectPath = PBXProject.GetPBXProjectPath(buildPath);
            string plistPath = Path.Combine(buildPath, @"Info.plist");
            string fromCliRootPath = Path.Combine(System.Environment.CurrentDirectory, @"Assets/Editor/Cli/iOS");
            string destCliRootPath = buildPath;
            string fromFrameworkRootPath = Path.Combine(System.Environment.CurrentDirectory, @"Assets/Plugins/iOS/Frameworks");
            string destFrameworkRootPath = "Frameworks/Plugins/iOS/Frameworks";
            Dictionary<string, string> pathDictionary = new Dictionary<string, string>();
            pathDictionary.Add("build", buildPath);
            pathDictionary.Add("fromCliRoot", fromCliRootPath);
            pathDictionary.Add("destCliRoot", destCliRootPath);
            pathDictionary.Add("fromFrameworkRoot", fromFrameworkRootPath);
            pathDictionary.Add("destFrameworkRoot", destFrameworkRootPath);
            project.ReadFromFile(projectPath);
            plist.ReadFromFile(plistPath);
            string targetName = PBXProject.GetUnityTargetName();
            string targetGUID = project.TargetGuidByName(targetName);
            foreach (int builderId in builderIdList) {
                BaseEditorBuilder builder = EditorBuilderFactory.FactoryMethod(builderId);
                builder.project = project;
                builder.plist = plist;
                builder.targetGUID = targetGUID;
                builder.pathDictionary = pathDictionary;
                builder.Build(BuildTarget.iOS);
                project = builder.project;
                plist = builder.plist;
            }
            PlistElementDict rootDict = plist.root;
            PlistElementArray bundleURLTypesArray = rootDict.CreateArray("CFBundleURLTypes");
            foreach (int builderId in builderIdList) {
                BaseEditorBuilder builder = EditorBuilderFactory.FactoryMethod(builderId);
                builder.BuildiOSURLSchemes(bundleURLTypesArray);
            }
            PlistElementArray lsApplicationQueriesSchemesArray = rootDict.CreateArray("LSApplicationQueriesSchemes");
            foreach (int builderId in builderIdList) {
                BaseEditorBuilder builder = EditorBuilderFactory.FactoryMethod(builderId);
                builder.BuildiOSApplicationQueriesSchemes(lsApplicationQueriesSchemesArray);
            }
            plist.WriteToFile(plistPath);
            project.WriteToFile(projectPath);
            foreach (int builderId in builderIdList) {
                BaseEditorBuilder builder = EditorBuilderFactory.FactoryMethod(builderId);
                builder.targetGUID = targetGUID;
                builder.pathDictionary = pathDictionary;
                builder.Run(BuildTarget.iOS);
            }
        }
        return;
    }
}
}
