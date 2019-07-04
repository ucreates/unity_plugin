//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityEngine;
using System.Runtime.InteropServices;
using System.IO;
using System.Collections.Generic;
namespace UnityPlugin.Core.IO {
public sealed class ArchivePlugin : BasePlugin {
    public List<string> contentsPathList {
        get;
        set;
    }
    public ArchivePlugin() {
        this.contentsPathList = new List<string>();
    }
    public List<string> Decompress(string archivePath) {
        UnityManagedPlugin.Core.IO.ArchivePlugin plugin = new UnityManagedPlugin.Core.IO.ArchivePlugin();
        this.contentsPathList = plugin.Decompress(archivePath);
        return this.contentsPathList;
    }
    public string FindContentsPathByName(string contentsName) {
        string ret = string.Empty;
        foreach (string path in this.contentsPathList) {
            string fileName = Path.GetFileName(path);
            if (false != contentsName.Equals(fileName)) {
                ret = path;
                break;
            }
        }
        return ret;
    }
}
}
