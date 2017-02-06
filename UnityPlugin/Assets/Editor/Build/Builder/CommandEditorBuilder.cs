using UnityEngine;
using System.Collections.Generic;
namespace Editor.Build {
public class CommandEditorBuilder : BaseEditorBuilder {
    public List<string> commandElementList {
        get;
        private set;
    }
    public CommandEditorBuilder() {
        this.commandElementList = new List<string>();
    }
    public string Build() {
        string command = string.Empty;
        foreach (string commandElement in commandElementList) {
            command += commandElement + " ";
        }
        return command.Trim();
    }
}
}
