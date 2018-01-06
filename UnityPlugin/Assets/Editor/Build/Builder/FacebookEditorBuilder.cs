using UnityEngine;
using UnityPlugin.Core.Configure.Sns;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using System.IO;
using System.Diagnostics;
using System.Collections;
namespace Editor.Build {
public class FacebookEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 3;
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromFrameworkRoot") || false == this.pathDictionary.ContainsKey("destFrameworkRoot")) {
            return;
        }
        PlistElementDict rootDict = plist.root;
        rootDict.SetString("FacebookAppID", FacebookConfigurePlugin.APP_ID);
        rootDict.SetString("FacebookDisplayName", PlayerSettings.productName);
        rootDict.SetString("NSPhotoLibraryUsageDescription", "Photo Access By Unity Facebook Plugin");
        return;
    }
    public override void BuildiOSURLSchemes(PlistElementArray bundleURLTypesArray) {
        PlistElementDict bundleURLSchemaDict = bundleURLTypesArray.AddDict();
        bundleURLSchemaDict.SetString("CFBundleTypeRole", "Editor");
        PlistElementArray bundleURLSchemaArray = bundleURLSchemaDict.CreateArray("CFBundleURLSchemes");
        bundleURLSchemaArray.AddString("fb" + FacebookConfigurePlugin.APP_ID);
        return;
    }
    public override void BuildiOSApplicationQueriesSchemes(PlistElementArray querySchemesArray) {
        querySchemesArray.AddString("fbapi");
        querySchemesArray.AddString("fb-messenger-api");
        querySchemesArray.AddString("fbauth2");
        querySchemesArray.AddString("fbshareextension");
        return;
    }
}
}
