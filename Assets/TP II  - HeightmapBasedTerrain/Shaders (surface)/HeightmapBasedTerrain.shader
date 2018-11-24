// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Created/HeightmapBasedTerrain"
{
	Properties
	{
		_UpTexture("UpTexture", 2D) = "white" {}
		_DownTexture("DownTexture", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_AO("AO", 2D) = "white" {}
		_Metallic("Metallic", 2D) = "white" {}
		_MetallicValue("MetallicValue", Range( 0 , 1)) = 0
		_SmoothnessValue("SmoothnessValue", Range( 0 , 1)) = 0
		_Heightmap("Heightmap", 2D) = "white" {}
		_Displacement("Displacement", Range( 0 , 1)) = 0
		_Tessellation("Tessellation", Range( 0 , 32)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _DownTexture;
		uniform float4 _DownTexture_ST;
		uniform sampler2D _UpTexture;
		uniform float4 _UpTexture_ST;
		uniform sampler2D _Heightmap;
		uniform float4 _Heightmap_ST;
		uniform float _Displacement;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _MetallicValue;
		uniform float _SmoothnessValue;
		uniform sampler2D _AO;
		uniform float4 _AO_ST;
		uniform float _Tessellation;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			float4 temp_cast_2 = (_Tessellation).xxxx;
			return temp_cast_2;
		}

		void vertexDataFunc( inout appdata v )
		{
			float2 uv_Heightmap = v.texcoord * _Heightmap_ST.xy + _Heightmap_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			half4 HeightmapValue7 = ( ( tex2Dlod( _Heightmap, float4( uv_Heightmap, 0, 0.0) ) * _Displacement ) * float4( ase_vertexNormal , 0.0 ) );
			v.vertex.xyz += HeightmapValue7.rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = tex2D( _Normal, uv_Normal ).rgb;
			float2 uv_DownTexture = i.uv_texcoord * _DownTexture_ST.xy + _DownTexture_ST.zw;
			float2 uv_UpTexture = i.uv_texcoord * _UpTexture_ST.xy + _UpTexture_ST.zw;
			float2 uv_Heightmap = i.uv_texcoord * _Heightmap_ST.xy + _Heightmap_ST.zw;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			half4 HeightmapValue7 = ( ( tex2D( _Heightmap, uv_Heightmap ) * _Displacement ) * float4( ase_vertexNormal , 0.0 ) );
			float4 lerpResult10 = lerp( tex2D( _DownTexture, uv_DownTexture ) , tex2D( _UpTexture, uv_UpTexture ) , HeightmapValue7.r);
			float4 Albedo17 = lerpResult10;
			o.Albedo = Albedo17.rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			o.Metallic = ( tex2D( _Metallic, uv_Metallic ) * _MetallicValue ).r;
			o.Smoothness = _SmoothnessValue;
			float2 uv_AO = i.uv_texcoord * _AO_ST.xy + _AO_ST.zw;
			o.Occlusion = tex2D( _AO, uv_AO ).r;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord.xy = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
38;29;1290;683;2809.093;505.2811;2.663928;True;True
Node;AmplifyShaderEditor.CommentaryNode;14;-1854.787,586.2588;Float;False;982.4651;484.3523;Heightmap;6;3;1;12;5;13;7;;1,0,0.972414,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1785.818,825.2591;Float;False;Property;_Displacement;Displacement;8;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-1804.787,636.2589;Float;True;Property;_Heightmap;Heightmap;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1472.819,769.2592;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.NormalVertexDataNode;12;-1515.225,891.611;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1296.386,770.9174;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;24;-1859.256,-93.65141;Float;False;855.4546;588.7656;Albedo;5;2;11;6;10;17;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;6;-1809.256,-43.65141;Float;True;Property;_DownTexture;DownTexture;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;11;-1742.027,380.1142;Float;False;7;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;2;-1808.999,148.0147;Float;True;Property;_UpTexture;UpTexture;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;7;-1132.323,766.0225;Half;False;HeightmapValue;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;22;-506.8561,-5.55668;Float;False;Property;_MetallicValue;MetallicValue;5;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;10;-1396.224,280.7893;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;19;-518.3474,-196.1114;Float;True;Property;_Metallic;Metallic;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;18;-406.2908,-470.6097;Float;False;17;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1246.801,189.6254;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;9;-284.5799,259.6482;Float;False;7;0;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;4;-555.8735,306.7619;Float;False;Property;_Tessellation;Tessellation;9;0;0;0;32;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;23;-825.0278,124.2508;Float;True;Property;_AO;AO;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-214.8554,-122.5564;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;20;-455.5597,99.13099;Float;False;Property;_SmoothnessValue;SmoothnessValue;6;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;15;-512.2562,-395.1007;Float;True;Property;_Normal;Normal;2;0;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;132.8386,14.73877;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Created/HeightmapBasedTerrain;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;1;0
WireConnection;5;1;3;0
WireConnection;13;0;5;0
WireConnection;13;1;12;0
WireConnection;7;0;13;0
WireConnection;10;0;6;0
WireConnection;10;1;2;0
WireConnection;10;2;11;0
WireConnection;17;0;10;0
WireConnection;21;0;19;0
WireConnection;21;1;22;0
WireConnection;0;0;18;0
WireConnection;0;1;15;0
WireConnection;0;3;21;0
WireConnection;0;4;20;0
WireConnection;0;5;23;0
WireConnection;0;11;9;0
WireConnection;0;14;4;0
ASEEND*/
//CHKSM=DBA4C461F4C7FEB845E9F885D4A2B32D555E6A6B