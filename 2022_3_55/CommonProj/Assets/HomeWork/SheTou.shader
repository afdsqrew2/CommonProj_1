Shader "Custom/SinWaveMove"
{
    Properties
    {
        _Amplitude("Amplitude", Float) = 0.5 // 振幅
        _Frequency("Frequency", Float) = 1.0 // 频率
         _Speed ("Speed", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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

            float _Amplitude;
            float _Frequency;
            float _Speed;
            v2f vert (appdata v)
            {
                v2f o;
                float4 localPos = v.vertex;
               localPos.x += sin(_Time.y * _Speed +  _Frequency) * _Amplitude;
                o.vertex = UnityObjectToClipPos(localPos);
                o.uv = v.uv;
                
                // 计算正弦波偏移量并应用到顶点位置上
              
                // 例如，如果要沿着Y轴移动，使用 o.vertex.y += waveOffset;
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(1,1,1,1); // 简单的白色材质输出
            }
            ENDCG
        }
    }
}
