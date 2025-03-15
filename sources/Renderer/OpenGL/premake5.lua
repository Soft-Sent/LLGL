project "LLGL_OpenGL"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20" -- C++17
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "**.h", "**.cpp"
    }

    filter "system:windows"
        defines { "LLGL_PLATFORM_WIN32" }
        files { "../../Platform/Win32/**.cpp", "../../Platform/Win32/**.h" }
        links { "opengl32" }
    
    filter "system:linux"
        defines { "LLGL_PLATFORM_LINUX" }
        files { "../../Platform/Linux/**.cpp", "../../Platform/Linux/**.h" }
        links { "GL" }
    
    filter "system:macosx"
        defines { "LLGL_PLATFORM_MACOS" }
        files { "../../Platform/MacOS/**.mm", "../../Platform/MacOS/**.h" }
        links { "OpenGL.framework" }
    
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"
    
    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"
    
    filter "options:LLGL_BUILD_RENDERER_OPENGL"
        defines { "LLGL_BUILD_RENDERER_OPENGL" }
        files {
            "RendererGL/**.cpp",
            "RendererGL/**.h",
            "Buffer/**.cpp",
            "Buffer/**.h",
            "Command/**.cpp",
            "Command/**.h",
            "Ext/**.cpp",
            "Ext/**.h",
            "RenderState/**.cpp",
            "RenderState/**.h",
            "Shader/**.cpp",
            "Shader/**.h",
            "Texture/**.cpp",
            "Texture/**.h",
            "Profile/**.cpp",
            "Profile/**.h"
        }
        includedirs { "${BACKEND_INCLUDE_DIR}/OpenGL" }
        links { "GL" }
    
    filter "options:LLGL_BUILD_RENDERER_OPENGLES3"
        defines { "LLGL_BUILD_RENDERER_OPENGLES3" }
        files {
            "RendererGL/**.cpp",
            "RendererGL/**.h",
            "Buffer/**.cpp",
            "Buffer/**.h",
            "Command/**.cpp",
            "Command/**.h",
            "Ext/**.cpp",
            "Ext/**.h",
            "RenderState/**.cpp",
            "RenderState/**.h",
            "Shader/**.cpp",
            "Shader/**.h",
            "Texture/**.cpp",
            "Texture/**.h",
            "Profile/GLES/**.cpp",
            "Profile/GLES/**.h"
        }
        includedirs { "${BACKEND_INCLUDE_DIR}/OpenGLES3" }
        links { "GLESv3", "EGL" }
    
    filter "options:LLGL_BUILD_RENDERER_WEBGL"
        defines { "LLGL_BUILD_RENDERER_WEBGL" }
        files {
            "RendererGL/**.cpp",
            "RendererGL/**.h",
            "Buffer/**.cpp",
            "Buffer/**.h",
            "Command/**.cpp",
            "Command/**.h",
            "Ext/**.cpp",
            "Ext/**.h",
            "RenderState/**.cpp",
            "RenderState/**.h",
            "Shader/**.cpp",
            "Shader/**.h",
            "Texture/**.cpp",
            "Texture/**.h",
            "Profile/WebGL/**.cpp",
            "Profile/WebGL/**.h"
        }
        includedirs { "${BACKEND_INCLUDE_DIR}/WebGL" }
        links { "GLESv2", "EGL" }