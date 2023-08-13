#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out float rainbow;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

	rainbow = (Color.r == 254.0/255.0 && Color.g == 254.0/255.0 && Color.b == 254.0/255.0) ? 1.0 : 0.0;
    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
}