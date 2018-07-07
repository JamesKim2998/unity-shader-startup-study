Shader "Custom/FakeSpecular" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("NormapMap", 2D) = "bump" {}
		_GlossMap ("Gloss Texture", 2D) = "white" {}
		_SpecCol ("Specular Color", color) = (1, 1, 1, 1)
		_SpecPower ("Specular Power", Range(10, 200)) = 100
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Test noambient

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _GlossMap;
		float3 _SpecCol;
		float _SpecPower;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_GlossMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D (_BumpMap, IN.uv_BumpMap));
			o.Gloss = tex2D (_GlossMap, IN.uv_GlossMap).a;
		}

		float4 LightingTest(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten) {
		    // Lambert term.
		    float ndotl = saturate(dot(s.Normal, lightDir));
		    float3 diffColor = ndotl * s.Albedo * _LightColor0 * atten;

		    // Rim term.
		    float rim = abs(dot(viewDir, s.Normal));
		    float rimFinal = pow(1 - rim, 4) / 1.5;

		    // Spec term.
		    float fakeSpecular = rim;
		    float3 specularColor = _SpecCol * pow(fakeSpecular, _SpecPower) * s.Gloss;

		    // Final term.
		    float3 final = diffColor + specularColor + rimFinal;
		    return float4(final, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
