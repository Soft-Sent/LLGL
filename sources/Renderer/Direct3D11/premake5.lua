project "LLGL_Direct3D11"
    kind "StaticLib"
    language "C++"
    cppdialect "C++11"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	  objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- Options
    newoption {
        trigger = "d3d11-featurelevel",
        description = "Enable maximum Direct3D 11 feature level",
        allowed = {
            { "Direct3D 11.0", "Direct3D 11.0" },
            { "Direct3D 11.1", "Direct3D 11.1" },
            { "Direct3D 11.2", "Direct3D 11.2" },
            { "Direct3D 11.3", "Direct3D 11.3" }
        }
    }

    local featureLevel = "0"
    if _OPTIONS["d3d11-featurelevel"] == "Direct3D 11.3" then
        featureLevel = "3"
    elseif _OPTIONS["d3d11-featurelevel"] == "Direct3D 11.2" then
        featureLevel = "2"
    elseif _OPTIONS["d3d11-featurelevel"] == "Direct3D 11.1" then
        featureLevel = "1"
    end
    defines { "LLGL_D3D11_ENABLE_FEATURELEVEL=" .. featureLevel, "NOMINMAX" }

    -- Source files
    files { "**.h", "**.cpp" }
    includedirs { 
        "../../../include"
    }

    files {
        "Buffer/**.h", "Buffer/**.cpp",
        "Command/**.h", "Command/**.cpp",
        "RenderState/**.h", "RenderState/**.cpp",
        "Shader/**.h", "Shader/**.cpp",
        "Shader/Builtin/D3D11Builtin.h",
        "Texture/**.h", "Texture/**.cpp",
        "../Include/Direct3D11/**.h"
    }
    
    -- Source group filters
    vpaths {
        ["Direct3D11/"] = { "**.cpp", "**.h" },
        ["Direct3D11/Buffer/"] = { "Buffer/**.cpp", "Buffer/**.h" },
        ["Direct3D11/Command/"] = { "Command/**.cpp", "Command/**.h" },
        ["Direct3D11/RenderState/"] = { "RenderState/**.cpp", "RenderState/**.h" },
        ["Direct3D11/Shader/"] = { "Shader/**.cpp", "Shader/**.h" },
        ["Direct3D11/Shader/Builtin/"] = { "Shader/Builtin/D3D11Builtin.h" },
        ["Direct3D11/Texture/"] = { "Texture/**.cpp", "Texture/**.h" },
        ["Include/Platform/"] = { "../Include/Direct3D11/**.h" }
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
    filter {}

    -- Link dependencies
    links { "d3d11", "dxgi", "D3DCompiler" }
    includedirs { "../DXCommon" }