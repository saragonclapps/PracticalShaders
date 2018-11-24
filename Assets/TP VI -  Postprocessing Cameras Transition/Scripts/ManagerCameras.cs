using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class ManagerCameras : MonoBehaviour {

    Camera _cam;
    public static ManagerCameras instance;// Singleton.
    
    private Material _postprocessEffect;
    private RenderTexture _targetTexture;
    private RenderTexture _oldTargetTexture;

    public Camera targetCamera;
    public Camera oldTargetCamera;

    [Range(0, 0.1f)]
    public float speedTransition = 0;

    public bool fadingIsActive { get; private set; }
    public float valueCameraTransition { get; private set; }// Value 0 to 1 in alpha of textures.

    private void Awake () {
		if (instance != null)
        {
            instance = this;
        }
        else
        {
            instance = null;
            instance = this;
        }
        _cam = GetComponent<Camera>();
        _postprocessEffect = Resources.Load("Created_Transition", typeof(Material)) as Material;
        UpdateCameras(0,1);
    }

    public void UpdateCameras(int indexCameraMin, int indexCameraMax)
    {
        _cam.enabled = true;

        if (oldTargetCamera == null || targetCamera == null)
            Debug.LogError("camera doesn´t exist or is not assigned.");

        //Create and set textures.
        _oldTargetTexture = new RenderTexture(Screen.width, Screen.height, -1);
        _targetTexture = new RenderTexture(Screen.width, Screen.height, -1);
        _oldTargetTexture.antiAliasing = _targetTexture.antiAliasing = 8;
        oldTargetCamera.targetTexture = _oldTargetTexture;
        targetCamera.targetTexture = _targetTexture;

        _postprocessEffect.SetTexture("_Tex1", _oldTargetTexture);
        _postprocessEffect.SetTexture("_Tex2", _targetTexture);

        fadingIsActive = true;
        StartCoroutine(FadingCamera());
    }

    private IEnumerator FadingCamera()
    {
        //Update current camera.
        valueCameraTransition = 0;
        while (valueCameraTransition < 1)
        {
            valueCameraTransition += speedTransition;

            if (fadingIsActive && _oldTargetTexture != null && _targetTexture != null)
                _postprocessEffect.SetFloat("_Alpha", valueCameraTransition);
            yield return new WaitForSeconds(0.03f);
        }

        //Clean class and set current camera.
        targetCamera.targetTexture = null;
        oldTargetCamera.targetTexture = null;
        oldTargetCamera.gameObject.SetActive(false);


        _oldTargetTexture = null;
        _targetTexture = null;

        fadingIsActive = false;
        valueCameraTransition = 0;
        _cam.enabled = false;
    }

    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        if (_postprocessEffect)
        {
            Graphics.Blit(src, dst, _postprocessEffect);
        }
    }
}
