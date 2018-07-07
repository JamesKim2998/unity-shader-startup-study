Shader "Custom/Lambert" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpecColor ("Specular Color", color) = (1, 1, 1, 1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf BlinnPhong

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
			o.Specular = 0.5;
			o.Gloss = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
