﻿Shader "ProceduralFX/FadeOutDotCrawl"
{
	Properties
	{
		[HideInInspector]
		_MainTex ("Texture", 2D) = "white" {}
		_Variables ("Variables", Vector) = (0,0,0,0)
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			float4 _Variables;

			float4 frag (v2f i) : SV_Target
			{
				
			
				float4 col = tex2D(_MainTex, i.uv) + 0.02*tex2D(_MainTex, i.uv+float2(0,0.005));
				col*=_Variables.x;
				return step(0,col)*col;
			}
			ENDCG
		}
	}
}
