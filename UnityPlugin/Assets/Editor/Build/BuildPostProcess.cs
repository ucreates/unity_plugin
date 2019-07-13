using UnityEngine;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using UnityEditor.Callbacks;
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
            WebViewEditorBuilder.BUILDER_ID,
            GoogleEditorBuilder.BUILDER_ID,
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
            string destFrameworkRootAbsolutePath = Path.Combine(buildPath, destFrameworkRootPath);
            string fromiOSPluginRootPath = Path.Combine(System.Environment.CurrentDirectory, @"Assets/Plugins/iOS");
            string destiOSProjectRootPath = buildPath;
            string fromPodFilePath = Path.Combine(fromCliRootPath, "Podfile");
            string destPodFilePath = Path.Combine(buildPath, "Podfile");
            Dictionary<string, string> pathDictionary = new Dictionary<string, string>();
            pathDictionary.Add("build", buildPath);
            pathDictionary.Add("fromCliRoot", fromCliRootPath);
            pathDictionary.Add("destCliRoot", destCliRootPath);
            pathDictionary.Add("fromFrameworkRoot", fromFrameworkRootPath);
            pathDictionary.Add("destFrameworkRoot", destFrameworkRootPath);
            pathDictionary.Add("destFrameworkRootAbsolute", destFrameworkRootAbsolutePath);
            pathDictionary.Add("fromiOSPluginRoot", fromiOSPluginRootPath);
            pathDictionary.Add("destiOSProjectRoot", destiOSProjectRootPath);
            project.ReadFromFile(projectPath);
            plist.ReadFromFile(plistPath);
            string targetName = PBXProject.GetUnityTargetName();
            string targetGUID = project.TargetGuidByName(targetName);
            string[] frameworkList = new string[] {"StoreKit.framework", "UserNotifications.framework", "SafariServices.framework", "SystemConfiguration.framework", "AddressBook.framework", "WebKit.framework"};
            foreach (string framework in frameworkList) {
                project.AddFrameworkToProject(targetGUID, framework, false);
            }
            project.AddBuildProperty(targetGUID, "OTHER_LDFLAGS", "-lz");
            project.AddBuildProperty(targetGUID, "OTHER_LDFLAGS", "-ObjC");
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
            PlistElementDict nsAppTransportSecurityDict = rootDict.CreateDict("NSAppTransportSecurity");
            nsAppTransportSecurityDict.SetBoolean("NSAllowsArbitraryLoads", true);
            PlistElementDict nsExeptionDomainsDict = nsAppTransportSecurityDict.CreateDict("NSExceptionDomains");
            foreach (int builderId in builderIdList) {
                BaseEditorBuilder builder = EditorBuilderFactory.FactoryMethod(builderId);
                builder.BuildiOSNSAppTransportSecuritySchemes(nsExeptionDomainsDict);
            }
            plist.WriteToFile(plistPath);
            project.WriteToFile(projectPath);
            foreach (int builderId in builderIdList) {
                BaseEditorBuilder builder = EditorBuilderFactory.FactoryMethod(builderId);
                builder.targetGUID = targetGUID;
                builder.pathDictionary = pathDictionary;
                builder.Run(BuildTarget.iOS);
            }
            if (false != File.Exists(destPodFilePath)) {
                File.Delete(destPodFilePath);
            }
            File.Copy(fromPodFilePath, destPodFilePath);
        }
        return;
    }
}
}
