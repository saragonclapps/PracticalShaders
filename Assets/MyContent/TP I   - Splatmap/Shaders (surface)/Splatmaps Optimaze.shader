// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Created/SplatmapOptimaze"
{
	Properties
	{
		_Mask("Mask", 2D) = "white" {}
		_Tshirt("T-shirt", 2D) = "white" {}
		_Short("Short", 2D) = "white" {}
		_Socks("Socks", 2D) = "white" {}
		_ColorA("Color A", Color) = (1,1,1,0)
		_ColorB("Color B", Color) = (0,0.2551723,1,0)
		_ColorC("Color C", Color) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Tshirt;
		uniform float4 _Tshirt_ST;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform float4 _ColorC;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform sampler2D _Short;
		uniform float4 _Short_ST;
		uniform sampler2D _Socks;
		uniform float4 _Socks_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Tshirt = i.uv_texcoord * _Tshirt_ST.xy + _Tshirt_ST.zw;
			float4 tex2DNode84 = tex2D( _Tshirt, uv_Tshirt );
			float4 ColorA109 = _ColorA;
			float4 ColorB110 = _ColorB;
			float4 ColorC111 = _ColorC;
			float4 SplatmapTShirt93 = ( ( tex2DNode84.r * ColorA109 ) + ( tex2DNode84.g * ColorB110 ) + ( tex2DNode84.b * ColorC111 ) );
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode2 = tex2D( _Mask, uv_Mask );
			float2 uv_Short = i.uv_texcoord * _Short_ST.xy + _Short_ST.zw;
			float4 tex2DNode116 = tex2D( _Short, uv_Short );
			float4 SplatmapShort94 = ( ( tex2DNode116.r * ColorA109 ) + ( tex2DNode116.g * ColorB110 ) + ( tex2DNode116.b * ColorC111 ) );
			float2 uv_Socks = i.uv_texcoord * _Socks_ST.xy + _Socks_ST.zw;
			float4 tex2DNode127 = tex2D( _Socks, uv_Socks );
			float4 SplatmapSocks95 = ( ( tex2DNode127.r * ColorA109 ) + ( tex2DNode127.g * ColorB110 ) + ( tex2DNode127.b * ColorC111 ) );
			o.Albedo = ( ( SplatmapTShirt93 * tex2DNode2.r ) + ( SplatmapShort94 * tex2DNode2.g ) + ( SplatmapSocks95 * tex2DNode2.b ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
38;29;1290;683;4136.164;647.4821;4.264591;True;True
Node;AmplifyShaderEditor.ColorNode;106;-1724.652,-470.6218;Float;False;Property;_ColorA;Color A;4;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;114;-2531.233,159.1767;Float;False;1405.529;530.0098;TShirt;9;93;159;150;152;149;148;151;84;147;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;126;-2572.295,1251.471;Float;False;1405.529;530.0098;Socks;1;127;;0.03448296,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-2569.953,694.8419;Float;False;1405.529;530.0098;Short;9;94;160;141;143;142;145;144;146;116;;0,1,0,1;0;0
Node;AmplifyShaderEditor.ColorNode;108;-1719.084,-141.2451;Float;False;Property;_ColorC;Color C;6;0;1,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;107;-1722.928,-305.6282;Float;False;Property;_ColorB;Color B;5;0;0,0.2551723,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;148;-1980.721,247.9909;Float;False;110;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;153;-1870.614,1283.012;Float;False;109;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1867.614,1418.012;Float;False;111;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;84;-2104.884,426.0845;Float;True;Property;_Tshirt;T-shirt;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;127;-1965.273,1549.65;Float;True;Property;_Socks;Socks;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;149;-1979.721,316.9909;Float;False;111;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;147;-1982.721,181.9909;Float;False;109;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-1437.744,-467.9901;Float;False;ColorA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1439.744,-142.9901;Float;False;ColorC;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1439.744,-304.9901;Float;False;ColorB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;154;-1868.614,1349.012;Float;False;110;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;116;-2377.737,975.954;Float;True;Property;_Short;Short;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;146;-2183.082,884.1185;Float;False;111;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;145;-2186.082,749.1185;Float;False;109;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;144;-2184.082,815.1185;Float;False;110;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-1577.614,1649.012;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;-1618.721,516.991;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-1620.721,430.9907;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;-1582.307,1481.02;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-1623.414,348.999;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-1897.775,947.1265;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-1893.082,1115.118;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;-1579.614,1563.012;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-1895.082,1029.118;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;161;-1414.975,1540.729;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;160;-1700.497,1005.46;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-1433.763,408.1982;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;98;-775.6212,810.8046;Float;False;95;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;94;-1623.303,761.7331;Float;False;SplatmapShort;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;2;-839.6525,79.35812;Float;True;Property;_Mask;Mask;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1371.085,1284;Float;False;SplatmapSocks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;-1334.319,198.2701;Float;False;SplatmapTShirt;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;97;-772.921,584.8048;Float;False;94;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;96;-772.4404,371.7171;Float;False;93;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-410.5388,593.3747;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-415.2345,814.1564;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-410.4872,376.9505;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-163.5013,569.0958;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;92.2849,567.8271;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Created/SplatmapOptimaze;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;112;-1774.652,-520.6219;Float;False;579.9089;586.3767;Colors;0;;0.9448276,0,1,1;0;0
WireConnection;109;0;106;0
WireConnection;111;0;108;0
WireConnection;110;0;107;0
WireConnection;156;0;127;3
WireConnection;156;1;155;0
WireConnection;150;0;84;3
WireConnection;150;1;149;0
WireConnection;151;0;84;2
WireConnection;151;1;148;0
WireConnection;158;0;127;1
WireConnection;158;1;153;0
WireConnection;152;0;84;1
WireConnection;152;1;147;0
WireConnection;141;0;116;1
WireConnection;141;1;145;0
WireConnection;143;0;116;3
WireConnection;143;1;146;0
WireConnection;157;0;127;2
WireConnection;157;1;154;0
WireConnection;142;0;116;2
WireConnection;142;1;144;0
WireConnection;161;0;158;0
WireConnection;161;1;157;0
WireConnection;161;2;156;0
WireConnection;160;0;141;0
WireConnection;160;1;142;0
WireConnection;160;2;143;0
WireConnection;159;0;152;0
WireConnection;159;1;151;0
WireConnection;159;2;150;0
WireConnection;94;0;160;0
WireConnection;95;0;161;0
WireConnection;93;0;159;0
WireConnection;78;0;97;0
WireConnection;78;1;2;2
WireConnection;79;0;98;0
WireConnection;79;1;2;3
WireConnection;77;0;96;0
WireConnection;77;1;2;1
WireConnection;12;0;77;0
WireConnection;12;1;78;0
WireConnection;12;2;79;0
WireConnection;0;0;12;0
ASEEND*/
//CHKSM=B0F901A2FD57BC7A61481AC5FAB05CAC96174105