Shader "Custom/CustomLambert" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("NormalMap", 2D) = "bump" {}
		_RimColor ("RimColor", color) = (1, 1, 1, 1)
		_RimPower ("RimPower", Range(1, 10)) = 3
		_RimLightLerp ("RimLightLerp", Range(0, 1)) = 0.4
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert
		#pragma multi_compile __ MORE_RIM_ON_DARK

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed3 _RimColor;
		fixed _RimPower;
		fixed _RimLightLerp;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

			float rimCameraView = 1 - saturate(dot(o.Normal, IN.viewDir));
			float3 lightDirection = normalize(_WorldSpaceLightPos0);
			float rimLightView = 1 - saturate(abs(dot(o.Normal, lightDirection)));
			float rimFinal = saturate(lerp(rimCameraView, rimLightView, _RimLightLerp));
			o.Emission = _RimColor * pow(rimFinal, _RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
