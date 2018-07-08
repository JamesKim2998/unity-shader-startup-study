Shader "Custom/Toon" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BrightnessEdge1("BrightnessEdge1", Range(0, 1)) = 0.95
		_BrightnessEdge2("BrightnessEdge2", Range(0, 1)) = 0.7
		_BrightnessLevel1("BrightnessLevel1", Range(0, 1)) = 0.4
		_BrightnessLevel2("BrightnessLevel2", Range(0, 1)) = 0.7
		_BrightnessLevel3("BrightnessLevel3", Range(0, 1)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Toon noambient

		sampler2D _MainTex;
		float _BrightnessEdge1;
		float _BrightnessEdge2;
		float _BrightnessLevel1;
		float _BrightnessLevel2;
		float _BrightnessLevel3;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
		}

		float4 LightingToon(SurfaceOutput o, float3 lightDir, float atten) {
		    // Calculate diffuse.
		    float ndotl = dot(o.Normal, lightDir) * 0.5 + 0.5;
		    float diffuse = step(_BrightnessEdge2, ndotl) * (_BrightnessLevel3 - _BrightnessLevel2)
				+ step(_BrightnessEdge1, ndotl) * (_BrightnessLevel2 - _BrightnessLevel1)
				+ _BrightnessLevel1;

			// Calculate Specular.
			float3 specularDir = normalize(2 * ndotl * o.Normal - lightDir);
			float specular = pow(saturate(dot(specularDir, o.Normal)), 40);
			float specularStep = ceil(specular * 5) / 5;

		    return float4(o.Albedo * (diffuse + specularStep) * _LightColor0, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
