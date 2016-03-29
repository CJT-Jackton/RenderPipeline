/**
 *
 * RenderPipeline
 *
 * Copyright (c) 2014-2016 tobspr <tobias.springer1@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#version 430

#pragma include "render_pipeline_base.inc.glsl"

#define RS_MAX_CLIP_DIST 500.0
#define RS_DISTANCE_SCALE 0.01
#define RS_USE_AVG_POSITION_INPUT 1
#define RS_MAX_AVG_POSITION_DIST 0.5
#define RS_KEEP_GOOD_DURATION 8.0
#define RS_KEEP_BAD_DURATION 8.0
#pragma include "includes/temporal_resolve.inc.glsl"


uniform sampler2D CurrentTex;
uniform sampler2D CurrentWSTex;
uniform sampler2D CombinedVelocity;
uniform sampler2D Previous_SSLRSpecular;
uniform sampler2D Previous_SSLRAvgWSIntersection;

layout(location=0) out vec4 result;
layout(location=1) out vec3 result_position;

void main() {
    vec2 texcoord = get_texcoord();
    vec2 velocity = texture(CombinedVelocity, texcoord).xy;
    vec2 last_coord = texcoord + velocity;

    result = resolve_temporal(CurrentTex, Previous_SSLRSpecular, texcoord, last_coord,
      CurrentWSTex, Previous_SSLRAvgWSIntersection, result_position);


}
