Shader "Custom/DiffuseWarping" {
	Properties {
		_RampTex ("RampTex (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Warp noambient

		sampler2D _RampTex;

		struct Input {
			float2 uv_RampTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		}

		float4 LightingWarp(SurfaceOutput o, float3 lightDir, float viewDir, float atten) {
		    float diffuse = dot(o.Normal, lightDir) * 0.5 + 0.5;
		    return tex2D(_RampTex, float2(diffuse, 0));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
