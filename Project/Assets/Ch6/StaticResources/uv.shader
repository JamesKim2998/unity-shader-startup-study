Shader "Custom/uv" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_FlowSpeed ("Flow Speed", float) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows

		sampler2D _MainTex;

		float _FlowSpeed;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float2 uv = IN.uv_MainTex;
			fixed4 c = tex2D (_MainTex, float2(uv.x, uv.y + _Time.y * _FlowSpeed));
			o.Albedo = c;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
