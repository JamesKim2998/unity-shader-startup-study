Shader "Custom/fire2" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTex2 ("Albedo (RGB)", 2D) = "black" {}
		_Distortion ("Distortion", float) = 1
		_DistortionCorrection ("Distortion Correction", float) = 0.1
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

		CGPROGRAM
		#pragma surface surf Standard alpha:fade

		sampler2D _MainTex;
		sampler2D _MainTex2;
		float _Distortion;
		float _DistortionCorrection;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2 - _Time.y);
			fixed offset = (d.r - _DistortionCorrection) * _Distortion;
			float2 uv = IN.uv_MainTex + offset;
			uv = saturate(uv);
			fixed4 c = tex2D (_MainTex, uv);
			o.Emission = c;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
