using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostProcess : MonoBehaviour {

    public Material _postprocessEffect;

    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        if (_postprocessEffect)
        {
            Graphics.Blit(src, dst, _postprocessEffect);
        }
    }
}
