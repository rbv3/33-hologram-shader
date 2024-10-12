uniform float uTime;

varying vec3 vModelPosition;
varying vec3 vNormal;

float random2D(vec2 value) {
    return fract(sin(dot(value.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    vec4 modelNormal = modelMatrix * vec4(normal, 0.0);

    // Glitch
    float glitchStrength = sin(uTime - modelPosition.y);
    glitchStrength = smoothstep(0.3, 1.0, glitchStrength);
    glitchStrength *= 0.25;
    modelPosition.x += (random2D(modelPosition.xz + uTime) - 0.5) * glitchStrength;
    modelPosition.z += (random2D(modelPosition.zx + uTime) - 0.5) * glitchStrength;

    // Final Position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;
    
    vModelPosition = modelPosition.xyz; //absolute position in world space
    vNormal = modelNormal.xyz;
}