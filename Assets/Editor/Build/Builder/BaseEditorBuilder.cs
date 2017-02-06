using UnityEngine;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using System.Collections;
using System.Collections.Generic;
namespace Editor.Build {
public abstract class BaseEditorBuilder {
    public PBXProject project {
        get;
        set;
    }
    public PlistDocument plist {
        get;
        set;
    }
    public string targetGUID {
        protected get;
        set;
    }
    public Dictionary<string, string> pathDictionary {
        protected get;
        set;
    }
    protected virtual string runScriptName {
        get {
            return string.Empty;
        }
    }
    public BaseEditorBuilder() {
        this.project = null;
        this.plist = null;
        this.targetGUID = string.Empty;
        this.pathDictionary = new Dictionary<string, string>();
    }
    public void Build(BuildTarget target) {
        if (target == BuildTarget.iOS) {
            this.BuildiOS();
        } else if (target == BuildTarget.Android) {
            this.BuildAndroid();
        }
        return;
    }
    protected virtual void BuildiOS() {
        return;
    }
    protected virtual void BuildAndroid() {
        return;
    }
    public void Run(BuildTarget target) {
        if (target == BuildTarget.iOS) {
            this.RuniOS();
        } else if (target == BuildTarget.Android) {
            this.RunAndroid();
        }
        return;
    }
    protected virtual void RuniOS() {
        return;
    }
    protected virtual void RunAndroid() {
        return;
    }
    public virtual void BuildiOSURLSchemes(PlistElementArray bundleURLSchemaDict) {
        return;
    }
    public virtual void BuildiOSApplicationQueriesSchemes(PlistElementArray querySchemesArray) {
        return;
    }
    public virtual void BuildiOSNSAppTransportSecuritySchemes(PlistElementDict nsExeptionDomainsDict) {
        return;
    }
}
}
