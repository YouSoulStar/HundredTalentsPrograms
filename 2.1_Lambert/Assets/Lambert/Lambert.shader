Shader "Custom/Lambert" {
	 Properties
    {
    }
    SubShader{
        Pass{
            
            Tags { "LightMode" = "ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct vertexInput{
                float4 vertex:POSITION;
                float3 normal:NORMAL;
            };

            struct vertexOutput{
                float4 pos:SV_POSITION;
                float4 col:COLOR;
            };

            //顶点
            vertexOutput vert(vertexInput v)
            {
                 vertexOutput o;
                 //将模型空间的法线转到世界空间
                 float3 normalDirection = normalize( mul(float4(v.normal,0.0),unity_WorldToObject).xyz);
                 //灯光方向
                 float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                 //计算兰伯特漫反射
                 float3 diffuseReflection =dot(normalDirection,lightDirection);
                 o.col = float4(diffuseReflection,1.0);
                 o.pos = UnityObjectToClipPos(v.vertex);
                 return o;
             }
          float4 frag(vertexOutput i):COLOR
          {
                 return i.col;
          }

            ENDCG
        }
    }
}