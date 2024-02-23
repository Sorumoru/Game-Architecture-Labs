//
//  phongShader.metal
//  PhongShader
//
//  Created by Jaskaran Chahal on 2024-02-21.
//

#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct Light
{
    float3 direction;
    float3 ambientColour;
    float ambientIntensity;
    float3 diffuseColour;
    float3 specularColour;
};

constant Light light = {
    .direction = { 0.13, 0.72, 0.68 },
    .ambientColour = { 0.72, 0.72, 0.72 },
    .ambientIntensity = 0.25,
    .diffuseColour = { 0.4, 0.4, 0.4 },
    .specularColour = { 1.0, 1.0, 1.0 }
};

constant float3 materialColour = {1, 1, 1};

constant float specularPower = 32;
constant float specularStrength = 0.5;

struct NodeBuffer {
  float4x4 modelViewProjectionTransform; // mention chapter 3 of learn open gl book
  float4x4 modelViewTransform;
  float4x4 normalTransform;
};

struct Vertex
{
    float3 position [[attribute(SCNVertexSemanticPosition)]];
    float3 normal [[attribute(SCNVertexSemanticNormal)]];
};

struct ProjectedVertex
{
    float4 position [[position]];
    float3 eyePosition;
    float3 normal;
};


vertex ProjectedVertex phongVertex(Vertex vert [[stage_in]], constant NodeBuffer& scn_node [[buffer(1)]])
{
    ProjectedVertex outVert;
    outVert.position = scn_node.modelViewProjectionTransform * float4(vert.position, 1.0);
    outVert.eyePosition = -(scn_node.modelViewTransform * float4(vert.position, 1.0)).xyz;
    outVert.normal = (scn_node.normalTransform * float4(vert.normal, 0.0)).xyz;
    return outVert;
}

fragment float4 phongFragment(ProjectedVertex vert [[stage_in]])
{
    // wtf
    return float4(0, 0, 0, 1);
}
