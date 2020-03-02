using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostProcessGradient : MonoBehaviour
{
    public paletteColor paletteSelect = paletteColor.TwohundredFiftySix;
    public Color color = new Color(1, 1, 1, 1);
    Dictionary<paletteColor, Texture2D> _palettesDiccionary = new Dictionary<paletteColor, Texture2D>();
    private Texture2D _currentPalette;

    private Material _postprocessEffect;

    private void Awake()
    {
        var palette4 = Resources.Load("Palette 4 colors", typeof(Texture2D)) as Texture2D;
        var palette8 = Resources.Load("Palette 8 colors", typeof(Texture2D)) as Texture2D;
        var palette16 = Resources.Load("Palette 16 colors", typeof(Texture2D)) as Texture2D;
        var palette256 = Resources.Load("Palette 256 colors", typeof(Texture2D)) as Texture2D;

        _palettesDiccionary.Add(paletteColor.Four, palette4);
        _palettesDiccionary.Add(paletteColor.Eight, palette8);
        _palettesDiccionary.Add(paletteColor.Sixteen, palette16);
        _palettesDiccionary.Add(paletteColor.TwohundredFiftySix, palette256);

        _currentPalette = _palettesDiccionary[paletteSelect];

        _postprocessEffect = Resources.Load("Palette", typeof(Material)) as Material;
        _postprocessEffect.SetColor("_Color", color);
        _postprocessEffect.SetTexture("_Palette", _currentPalette);
    }

    private void Update()
    {
        _currentPalette = _palettesDiccionary[paletteSelect];
        _postprocessEffect.SetColor("_Color", color);
        _postprocessEffect.SetTexture("_Palette", _currentPalette);
    }


    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        if (_postprocessEffect)
        {
            Graphics.Blit(src, dst, _postprocessEffect);
        }
    }
}

public enum paletteColor
{
    Four,
    Eight,
    Sixteen,
    TwohundredFiftySix
};
