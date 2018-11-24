// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Created/Splatmap"
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
			float4 SplatmapTShirt93 = ( ( ( tex2DNode84.r / 1.0 ) * ColorA109 ) + ( ( tex2DNode84.g / 1.0 ) * ColorB110 ) + ( ( tex2DNode84.b / 1.0 ) * ColorC111 ) );
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode2 = tex2D( _Mask, uv_Mask );
			float2 uv_Short = i.uv_texcoord * _Short_ST.xy + _Short_ST.zw;
			float4 tex2DNode116 = tex2D( _Short, uv_Short );
			float4 SplatmapShort94 = ( ( ( tex2DNode116.r / 1.0 ) * ColorA109 ) + ( ( tex2DNode116.g / 1.0 ) * ColorB110 ) + ( ( tex2DNode116.b / 1.0 ) * ColorC111 ) );
			float2 uv_Socks = i.uv_texcoord * _Socks_ST.xy + _Socks_ST.zw;
			float4 tex2DNode127 = tex2D( _Socks, uv_Socks );
			float4 SplatmapSocks95 = ( ( ( tex2DNode127.r / 1.0 ) * ColorA109 ) + ( ( tex2DNode127.g / 1.0 ) * ColorB110 ) + ( ( tex2DNode127.b / 1.0 ) * ColorC111 ) );
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
38;29;1290;683;3438.52;384.6024;3.776118;True;True
Node;AmplifyShaderEditor.RangedFloatNode;130;-2505.316,1499.704;Float;False;Constant;_RedSocks;Red-Socks;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;101;-2504.959,558.1864;Float;False;Constant;_BlueTShirt;Blue-TShirt;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;106;-1724.652,-470.6218;Float;False;Property;_ColorA;Color A;4;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;116;-2519.953,744.8419;Float;True;Property;_Short;Short;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;108;-1719.084,-141.2451;Float;False;Property;_ColorC;Color C;6;0;1,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;107;-1722.928,-305.6282;Float;False;Property;_ColorB;Color B;5;0;0,0.2551723,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;84;-2522.233,193.1767;Float;True;Property;_Tshirt;T-shirt;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;100;-2505.305,470.5659;Float;False;Constant;_GreenTShirt;Green-TShirt;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;119;-2502.679,1109.852;Float;False;Constant;_BlueShort;Blue-Short;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;117;-2502.974,943.0745;Float;False;Constant;_RedShort;Red-Short;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;129;-2505.367,1578.86;Float;False;Constant;_GreenSocks;Green-Socks;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;99;-2505.254,391.4094;Float;False;Constant;_RedTShirt;Red-TShirt;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;128;-2505.021,1666.481;Float;False;Constant;_BlueSocks;Blue-Socks;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;127;-2522.295,1301.471;Float;True;Property;_Socks;Socks;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;118;-2503.025,1022.231;Float;False;Constant;_GreenShort;Green-Short;4;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;103;-1994.302,455.8308;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;133;-1997.118,1479.82;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;121;-1988.106,1091.664;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;147;-1890.721,177.9909;Float;False;109;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;153;-1870.614,1283.012;Float;False;109;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;146;-1931.298,861.0064;Float;False;111;0;1;COLOR
Node;AmplifyShaderEditor.SimpleDivideOpNode;131;-1994.36,1564.125;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;120;-1992.021,1007.496;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;104;-1990.387,539.9985;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;149;-1887.721,312.9909;Float;False;111;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-1439.744,-142.9901;Float;False;ColorC;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1439.744,-304.9901;Float;False;ColorB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleDivideOpNode;102;-1997.06,371.5255;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;148;-1888.721,243.9909;Float;False;110;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;144;-1932.298,792.0064;Float;False;110;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;154;-1868.614,1349.012;Float;False;110;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1867.614,1418.012;Float;False;111;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-1437.744,-467.9901;Float;False;ColorA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleDivideOpNode;122;-1994.779,923.1908;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;145;-1934.298,726.0064;Float;False;109;0;1;COLOR
Node;AmplifyShaderEditor.SimpleDivideOpNode;132;-1990.445,1648.293;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;-1597.721,543.991;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-1599.721,457.9907;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;-1582.307,1481.02;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-1643.298,1006.006;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-1641.298,1092.006;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-1645.991,924.0144;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-1577.614,1649.012;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-1602.414,375.999;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;-1579.614,1563.012;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-1412.763,435.1982;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;161;-1414.975,1540.729;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;160;-1448.713,982.3483;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;97;-772.921,584.8048;Float;False;94;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;-1375.319,182.2701;Float;False;SplatmapTShirt;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;96;-772.4404,371.7171;Float;False;93;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;2;-839.6525,79.35812;Float;True;Property;_Mask;Mask;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;98;-775.6212,810.8046;Float;False;95;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1371.085,1284;Float;False;SplatmapSocks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;94;-1371.519,738.621;Float;False;SplatmapShort;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-415.2345,814.1564;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-410.4872,376.9505;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-410.5388,593.3747;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-163.5013,569.0958;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;92.2849,567.8271;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Created/Splatmap;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;126;-2572.295,1251.471;Float;False;1405.529;530.0098;Socks;0;;0.03448296,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-2569.953,694.8419;Float;False;1405.529;530.0098;Short;0;;0,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;112;-1774.652,-520.6219;Float;False;579.9089;586.3767;Colors;0;;0.9448276,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;114;-2572.233,143.1767;Float;False;1405.529;530.0098;TShirt;0;;1,0,0,1;0;0
WireConnection;103;0;84;2
WireConnection;103;1;100;0
WireConnection;133;0;127;1
WireConnection;133;1;130;0
WireConnection;121;0;116;3
WireConnection;121;1;119;0
WireConnection;131;0;127;2
WireConnection;131;1;129;0
WireConnection;120;0;116;2
WireConnection;120;1;118;0
WireConnection;104;0;84;3
WireConnection;104;1;101;0
WireConnection;111;0;108;0
WireConnection;110;0;107;0
WireConnection;102;0;84;1
WireConnection;102;1;99;0
WireConnection;109;0;106;0
WireConnection;122;0;116;1
WireConnection;122;1;117;0
WireConnection;132;0;127;3
WireConnection;132;1;128;0
WireConnection;150;0;104;0
WireConnection;150;1;149;0
WireConnection;151;0;103;0
WireConnection;151;1;148;0
WireConnection;158;0;133;0
WireConnection;158;1;153;0
WireConnection;142;0;120;0
WireConnection;142;1;144;0
WireConnection;143;0;121;0
WireConnection;143;1;146;0
WireConnection;141;0;122;0
WireConnection;141;1;145;0
WireConnection;156;0;132;0
WireConnection;156;1;155;0
WireConnection;152;0;102;0
WireConnection;152;1;147;0
WireConnection;157;0;131;0
WireConnection;157;1;154;0
WireConnection;159;0;152;0
WireConnection;159;1;151;0
WireConnection;159;2;150;0
WireConnection;161;0;158;0
WireConnection;161;1;157;0
WireConnection;161;2;156;0
WireConnection;160;0;141;0
WireConnection;160;1;142;0
WireConnection;160;2;143;0
WireConnection;93;0;159;0
WireConnection;95;0;161;0
WireConnection;94;0;160;0
WireConnection;79;0;98;0
WireConnection;79;1;2;3
WireConnection;77;0;96;0
WireConnection;77;1;2;1
WireConnection;78;0;97;0
WireConnection;78;1;2;2
WireConnection;12;0;77;0
WireConnection;12;1;78;0
WireConnection;12;2;79;0
WireConnection;0;0;12;0
ASEEND*/
//CHKSM=3E2BB862D88C8EB6C22161E67F232562C4974FDD