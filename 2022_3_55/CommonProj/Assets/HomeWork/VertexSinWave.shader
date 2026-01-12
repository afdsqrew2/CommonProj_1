Shader "Custom/VertexSinWave"
{
    Properties
    {
        _Amplitude ("Amplitude", Float) = 1.0
        _Frequency ("Frequency", Float) = 1.0
        _Speed ("Speed", Float) = 1.0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : NORMAL;
            };

            float _Amplitude;
            float _Frequency;
            float _Speed;

            v2f vert (appdata v)
            {
                v2f o;
                float4 localPos = v.vertex;
                // 正弦波变形公式，这里以x轴为例，你可以根据需要调整为y轴或其他轴
                localPos.x += sin(_Time.y * _Speed + localPos.y * _Frequency) * _Amplitude;
               

                
                o.pos = UnityObjectToClipPos(localPos);
                o.normal = v.normal;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
                //法向量
                fixed3 normalDir = normalize(i.normal);
                //光照方向
                fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                //漫反射计算
                fixed3 diffuse = _LightColor0.rgb * max(dot(normalDir,lightDir),0);
                fixed3 resultColor = diffuse+ambient;
                return fixed4(resultColor,1);
            }
            ENDCG
        }
    }
}
