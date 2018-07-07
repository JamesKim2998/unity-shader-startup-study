Shader "Custom/NormalMap" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Metallic("Metallic", Range(0, 1)) = 0
		_Smoothness("Smoothness", Range(0, 1)) = 0.5
		_BumpMap("NormalMap", 2D) = "bump" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float _Metallic;
		float _Smoothness;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D (_BumpMap, IN.uv_BumpMap));
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
