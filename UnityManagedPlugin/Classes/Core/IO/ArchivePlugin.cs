// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityEngine;
using System;
using System.IO;
using System.Collections.Generic;
using Ionic.Zip;
namespace UnityManagedPlugin.Core.IO {
public class ArchivePlugin {
    private List<string> ignoreList {
        get;
        set;
    }
    public ArchivePlugin() {
        this.ignoreList = new List<string>();
        this.ignoreList.Add("__MACOSX");
        this.ignoreList.Add(".DS_Store");
    }
    public List<string> Decompress(string archivePath) {
        List<string> ret = new List<string>();
        string rootDir = Path.GetDirectoryName(archivePath);
        using (ZipFile zip = new ZipFile(archivePath)) {
            foreach (ZipEntry entry in zip) {
                entry.Extract(rootDir, ExtractExistingFileAction.OverwriteSilently);
                bool breakable = false;
                string contentsPath = Path.Combine(rootDir, entry.FileName);
                foreach (string ignore in this.ignoreList) {
                    if (false != contentsPath.Contains(ignore)) {
                        breakable = true;
                        break;
                    }
                }
                if (false != breakable || false == File.Exists(contentsPath)) {
                    continue;
                }
                ret.Add(contentsPath);
            }
        }
        return ret;
    }
}
}
