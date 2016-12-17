using UnityEngine;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using UnityPlugin.Core.Sns;
using System.Collections;
using System.Diagnostics;
using System.IO;
namespace Editor.Build {
public class LineEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 4;
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromFrameworkRoot") || false == this.pathDictionary.ContainsKey("destFrameworkRoot")) {
            return;
        }
        PlistElementDict rootDict = plist.root;
        string[] frameworks = new string[] {"CoreText.framework", "CoreTelephony.framework", "Security.framework"};
        foreach (string framework in frameworks) {
            this.project.AddFrameworkToProject(this.targetGUID, framework, false);
        }
        PlistElementDict lineAdapterConfigDict = rootDict.CreateDict("LineAdapterConfig");
        lineAdapterConfigDict.SetString("ChannelId", LineSetting.CHANNEL_ID);
        PlistElementDict nsAppTransportSecurityDict = rootDict.CreateDict("NSAppTransportSecurity");
        PlistElementDict nsExeptionDomainsDict = nsAppTransportSecurityDict.CreateDict("NSExceptionDomains");
        PlistElementDict obsLineAppsComDict = nsExeptionDomainsDict.CreateDict("obs.line-apps.com");
        obsLineAppsComDict.SetBoolean("NSIncludesSubdomains", true);
        obsLineAppsComDict.SetBoolean("NSThirdPartyExceptionAllowsInsecureHTTPLoads", true);
        obsLineAppsComDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        PlistElementDict dlProfileLineCdnDict = nsExeptionDomainsDict.CreateDict("dl.profile.line-cdn.net");
        dlProfileLineCdnDict.SetBoolean("NSIncludesSubdomains", true);
        dlProfileLineCdnDict.SetBoolean("NSThirdPartyExceptionAllowsInsecureHTTPLoads", true);
        dlProfileLineCdnDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        PlistElementDict dlProfileLineNaverDict = nsExeptionDomainsDict.CreateDict("dl.profile.line.naver.jp");
        dlProfileLineNaverDict.SetBoolean("NSIncludesSubdomains", true);
        dlProfileLineNaverDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        PlistElementDict icsNaverDict = nsExeptionDomainsDict.CreateDict("lcs.naver.jp");
        icsNaverDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        PlistElementDict scdnLineAppsDict = nsExeptionDomainsDict.CreateDict("scdn.line-apps.com");
        scdnLineAppsDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        PlistElementDict accessLineMeDict = nsExeptionDomainsDict.CreateDict("access.line.me");
        accessLineMeDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        PlistElementDict appLineMeDict = nsExeptionDomainsDict.CreateDict("app.line.me");
        appLineMeDict.SetBoolean("NSThirdPartyExceptionRequiresForwardSecrecy", false);
        return;
    }
    public override void BuildiOSURLSchemes(PlistElementArray bundleURLTypesArray) {
        PlistElementDict bundleURLSchemaDict = bundleURLTypesArray.AddDict();
        bundleURLSchemaDict.SetString("CFBundleTypeRole", "Editor");
        bundleURLSchemaDict.SetString("CFBundleURLName", PlayerSettings.bundleIdentifier);
        PlistElementArray bundleURLSchemaArray = bundleURLSchemaDict.CreateArray("CFBundleURLSchemes");
        bundleURLSchemaArray.AddString("line3rdp." + PlayerSettings.bundleIdentifier);
        return;
    }
    public override void BuildiOSApplicationQueriesSchemes(PlistElementArray querySchemesArray) {
        querySchemesArray.AddString("lineauth");
        querySchemesArray.AddString("line3rdp." + PlayerSettings.bundleIdentifier);
        return;
    }
}
}
