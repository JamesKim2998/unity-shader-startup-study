Shader "Custom/HalfLambert" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("NormapMap", 2D) = "bump" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Test
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = tex2D (_BumpMap, IN.uv_BumpMap);
		}

		float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten) {
		    float ndotl = pow(dot(s.Normal, lightDir) * 0.5 + 0.5, 2);
		    float3 final = ndotl * s.Albedo * _LightColor0 * pow(atten, 2);
		    return float4(final, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
