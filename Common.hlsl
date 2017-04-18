const int NUM_SAMPLES = 16;
const float PI = 3.14159265322f;

float viewWidth;
float viewHeight;

// Recompute the inverse view dimensions. The one provided by RenderMonkey is faulty! :(
#define invViewDimensions float2(1.0f / viewWidth, 1.0f / viewHeight)

sampler2D sceneTexture;
sampler2D verticalBlurTexture;
sampler2D diagonalBlurTexture;

float coc;
float angle;

float4 BlurTexture(sampler2D tex, float2 uv, float2 direction)
{
   float4 finalColor = 0.0f;
   float blurAmount = 0.0f;
  
   // This offset is important. Prevents edge overlaps.
   // See blog post for more information.
   uv += direction * 0.5f;
   
   for (int i = 0; i < NUM_SAMPLES; ++i)
   {
      float4 color = tex2D(tex, uv + direction * i);
      color       *= color.a;
      blurAmount  += color.a;   
      finalColor  += color;
   }
  
   return (finalColor / blurAmount);
}