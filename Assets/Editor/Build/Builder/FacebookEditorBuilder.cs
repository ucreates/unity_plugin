using UnityEngine;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using UnityPlugin.Core.Sns;
using System.Collections;
using System.Diagnostics;
using System.IO;
namespace Editor.Build {
public class FacebookEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 3;
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromFrameworkRoot") || false == this.pathDictionary.ContainsKey("destFrameworkRoot")) {
            return;
        }
        PlistElementDict rootDict = plist.root;
        PlistElementArray bundleURLTypesArray = rootDict.CreateArray("CFBundleURLTypes");
        PlistElementDict bundleURLSchemaDict = bundleURLTypesArray.AddDict();
        PlistElementArray bundleURLSchemaArray = bundleURLSchemaDict.CreateArray("CFBundleURLSchemes");
        bundleURLSchemaArray.AddString("fb" + FacebookSetting.APP_ID);
        rootDict.SetString("FacebookAppID", FacebookSetting.APP_ID);
        rootDict.SetString("FacebookDisplayName", PlayerSettings.productName);
        PlistElementArray lsApplicationQueriesSchemesArray = rootDict.CreateArray("LSApplicationQueriesSchemes");
        lsApplicationQueriesSchemesArray.AddString("fbapi");
        lsApplicationQueriesSchemesArray.AddString("fb-messenger-api");
        lsApplicationQueriesSchemesArray.AddString("fbauth2");
        lsApplicationQueriesSchemesArray.AddString("fbshareextension");
        rootDict.SetString("NSPhotoLibraryUsageDescription", "Photo Access By Unity Facebook Plugin");
        return;
    }
}
}
