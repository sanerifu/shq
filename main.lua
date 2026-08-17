local triangle ---@type love.Mesh
local quad_shader ---@type love.Shader

function love.load()
    triangle = love.graphics.newMesh(
        {{"VertexPosition", "float", 3}},
        3,
        "triangles",
        "static"
    )

    quad_shader = love.graphics.newShader([[
        #pragma language glsl3
        varying vec2 vTexcoord;

        #ifdef VERTEX
        vec4 position(mat4 transform_projection, vec4 vertex_position) {
            vec2 tex = vec2(float((gl_VertexID << 1) & 2), float(gl_VertexID & 2));
            vTexcoord = tex;
            return vec4(tex * 2.0f - 1.0f, 0.0f, 1.0f);
        }
        #endif

        #ifdef PIXEL
        vec4 effect(vec4 color, Image tex, vec2 texcoord, vec2 screen_coords) {
            return vec4(vTexcoord, 0.0f, 1.0f);
        }
        #endif
    ]])
end

function love.update(dt)
end

function love.draw()
    love.graphics.setShader(quad_shader)
    love.graphics.draw(triangle)
    love.graphics.setShader()
end
