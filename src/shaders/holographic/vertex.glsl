uniform float uTime;

varying vec3 vModelPosition;
varying vec3 vNormal;

#include ../includes/random2D.glsl

void main() {
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    vec4 modelNormal = modelMatrix * vec4(normal, 0.0);

    // Glitch
    float glitchTime = uTime - modelPosition.y;
    float glitchStrength = sin(glitchTime) + sin(glitchTime * 3.45) + sin(glitchTime*8.76);
    glitchStrength /= 3.0; // since we have 3 sines, we still want the range to be 0-1
    glitchStrength = smoothstep(0.3, 1.0, glitchStrength);
    glitchStrength *= 0.25;
    modelPosition.x += (random2D(modelPosition.xz + uTime) - 0.5) * glitchStrength;
    modelPosition.z += (random2D(modelPosition.zx + uTime) - 0.5) * glitchStrength;

    // Final Position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;
    
    vModelPosition = modelPosition.xyz; //absolute position in world space
    vNormal = modelNormal.xyz;
}