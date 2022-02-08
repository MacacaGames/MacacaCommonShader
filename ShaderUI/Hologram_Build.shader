Shader "MacacaCommon/UI/Hologram"
{
    Properties
    {
        _TexLight("TexLight", Float) = 0
        [PerRendererData]_MainTex("_MainTex", 2D) = "white" {}
        [NoScaleOffset]_HologramTex("HologramTex", 2D) = "white" {}
        _TileAndScroll_R("TileAndScroll_R", Vector) = (1, 1.57, 0, 1)
        _TileAndScroll_G("TileAndScroll_G", Vector) = (1, 2.3, 0, -0.5)
        _TileAndScroll_B("TileAndScroll_B", Vector) = (0.5, 0.5, 0, -1)
        [NoScaleOffset]_DisplacementTex("DisplacementTex", 2D) = "grey" {}
        _Displacement("Displacement", Range(-10, 10)) = 1
        [NoScaleOffset]_DisplacementAmountAnimationTex("DisplacementAmountAnimationTex", 2D) = "black" {}
        _DisplacementAmountAnimationSpeed("DisplacementAmountAnimationSpeed", Float) = 1


        // [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {} 
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

        Pass
        {
            Name "Default"
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            CBUFFER_START(UnityPerMaterial)
            float _TexLight;
            float4 _TileAndScroll_R;
            float4 _TileAndScroll_G;
            float4 _TileAndScroll_B;
            float _Displacement;
            float _DisplacementAmountAnimationSpeed;
            CBUFFER_END 
            sampler2D _MainTex; sampler sampler_MainTex ; float4 _MainTex_TexelSize;
            sampler2D _HologramTex; sampler sampler_HologramTex; float4 _HologramTex_TexelSize;
            sampler2D _DisplacementTex; sampler sampler_DisplacementTex; float4 _DisplacementTex_TexelSize;
            sampler2D _DisplacementAmountAnimationTex; sampler sampler_DisplacementAmountAnimationTex; float4 _DisplacementAmountAnimationTex_TexelSize;
            sampler _SampleTexture2D_E1324A69_Sampler_3_Linear_Repeat;
            sampler _SampleTexture2D_F7767551_Sampler_3_Linear_Repeat;
            sampler _SampleTexture2D_B782723A_Sampler_3_Linear_Repeat;
            sampler _SampleTexture2D_6026944_Sampler_3_Linear_Repeat;
            sampler _SampleTexture2D_A19F6433_Sampler_3_Linear_Repeat;
            sampler _SampleTexture2D_C8ABCE5_Sampler_3_Linear_Repeat; 


            // sampler2D _MainTex;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;



            // Graph Functions
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }

           
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            struct Bindings_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b
            {
                float3 TimeParameters;
            };
            
            void SG_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b(float2 Vector2_999BDB85, float4 Vector4_EA7A0B88, Bindings_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b IN, out float2 New_0)
            {
                float2 _Property_653E8036_Out_0 = Vector2_999BDB85;
                float4 _Property_5C758E06_Out_0 = Vector4_EA7A0B88;
                float _Split_F25CF1CB_R_1 = _Property_5C758E06_Out_0[0];
                float _Split_F25CF1CB_G_2 = _Property_5C758E06_Out_0[1];
                float _Split_F25CF1CB_B_3 = _Property_5C758E06_Out_0[2];
                float _Split_F25CF1CB_A_4 = _Property_5C758E06_Out_0[3];
                float4 _Combine_C5CBD22B_RGBA_4;
                float3 _Combine_C5CBD22B_RGB_5;
                float2 _Combine_C5CBD22B_RG_6;
                Unity_Combine_float(_Split_F25CF1CB_R_1, _Split_F25CF1CB_G_2, 0, 0, _Combine_C5CBD22B_RGBA_4, _Combine_C5CBD22B_RGB_5, _Combine_C5CBD22B_RG_6);
                float4 _Combine_3F6A309F_RGBA_4;
                float3 _Combine_3F6A309F_RGB_5;
                float2 _Combine_3F6A309F_RG_6;
                Unity_Combine_float(_Split_F25CF1CB_B_3, _Split_F25CF1CB_A_4, 0, 0, _Combine_3F6A309F_RGBA_4, _Combine_3F6A309F_RGB_5, _Combine_3F6A309F_RG_6);
                float2 _Multiply_C7AECE3A_Out_2;
                Unity_Multiply_float(_Combine_3F6A309F_RG_6, (IN.TimeParameters.x.xx), _Multiply_C7AECE3A_Out_2);
                float2 _TilingAndOffset_45D898FE_Out_3;
                Unity_TilingAndOffset_float(_Property_653E8036_Out_0, _Combine_C5CBD22B_RG_6, _Multiply_C7AECE3A_Out_2, _TilingAndOffset_45D898FE_Out_3);
                New_0 = _TilingAndOffset_45D898FE_Out_3;
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }
        
            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            v2f vert(appdata_t v)
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
                OUT.worldPosition = v.vertex;
                OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

                OUT.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);

                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                half4 color = IN.color;


                float2 _UV_E11E953D_Out_0 = IN.texcoord;
                float4 _SampleTexture2D_E1324A69_RGBA_0 = tex2D(_DisplacementTex, IN.texcoord.xy);
                float _SampleTexture2D_E1324A69_R_4 = _SampleTexture2D_E1324A69_RGBA_0.r;
                float _SampleTexture2D_E1324A69_G_5 = _SampleTexture2D_E1324A69_RGBA_0.g;
                float _SampleTexture2D_E1324A69_B_6 = _SampleTexture2D_E1324A69_RGBA_0.b;
                float _SampleTexture2D_E1324A69_A_7 = _SampleTexture2D_E1324A69_RGBA_0.a;
                float _Property_3C2AC186_Out_0 = _Displacement;
                float _Property_197D9B1B_Out_0 = _DisplacementAmountAnimationSpeed;
                float _Multiply_EFBAFA87_Out_2;
                Unity_Multiply_float(_Property_197D9B1B_Out_0, _Time.y, _Multiply_EFBAFA87_Out_2);
                float2 _Vector2_CD931335_Out_0 = float2(_Multiply_EFBAFA87_Out_2, 0);
                float2 _TilingAndOffset_84250D08_Out_3;
                Unity_TilingAndOffset_float(IN.texcoord.xy, float2 (0.01, 0.01), _Vector2_CD931335_Out_0, _TilingAndOffset_84250D08_Out_3);
                float4 _SampleTexture2D_F7767551_RGBA_0 = tex2D(_DisplacementAmountAnimationTex,  _TilingAndOffset_84250D08_Out_3);
                float _SampleTexture2D_F7767551_R_4 = _SampleTexture2D_F7767551_RGBA_0.r;
                float _SampleTexture2D_F7767551_G_5 = _SampleTexture2D_F7767551_RGBA_0.g;
                float _SampleTexture2D_F7767551_B_6 = _SampleTexture2D_F7767551_RGBA_0.b;
                float _SampleTexture2D_F7767551_A_7 = _SampleTexture2D_F7767551_RGBA_0.a;
                float _Multiply_E34944BE_Out_2;
                Unity_Multiply_float(_Property_3C2AC186_Out_0, _SampleTexture2D_F7767551_R_4, _Multiply_E34944BE_Out_2);
                float4 _Lerp_61715496_Out_3;
                Unity_Lerp_float4(_UV_E11E953D_Out_0.xyxx, _SampleTexture2D_E1324A69_RGBA_0, (_Multiply_E34944BE_Out_2.xxxx), _Lerp_61715496_Out_3);
                float4 _SampleTexture2D_B782723A_RGBA_0 = tex2D(_MainTex,  (_Lerp_61715496_Out_3.xy));
                float _SampleTexture2D_B782723A_R_4 = _SampleTexture2D_B782723A_RGBA_0.r;
                float _SampleTexture2D_B782723A_G_5 = _SampleTexture2D_B782723A_RGBA_0.g;
                float _SampleTexture2D_B782723A_B_6 = _SampleTexture2D_B782723A_RGBA_0.b;
                float _SampleTexture2D_B782723A_A_7 = _SampleTexture2D_B782723A_RGBA_0.a;
                float4 _Multiply_917E123C_Out_2;
                Unity_Multiply_float(_SampleTexture2D_B782723A_RGBA_0, IN.color, _Multiply_917E123C_Out_2);
                float _Vector1_116346AB_Out_0 = 0;
                float4 _UV_6074A14B_Out_0 = IN.texcoord.xyxx;
                float4 _Property_5969DE6_Out_0 = _TileAndScroll_G;
                Bindings_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b _TileAndScroll_730A7D4F;
                _TileAndScroll_730A7D4F.TimeParameters = _Time.y;
                float2 _TileAndScroll_730A7D4F_New_0;
                SG_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b((_UV_6074A14B_Out_0.xy), _Property_5969DE6_Out_0, _TileAndScroll_730A7D4F, _TileAndScroll_730A7D4F_New_0);
                float4 _SampleTexture2D_6026944_RGBA_0 = tex2D(_HologramTex,  _TileAndScroll_730A7D4F_New_0);
                float _SampleTexture2D_6026944_R_4 = _SampleTexture2D_6026944_RGBA_0.r;
                float _SampleTexture2D_6026944_G_5 = _SampleTexture2D_6026944_RGBA_0.g;
                float _SampleTexture2D_6026944_B_6 = _SampleTexture2D_6026944_RGBA_0.b;
                float _SampleTexture2D_6026944_A_7 = _SampleTexture2D_6026944_RGBA_0.a;
                float _OneMinus_C8A30658_Out_1;
                Unity_OneMinus_float(_SampleTexture2D_6026944_G_5, _OneMinus_C8A30658_Out_1);
                float _Property_6FBE8450_Out_0 = _TexLight;
                float _Lerp_FC374C02_Out_3;
                Unity_Lerp_float(_Vector1_116346AB_Out_0, _OneMinus_C8A30658_Out_1, _Property_6FBE8450_Out_0, _Lerp_FC374C02_Out_3);
                float4 _Add_EB55D51E_Out_2;
                Unity_Add_float4(_Multiply_917E123C_Out_2, (_Lerp_FC374C02_Out_3.xxxx), _Add_EB55D51E_Out_2);
                float _Split_6CE3CF41_R_1 = IN.color[0];
                float _Split_6CE3CF41_G_2 = IN.color[1];
                float _Split_6CE3CF41_B_3 = IN.color[2];
                float _Split_6CE3CF41_A_4 = IN.color[3];
                float _Multiply_C3E7C567_Out_2;
                Unity_Multiply_float(_SampleTexture2D_B782723A_A_7, _Split_6CE3CF41_A_4, _Multiply_C3E7C567_Out_2);
                float4 _UV_B8493A7E_Out_0 = IN.texcoord.xyxx;
                float4 _Property_4C808D12_Out_0 = _TileAndScroll_R;
                Bindings_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b _TileAndScroll_35F430CD;
                _TileAndScroll_35F430CD.TimeParameters = _Time.y;
                float2 _TileAndScroll_35F430CD_New_0;
                SG_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b((_UV_B8493A7E_Out_0.xy), _Property_4C808D12_Out_0, _TileAndScroll_35F430CD, _TileAndScroll_35F430CD_New_0);
                float4 _SampleTexture2D_A19F6433_RGBA_0 = tex2D(_HologramTex,  _TileAndScroll_35F430CD_New_0);
                float _SampleTexture2D_A19F6433_R_4 = _SampleTexture2D_A19F6433_RGBA_0.r;
                float _SampleTexture2D_A19F6433_G_5 = _SampleTexture2D_A19F6433_RGBA_0.g;
                float _SampleTexture2D_A19F6433_B_6 = _SampleTexture2D_A19F6433_RGBA_0.b;
                float _SampleTexture2D_A19F6433_A_7 = _SampleTexture2D_A19F6433_RGBA_0.a;
                float _Multiply_4F10F96D_Out_2;
                Unity_Multiply_float(_SampleTexture2D_A19F6433_R_4, _SampleTexture2D_6026944_G_5, _Multiply_4F10F96D_Out_2);
                float4 _UV_6E7E5E45_Out_0 = IN.texcoord.xyxx;
                float4 _Property_4A0DEE9E_Out_0 = _TileAndScroll_B;
                Bindings_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b _TileAndScroll_A379EBEE;
                _TileAndScroll_A379EBEE.TimeParameters = _Time.y;
                float2 _TileAndScroll_A379EBEE_New_0;
                SG_TileAndScroll_9ef7d3d5eefb43d47ba39d1d9390383b((_UV_6E7E5E45_Out_0.xy), _Property_4A0DEE9E_Out_0, _TileAndScroll_A379EBEE, _TileAndScroll_A379EBEE_New_0);
                float4 _SampleTexture2D_C8ABCE5_RGBA_0 = tex2D(_HologramTex,  _TileAndScroll_A379EBEE_New_0);
                float _SampleTexture2D_C8ABCE5_R_4 = _SampleTexture2D_C8ABCE5_RGBA_0.r;
                float _SampleTexture2D_C8ABCE5_G_5 = _SampleTexture2D_C8ABCE5_RGBA_0.g;
                float _SampleTexture2D_C8ABCE5_B_6 = _SampleTexture2D_C8ABCE5_RGBA_0.b;
                float _SampleTexture2D_C8ABCE5_A_7 = _SampleTexture2D_C8ABCE5_RGBA_0.a;
                float _Multiply_5ADBA58F_Out_2;
                Unity_Multiply_float(_Multiply_4F10F96D_Out_2, _SampleTexture2D_C8ABCE5_B_6, _Multiply_5ADBA58F_Out_2);
                float _Multiply_EFB20034_Out_2;
                Unity_Multiply_float(_Multiply_5ADBA58F_Out_2, 2, _Multiply_EFB20034_Out_2);
                float _Multiply_A97DF4EB_Out_2;
                Unity_Multiply_float(_Multiply_C3E7C567_Out_2, _Multiply_EFB20034_Out_2, _Multiply_A97DF4EB_Out_2);
                
                color.xyz=  _Add_EB55D51E_Out_2.xyz;
                color.a = _Multiply_A97DF4EB_Out_2;

                #ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                return color;
            }
        ENDCG
        }
    }
}