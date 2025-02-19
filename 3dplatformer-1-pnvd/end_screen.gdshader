shader_type canvas_item;
render_mode blend_mix;

uniform float blur_size : hint_range(0.0, 10.0) = 7.0;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    vec2 pixel_size = SCREEN_PIXEL_SIZE * blur_size;
    vec4 blurred_color = vec4(0.0);

    
    float weight[5] = float[](0.0545, 0.2442, 0.4026, 0.2442, 0.0545);

    for (int x = -2; x <= 2; x++) {
        for (int y = -2; y <= 2; y++) {
            vec2 offset = vec2(float(x), float(y)) * pixel_size;
            blurred_color += texture(screen_texture, SCREEN_UV + offset) * weight[x + 2] * weight[y + 2];
        }
    }

    
    COLOR.rgb = mix(blurred_color.rgb, COLOR.rgb, COLOR.a);
    COLOR.a = COLOR.a; 
}
