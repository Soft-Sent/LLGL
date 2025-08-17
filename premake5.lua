-- premake5.lua for building LLGL as a static lib with Premake
-- Works with the current repo layout: include/, sources/Core, sources/Renderer/*, sources/Platform/<OS>

project "LLGL"
    kind "StaticLib"
    language "C++"
    cppdialect "C++14"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir    ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- Core headers + sources
    files {
        "include/**.h", "include/**.hpp",

        "sources/Core/**.h",   "sources/Core/**.hpp",   "sources/Core/**.cpp",

        -- Common renderer code (NOT backend-specific only)
        "sources/Renderer/**.h", "sources/Renderer/**.hpp", "sources/Renderer/**.cpp",

        -- Common platform code (these contain Surface/Window pieces referenced by all backends)
        "sources/Platform/Canvas.cpp",
        "sources/Platform/ConsoleManip.h",
        "sources/Platform/ConsoleManip.cpp",
        "sources/Platform/Debug.cpp",
        "sources/Platform/Debug.h",
        "sources/Platform/Display.cpp",
        "sources/Platform/DisplayFlags.cpp",
        "sources/Platform/Module.h",
        "sources/Platform/Path.cpp",
        "sources/Platform/Path.h",
        "sources/Platform/Window.cpp",
    }

    -- Some folders (Renderer/SPIRV) include headers used across backends
    includedirs {
        "include",
        "sources/Renderer/SPIRV",
        "external/OpenGL/include",
    }

    defines { "LLGL_BUILD_STATIC_LIB", "LLGL_OPENGL"  }

    -- ===== Windows =====
    filter "system:windows"
        systemversion "latest"
        defines { "LLGL_PLATFORM_WINDOWS" }

        -- Compile Windows backends and platform layer
        files {
            "sources/Renderer/Direct3D11/**.h", "sources/Renderer/Direct3D11/**.hpp", "sources/Renderer/Direct3D11/**.cpp",
            "sources/Renderer/Direct3D12/**.h", "sources/Renderer/Direct3D12/**.hpp", "sources/Renderer/Direct3D12/**.cpp",
            "sources/Renderer/DXCommon/**.h",   "sources/Renderer/DXCommon/**.hpp",   "sources/Renderer/DXCommon/**.cpp",
            "sources/Renderer/OpenGL/**.h",     "sources/Renderer/OpenGL/**.hpp",     "sources/Renderer/OpenGL/**.cpp",
            "sources/Renderer/Vulkan/**.h",     "sources/Renderer/Vulkan/**.hpp",     "sources/Renderer/Vulkan/**.cpp",

            "sources/Platform/Windows/**.h",    "sources/Platform/Windows/**.hpp",    "sources/Platform/Windows/**.cpp"
        }

        -- Enable desired backends (toggle off if you don’t need them)
        defines {
            "LLGL_BUILD_RENDERER_DIRECT3D11",
            "LLGL_BUILD_RENDERER_DIRECT3D12",
            "LLGL_BUILD_RENDERER_OPENGL",
            "LLGL_BUILD_RENDERER_VULKAN"
        }

        -- System libs for Windows backends
        links {
            "user32", "gdi32", "shell32", "ole32", "oleaut32", "advapi32",
            "dxgi", "d3d11", "d3d12", "dxguid", "d3dcompiler",
            "opengl32",
            "vulkan-1"
        }

    -- ===== Linux =====
    filter "system:linux"
        pic "On"
        systemversion "latest"
        defines { "LLGL_PLATFORM_LINUX", "LLGL_BUILD_RENDERER_OPENGL", "LLGL_BUILD_RENDERER_VULKAN" }

        files {
            "sources/Renderer/OpenGL/**.h", "sources/Renderer/OpenGL/**.hpp", "sources/Renderer/OpenGL/**.cpp",
            "sources/Renderer/Vulkan/**.h", "sources/Renderer/Vulkan/**.hpp", "sources/Renderer/Vulkan/**.cpp",
            "sources/Platform/Linux/**.h",  "sources/Platform/Linux/**.hpp",  "sources/Platform/Linux/**.cpp"
        }

        links { "X11", "Xrandr", "dl", "pthread", "GL", "vulkan" }

    -- ===== macOS =====
    filter "system:macosx"
        pic "On"
        systemversion "latest"
        defines { "LLGL_PLATFORM_MACOS", "LLGL_BUILD_RENDERER_METAL", "LLGL_BUILD_RENDERER_OPENGL" }

        files {
            "sources/Renderer/Metal/**.h", "sources/Renderer/Metal/**.mm", "sources/Renderer/Metal/**.cpp",
            "sources/Renderer/OpenGL/**.h", "sources/Renderer/OpenGL/**.hpp", "sources/Renderer/OpenGL/**.cpp",
            "sources/Platform/MacOS/**.h",  "sources/Platform/MacOS/**.mm",  "sources/Platform/MacOS/**.cpp"
        }

        -- macOS frameworks
        links { "Cocoa.framework", "QuartzCore.framework", "Metal.framework", "OpenGL.framework" }

    -- ===== Configs =====
    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"
        defines { "LLGL_DEBUG" }

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
        defines { "LLGL_RELEASE", "NDEBUG" }

    filter "configurations:Distribution"
        runtime "Release"
        optimize "Full"
        symbols "Off"
        defines { "LLGL_DISTRIBUTION", "NDEBUG" }

    filter {}
