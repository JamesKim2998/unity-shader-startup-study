Shader "Custom/DiffuseWarpingAdvanced" {
	Properties {
		_MainTex ("MainTex (RGB)", 2D) = "white" {}
		_RampTex ("RampTex (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Warp noambient

		sampler2D _MainTex;
		sampler2D _RampTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_RampTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		    o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
		}

		float4 LightingWarp(SurfaceOutput o, float3 lightDir, float viewDir, float atten) {
		    float ndotl = dot(o.Normal, lightDir) * 0.5 + 0.5;
		    float ndotv = dot(o.Normal, viewDir) * 0.5 + 0.5;
		    return float4(o.Albedo, 1) * tex2D(_RampTex, float2(ndotl, ndotv));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
