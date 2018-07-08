Shader "Custom/OutlinePattern" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_OutlineThickness ("Outline Thickness", Range(0.1, 3)) = 0.3
		_OutlineColor1 ("Outline Color1", Color) = (1,1,1,1)
		_OutlineColor2 ("Outline Color2", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

        // 1st Pass.
		cull front

		CGPROGRAM
		#pragma surface surf NoLight noambient noshadow vertex:vert

		sampler2D _MainTex;
		float _OutlineThickness;
		fixed3 _OutlineColor1;
		fixed3 _OutlineColor2;

		struct Input {
			float2 uv_MainTex;
		};

		void vert(inout appdata_full v) {
		    v.vertex += float4(v.normal, 0) * _OutlineThickness / 100;
		}

		void surf (Input IN, inout SurfaceOutput o) {
		}

		float4 LightingNoLight (SurfaceOutput o, float3 ligthDir, float3 viewDir, float atten) {
			fixed lerpFactor = step(sin((viewDir.x + viewDir.y) * 100 +  _Time.y * 20), 0);
			fixed3 color = lerp(_OutlineColor1, _OutlineColor2, lerpFactor);
		    return float4(color, 1);
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
			o.Albedo = float4(1, 1, 1, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
