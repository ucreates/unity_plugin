using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.IO;
using UnityPlugin;
using UnityPlugin.Core.IO;
public class ArchivePluginEventHandler : MonoBehaviour {
    private ArchivePlugin plugin {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.plugin = PluginFactory.GetPlugin<ArchivePlugin>();
        return;
    }
    public void OnDecompress() {
        string path = Path.Combine(Application.streamingAssetsPath, "archive.zip");
        byte[] data = null;
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.OSXEditor == Application.platform) {
            data = File.ReadAllBytes(path);
        } else if (RuntimePlatform.Android == Application.platform) {
            WWW client = new WWW(path);
            while (false == client.isDone) {}
            data = client.bytes;
        }
        if (null == data) {
            return;
        }
        path = Path.Combine(Application.temporaryCachePath, "archive.zip");
        if (false != File.Exists(path)) {
            File.Delete(path);
        }
        File.WriteAllBytes(path, data);
        this.plugin.Decompress(path);
        string txtPath = this.plugin.FindContentsPathByName("text.txt");
        string imagePath = this.plugin.FindContentsPathByName("image.png");
        byte[] imageData = File.ReadAllBytes(imagePath);
        Texture2D texture = new Texture2D(0, 0);
        bool ret = texture.LoadImage(imageData);
        if (false == ret) {
            return;
        }
        GameObject archiveTextObject = GameObject.Find("ArchiveText");
        GameObject archiveImageObject = GameObject.Find("ArchiveImage");
        Text archiveText = archiveTextObject.GetComponent<Text>();
        Image archiveImage = archiveImageObject.GetComponent<Image>();
        archiveText.text = File.ReadAllText(txtPath);
        archiveImage.sprite = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(0.5f, 0.5f));
        return;
    }
}
