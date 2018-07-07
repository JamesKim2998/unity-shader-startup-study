Shader "Custom/Hologram" {
	Properties {
		_BumpMap ("NormapMap", 2D) = "white" {}
		_EmissionColor ("EmissionColor", color) = (1, 1, 1, 1)
		_RimPower ("RimPower", Range(1, 10)) = 3
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

		CGPROGRAM
		#pragma surface surf Lambert noambient alpha:fade
		#pragma multi_compile __ MORE_RIM_ON_DARK

        sampler2D _BumpMap;
		fixed3 _EmissionColor;
        fixed _RimPower;

		struct Input {
		    float2 uv_BumpMap;
			float3 viewDir;
			float3 worldPos;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		    float3 normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		    o.Normal = normal;

			float rim = 1 - saturate(dot(o.Normal, IN.viewDir));
			float lineDistortionFactor = normal.y;
            float lineEffect = pow(frac(IN.worldPos.g * 10 - _Time.z + lineDistortionFactor), 10);
			float glitchEffect = pow(abs(sin(sin(_Time.y + normal.z * 1000) * (_Time.z + 1000))) / 1.3, 6);
			o.Emission = (1 + lineEffect) * _EmissionColor;
			o.Alpha = (pow(rim, _RimPower) + glitchEffect) * saturate(pow(sin(_Time.w), 2) + 0.8);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
