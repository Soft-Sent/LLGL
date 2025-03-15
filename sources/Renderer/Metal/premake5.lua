project "LLGL_Metal"
    kind "StaticLib"
    language "C++"
    targetdir "bin/%{cfg.buildcfg}"

    -- Source files
    files {
        "**.h", "**.mm", "**.cpp",
        "Buffer/**.h", "Buffer/**.mm", "Buffer/**.cpp",
        "Command/**.h", "Command/**.mm", "Command/**.cpp",
        "RenderState/**.h", "RenderState/**.mm", "RenderState/**.cpp",
        "Shader/**.h", "Shader/**.mm", "Shader/**.cpp",
        "Shader/Builtin/MTBuiltin.h", "Shader/Builtin/MTBuiltin.mm",
        "Texture/**.h", "Texture/**.mm", "Texture/**.cpp",
        --"../Include/Metal/**.h"
    }

    -- Source group filters
    vpaths {
        ["Metal/"] = { "**.mm", "**.cpp", "**.h" },
        ["Metal/Buffer/"] = { "Buffer/**.mm", "Buffer/**.cpp", "Buffer/**.h" },
        ["Metal/Command/"] = { "Command/**.mm", "Command/**.cpp", "Command/**.h" },
        ["Metal/RenderState/"] = { "RenderState/**.mm", "RenderState/**.cpp", "RenderState/**.h" },
        ["Metal/Shader/"] = { "Shader/**.mm", "Shader/**.cpp", "Shader/**.h" },
        ["Metal/Shader/Builtin/"] = { "Shader/Builtin/MTBuiltin.h", "Shader/Builtin/MTBuiltin.mm" },
        ["Metal/Texture/"] = { "Texture/**.mm", "Texture/**.cpp", "Texture/**.h" },
        ["../../Platform/"] = { "../Metal/**.h" }
    }

    -- Build settings
    filter "configurations:Debug"
        symbols "On"
        runtime "Debug"
        defines { "DEBUG" }
    filter "configurations:Release"
        optimize "On"
        runtime "Release"
        defines { "NDEBUG" }
    filter {"configurations:Distribution"}
        optimize "Full"
        runtime "Release"
        symbols "Off"
        defines { "NDEBUG" }

    links { "Foundation.framework", "QuartzCore.framework", "Metal.framework", "MetalKit.framework" }
    includedirs { "../LLGL_Common" }