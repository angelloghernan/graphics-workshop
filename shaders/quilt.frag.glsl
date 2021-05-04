precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    vec2 coord = gl_FragCoord.xy / resolution;

    // Output RGB color in range from 0.0 to 1.0
    vec3 color = vec3(coord.x, coord.y, 0.0);
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
     vec2 squareCoord = 20.0 * gl_FragCoord.xy / resolution.y + vec2(time);
     vec2 loc = fract(squareCoord);
     color = vec3(smoothstep(-0.05, 0.05, loc.y - loc.x));

    // 2. Uncomment these lines to invert some of the triangles

    // Note: I added color changes based on seed to make it a little more interesting, but it's less obvious how the pattern repeats with some seeds.
    // It looks really cool if you scroll slowly through all 101 seeds, but it can look confusing.
    // Replace "color = seed - color" with the commented lines if you want to see the original code
    vec2 cell = squareCoord - loc;
    if (mod(2.0 * cell.x + cell.y, 5.0) == floor(seed * 5.0)) {
        // color = 1.0 - color;
         color = seed - color;
     }
    else if (mod(cell.x + 3.0 * cell.y, 10.0) == floor(seed * 10.0))
    {
        // color = 1.0 - color;
        color = seed - color;
    }

    // 3. Uncomment these lines to produce interesting colors
     float c = mod(3.0 * cell.x + 2.0 * cell.y * seed, 7.0) / 7.0;
     color = 1.0 - (1.0 - color) * vec3(abs(sin(cell.x)) * c, c * 0.9, abs(cos(cell.y)) * c);

    // 4. Uncomment to lighten the colors
    color = sqrt(color);

    gl_FragColor = vec4(color, 1.0);
}
