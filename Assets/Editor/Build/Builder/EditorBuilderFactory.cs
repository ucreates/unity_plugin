﻿using UnityEngine;
using System.Collections;
namespace Editor.Build {
public class EditorBuilderFactory {
    public static BaseEditorBuilder FactoryMethod(int builderId) {
        BaseEditorBuilder builder = null;
        switch (builderId) {
        case IDEEditorBuilder.BUILDER_ID:
            builder = new IDEEditorBuilder();
            break;
        case TwitterEditorBuilder.BUILDER_ID:
            builder = new TwitterEditorBuilder();
            break;
        case FacebookEditorBuilder.BUILDER_ID:
            builder = new FacebookEditorBuilder();
            break;
        case LineEditorBuilder.BUILDER_ID:
            builder = new LineEditorBuilder();
            break;
        default:
            break;
        }
        return builder;
    }
}
}