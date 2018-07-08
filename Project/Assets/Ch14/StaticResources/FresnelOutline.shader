Shader "Custom/FresnelOutline" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_FresnelThreshold("FresnelOutline", Range(0, 1)) = 0.3
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Toon noambient

		sampler2D _MainTex;
		float _FresnelThreshold;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
		}

		float4 LightingToon(SurfaceOutput o, float3 lightDir, float3 viewDir, float atten) {
		    float rim = step(_FresnelThreshold, dot(o.Normal, viewDir));
		    return float4(o.Albedo * rim * _LightColor0, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
