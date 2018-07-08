Shader "Custom/Outline" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_OutlineThickness ("Outline Thickness", Range(0.1, 3)) = 0.3
		_OutlineColor ("Outline Color", color) = (0, 0, 0, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

        // 1st Pass.
		cull front

		CGPROGRAM
		#pragma surface surf NoLight noambient noshadow vertex:vert

		sampler2D _MainTex;
		float _OutlineThickness;
		fixed4 _OutlineColor;

		struct Input {
			float2 uv_MainTex;
		};

		void vert(inout appdata_full v) {
		    v.vertex += float4(v.normal, 0) * _OutlineThickness / 100;
		}

		void surf (Input IN, inout SurfaceOutput o) {
		}

		float4 LightingNoLight (SurfaceOutput o, float3 ligthDir, float atten) {
			return _OutlineColor;
		}
		ENDCG

        // 2nd Pass.
		cull back

		CGPROGRAM
		#pragma surface surf Lambert noambient

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
