uniform float uTime;
uniform vec3 uColor;

varying vec3 vModelPosition;
varying vec3 vNormal;

void main() {
    // Normal
    vec3 normal = normalize(vNormal);
    if(!gl_FrontFacing) {
        normal *= -1.0;
    }
    // Stripes
    float stripes = mod((vModelPosition.y - uTime * 0.02) * 20.0, 1.0);
    stripes = pow(stripes, 3.0);

    // Fresnel
    vec3 viewDirection = normalize(vModelPosition - cameraPosition);
    float fresnel = dot(viewDirection, normal) + 1.0;
    fresnel = pow(fresnel, 2.0);

    // Falloff
    float falloff = smoothstep(0.8, 0.0, fresnel);

    // Holographic
    float holographic = stripes * fresnel;
    holographic += fresnel * 1.25;
    holographic *= falloff;

    // Final color
    gl_FragColor = vec4(uColor, holographic);
    // gl_FragColor = vec4(vNormal, 1.0);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}