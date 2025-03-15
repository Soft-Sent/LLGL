project "LLGL_DXCommon"
    kind "StaticLib"
    language "C++"
    cppdialect "C++11" -- C++17
    staticruntime "on"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files { "**.h", "**.cpp" }
    includedirs{
      "../../../include"
    }    

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"
        defines { "DEBUG" }

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
        defines { "NDEBUG" }

    filter "configurations:Distribution"
        optimize "Full"
        runtime "Release"
        symbols "Off"
        defines { "NDEBUG" }

    filter "system:windows"
        defines { "_WINDOWS" }
        systemversion "latest"

    filter { "options:LLGL_D3D12_ENABLE_DXCOMPILER" }
        defines { "LLGL_D3D12_ENABLE_DXCOMPILER" }
        files { "DXC/**.h", "DXC/**.cpp" }