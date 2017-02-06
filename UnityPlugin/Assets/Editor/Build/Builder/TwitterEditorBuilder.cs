﻿using UnityEngine;
using UnityEditor.iOS.Xcode;
using UnityPlugin.Core.Configure.Sns;
using System.Collections;
using System.Diagnostics;
using System.IO;
namespace Editor.Build {
public class TwitterEditorBuilder : BaseEditorBuilder {
    public const int BUILDER_ID = 2;
    protected override string runScriptName {
        get {
            return "fabric_run_script.rb";
        }
    }
    protected override void BuildiOS() {
        if (false == this.pathDictionary.ContainsKey("fromFrameworkRoot") || false == this.pathDictionary.ContainsKey("destFrameworkRoot")) {
            return;
        }
        string fromFrameworkRootPath = this.pathDictionary["fromFrameworkRoot"];
        string destFrameworkRootPath = this.pathDictionary["destFrameworkRoot"];
        string[] innerBundlePathList = new string[] {
            "Twitter/TwitterKit.framework/TwitterKitResources.bundle"
        };
        foreach (string innerBundlePath in innerBundlePathList) {
            string fromPath = Path.Combine(fromFrameworkRootPath, innerBundlePath);
            string destPath = Path.Combine(destFrameworkRootPath, innerBundlePath);
            string bundleGUID = project.AddFile(fromPath, destPath, PBXSourceTree.Source);
            project.AddFileToBuild(this.targetGUID, bundleGUID);
        }
        PlistElementDict rootDict = plist.root;
        PlistElementDict fabricDict =  rootDict.CreateDict("Fabric");
        fabricDict.SetString("APIKey", TwitterConfigurePlugin.API_KEY);
        PlistElementArray kitsArray = fabricDict.CreateArray("Kits");
        PlistElementDict kitsDict = kitsArray.AddDict();
        PlistElementDict keyInfoDict = kitsDict.CreateDict("KitInfo");
        keyInfoDict.SetString("consumerKey", TwitterConfigurePlugin.CONSUMER_KEY);
        keyInfoDict.SetString("consumerSecret", TwitterConfigurePlugin.CONSUMER_SEACRET);
        kitsDict.SetString("KitName", "Twitter");
        return;
    }
    protected override void RuniOS() {
        string buildPath = this.pathDictionary["build"];
        string projectPath = Path.Combine(buildPath, "Unity-iPhone.xcodeproj");
        string fromCliRootPath = this.pathDictionary["fromCliRoot"];
        string destCliRootPath = this.pathDictionary["destCliRoot"];
        string fromCliPath = Path.Combine(fromCliRootPath, this.runScriptName);
        string destCliPath = Path.Combine(destCliRootPath, this.runScriptName);
        if (false != File.Exists(destCliPath)) {
            File.Delete(destCliPath);
        }
        File.Copy(fromCliPath, destCliPath);
        CommandEditorBuilder builder = new CommandEditorBuilder();
        builder.commandElementList.Add(destCliPath);
        builder.commandElementList.Add(projectPath);
        builder.commandElementList.Add("./Frameworks/Plugins/iOS/Frameworks/Twitter/Fabric.framework/run");
        builder.commandElementList.Add(TwitterConfigurePlugin.API_KEY);
        builder.commandElementList.Add(TwitterConfigurePlugin.BUILD_SEACRET);
        ProcessStartInfo info = new ProcessStartInfo();
        info.UseShellExecute = false;
        info.FileName = "/usr/bin/ruby";
        info.Arguments = builder.Build();
        info.WorkingDirectory = buildPath;
        info.CreateNoWindow = false;
        info.RedirectStandardOutput = true;
        info.RedirectStandardError = true;
        Process process = new Process();
        process.StartInfo = info;
        bool ret = process.Start();
        if (false == ret) {
            UnityEngine.Debug.LogError("faild process start.");
            return;
        }
        string stdout = process.StandardOutput.ReadToEnd();
        string stderror = process.StandardError.ReadToEnd();
        UnityEngine.Debug.Log(stdout);
        UnityEngine.Debug.Log(stderror);
        process.WaitForExit();
        process.Close();
        return;
    }
}
}
