Shader "Created/Transition"
{
	Properties
	{
		_Tex1 ("Texture1", 2D) = "white" {}
		_Tex2 ("Texture2", 2D) = "white" {}
		_Alpha("Alpha", Range( 0 , 1)) = 1
	}

	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _Tex1;
			sampler2D _Tex2;
			float4 _Tex1_ST;
			float4 _Tex2_ST;

			float _Alpha;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed2 tex1UV = i.uv * _Tex1_ST.xy + _Tex1_ST.zw;
				fixed2 tex2UV = i.uv * _Tex2_ST.xy + _Tex2_ST.zw;
				fixed4 lerpResult = lerp( tex2D(_Tex1,tex1UV), tex2D(_Tex2,tex2UV), _Alpha);

				return lerpResult;
			}
			ENDCG
		}
	}
}
