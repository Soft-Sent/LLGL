project "LLGL"
    kind "StaticLib"
    language "C++"
    cppdialect "C++23"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir    ("bin-int/" .. outputdir .. "/%{prj.name}")
    
    -- Get Vulkan SDK path (used throughout the file)
    VULKAN_SDK = os.getenv("VULKAN_SDK")

    files {
        "include/**.h", 

        "sources/Core/**.h",
        "sources/Core/**.cpp",

        "sources/Platform/Canvas.cpp",
        "sources/Platform/ConsoleManip.h",
        "sources/Platform/ConsoleManip.cpp",
        "sources/Platform/Debug.cpp",
        "sources/Platform/Debug.h",
        "sources/Platform/DebugBreakOnError.cpp",
        "sources/Platform/Display.cpp",
        "sources/Platform/DisplayFlags.cpp",
        "sources/Platform/Module.h",
        "sources/Platform/Path.cpp",
        "sources/Platform/Path.h",
        "sources/Platform/Window.cpp",

        "sources/Renderer/BindingIterator.cpp",
        "sources/Renderer/BindingIterator.h",
        "sources/Renderer/Buffer.cpp",
        "sources/Renderer/BufferArray.cpp",
        "sources/Renderer/BufferFlags.cpp",
        "sources/Renderer/BufferUtils.cpp",
        "sources/Renderer/BufferUtils.h",
        "sources/Renderer/BuildID.h",
        "sources/Renderer/CheckedCast.h",
        "sources/Renderer/ContainerTypes.h",
        "sources/Renderer/DynamicModuleInterface.h",
        "sources/Renderer/Format.cpp",
        "sources/Renderer/ModuleInterface.h",
        "sources/Renderer/PipelineStateFlags.cpp",
        "sources/Renderer/PipelineStateUtils.cpp",
        "sources/Renderer/PipelineStateUtils.h",
        "sources/Renderer/ProxyPipelineCache.cpp",
        "sources/Renderer/ProxyPipelineCache.h",
        "sources/Renderer/QueryHeap.cpp",
        "sources/Renderer/RenderingDebugger.cpp",
        "sources/Renderer/RenderPassUtils.cpp",
        "sources/Renderer/RenderPassUtils.h",
        "sources/Renderer/RenderSystem.cpp",
        "sources/Renderer/RenderSystemFlags.cpp",
        "sources/Renderer/RenderSystemModule.cpp",
        "sources/Renderer/RenderSystemModule.h",
        "sources/Renderer/RenderSystemRegistry.cpp",
        "sources/Renderer/RenderSystemRegistry.h",
        "sources/Renderer/RenderSystemUtils.h",
        "sources/Renderer/RenderTarget.cpp",
        "sources/Renderer/RenderTargetUtils.cpp",
        "sources/Renderer/RenderTargetUtils.h",
        "sources/Renderer/ResourceUtils.cpp",
        "sources/Renderer/ResourceUtils.h",
        "sources/Renderer/Sampler.cpp",
        "sources/Renderer/SegmentedBuffer.h",
        "sources/Renderer/Shader.cpp",
        "sources/Renderer/ShaderFlags.cpp",
        "sources/Renderer/StaticAssertions.cpp",
        "sources/Renderer/StaticAssertions.h",
        "sources/Renderer/StaticModuleInterface.cpp",
        "sources/Renderer/StaticModuleInterface.h",
        "sources/Renderer/SwapChain.cpp",
        "sources/Renderer/Texture.cpp",
        "sources/Renderer/TextureFlags.cpp",
        "sources/Renderer/TextureUtils.cpp",
        "sources/Renderer/TextureUtils.h",
        "sources/Renderer/VertexAttribute.cpp",
        "sources/Renderer/VideoAdapter.h",
        "sources/Renderer/VirtualCommandBuffer.h",

        "sources/Renderer/DebugLayer/**.h",
        "sources/Renderer/DebugLayer/**.cpp",
        "sources/Renderer/SPIRV/**.cpp",

        "external/SPIRV-Headers/include/**.h",

        "external/stb/**.h",
        "external/OpenGL/include/**.h",

    }

    includedirs {
        "include",
        "external/OpenGL/include",
        "external/SPIRV-Headers/include",
        "external/GaussianLib/include",
    }
    
    -- Add Vulkan SDK include directory if available
    if VULKAN_SDK then
        includedirs {
            VULKAN_SDK .. "/Include",
        }
    end

    defines { 
        "LLGL_BUILD_STATIC_LIB", 
    }

    if os.target() == "windows" then
        files {
            "sources/Platform/Win32/**.h",
            "sources/Platform/Win32/**.cpp",
            
            -- OpenGL 
            "sources/Renderer/OpenGL/GLCore.h",
            "sources/Renderer/OpenGL/GLCore.cpp",
            "sources/Renderer/OpenGL/GLModuleInterface.cpp",
            "sources/Renderer/OpenGL/GLObjectUtils.cpp",
            "sources/Renderer/OpenGL/GLRenderingCaps.h",
            "sources/Renderer/OpenGL/GLRenderSystem.cpp",
            "sources/Renderer/OpenGL/GLRenderSystem.h",
            "sources/Renderer/OpenGL/GLStaticAssertions.cpp",
            "sources/Renderer/OpenGL/GLSwapChain.cpp",
            "sources/Renderer/OpenGL/GLSwapChain.h",
            "sources/Renderer/OpenGL/GLTypes.cpp",
            "sources/Renderer/OpenGL/GLTypes.h",
            "sources/Renderer/OpenGL/OpenGL.h",

            "sources/Renderer/OpenGL/Buffer/**.h", 
            "sources/Renderer/OpenGL/Buffer/**.cpp", 
            "sources/Renderer/OpenGL/Command/**.h", 
            "sources/Renderer/OpenGL/Command/**.cpp", 
            "sources/Renderer/OpenGL/Ext/**.h", 
            "sources/Renderer/OpenGL/Ext/**.cpp", 
            "sources/Renderer/OpenGL/Platform/Win32/**.h", 
            "sources/Renderer/OpenGL/Platform/Win32/**.cpp", 
            "sources/Renderer/OpenGL/Platform/GLContext.h",
            "sources/Renderer/OpenGL/Platform/GLContext.cpp",
            "sources/Renderer/OpenGL/Platform/GLContextManager.h",
            "sources/Renderer/OpenGL/Platform/GLContextManager.cpp",
            "sources/Renderer/OpenGL/Platform/GLSwapChainContext.h",
            "sources/Renderer/OpenGL/Platform/GLSwapChainContext.cpp",

            "sources/Renderer/OpenGL/Profile/GLProfile.h", 
            "sources/Renderer/OpenGL/Profile/GLCompat/**.h", 
            "sources/Renderer/OpenGL/Profile/GLCompat/**.cpp", 
            "sources/Renderer/OpenGL/Profile/GLCore/**.h", 
            "sources/Renderer/OpenGL/Profile/GLCore/**.cpp", 
            
            "sources/Renderer/OpenGL/RenderState/**.h", 
            "sources/Renderer/OpenGL/RenderState/**.cpp", 
            "sources/Renderer/OpenGL/Shader/**.h", 
            "sources/Renderer/OpenGL/Shader/**.cpp", 
            "sources/Renderer/OpenGL/Texture/**.h", 
            "sources/Renderer/OpenGL/Texture/**.cpp", 


            "sources/Renderer/Vulkan/**.h", 
            "sources/Renderer/Vulkan/**.cpp", 
            
            -- Direct3D11 and Direct3D12 are disabled (defines commented out above)
            -- Uncomment these lines and the defines above if you want to enable them:
            --"sources/Renderer/Direct3D11/**.h", 
            --"sources/Renderer/Direct3D11/**.cpp",
            --
            --"sources/Renderer/Direct3D12/**.h", 
            --"sources/Renderer/Direct3D12/**.cpp",
        }
        
        removefiles {
            "include/LLGL/Platform/Android/**.h",
            "include/LLGL/Platform/IOS/**.h",
            "include/LLGL/Platform/Linux/**.h",
            "include/LLGL/Platform/MacOS/**.h",
            "include/LLGL/Platform/UWP/**.h",
            "include/LLGL/Platform/Wasm/**.h",

            "include/LLGL/Backend/Metal/**.h",
        }

        systemversion "latest"

        defines {
            "LLGL_PLATFORM_WINDOWS",
            "NOMINMAX",  -- Prevent Windows.h from defining min/max macros that break std::min/std::max
            "WIN32_LEAN_AND_MEAN",  -- Exclude rarely-used stuff from Windows headers
            --"LLGL_BUILD_RENDERER_DIRECT3D11",
            --"LLGL_BUILD_RENDERER_DIRECT3D12",
            "LLGL_BUILD_RENDERER_OPENGL",
            "LLGL_BUILD_RENDERER_VULKAN",
            "LLGL_OPENGL",
        }

        links {
            "user32", "gdi32", "shell32", "ole32", "oleaut32", "advapi32",
            -- Direct3D libraries are disabled (renderers are not enabled)
            -- Uncomment if enabling Direct3D11/Direct3D12:
            --"dxgi", "d3d11", "d3d12", "dxguid", "d3dcompiler",
            "opengl32",
            "vulkan-1"
        }
        
        -- Add Vulkan SDK library directory if available
        if VULKAN_SDK then
            libdirs {
                VULKAN_SDK .. "/Lib",
            }
        end

    elseif os.target() == "macosx" then
        pic "On"
        systemversion "latest"
        defines { 
            "LLGL_PLATFORM_MACOS", 
            "LLGL_BUILD_RENDERER_METAL", 
            "LLGL_BUILD_RENDERER_OPENGL" 
        }

        files { 
            "sources/Platform/MacOS/**.h",
            "sources/Platform/MacOS/**.mm",

            "sources/Renderer/OpenGL/**.h", 
            "sources/Renderer/OpenGL/**.cpp", 

            "sources/Renderer/Vulkan/**.h", 
            "sources/Renderer/Vulkan/**.cpp", 

            "sources/Renderer/Metal/**.h", 
            "sources/Renderer/Metal/**.cpp",
        }

        removefiles {
            "include/LLGL/Platform/Android/**.h",
            "include/LLGL/Platform/IOS/**.h",
            "include/LLGL/Platform/Win32/**.h",
            "include/LLGL/Platform/Linux/**.h",
            "include/LLGL/Platform/UWP/**.h",
            "include/LLGL/Platform/Wasm/**.h",

            "include/LLGL/Backend/Direct3D11/**.h",
            "include/LLGL/Backend/Direct3D12/**.h",
        }

        links { 
            "Cocoa.framework", 
            "QuartzCore.framework", 
            "Metal.framework", 
            "OpenGL.framework" 
        }

    elseif os.target() == "linux" then
        pic "On"
        systemversion "latest"
        
        defines { 
            "LLGL_PLATFORM_LINUX", 
            "LLGL_BUILD_RENDERER_OPENGL", 
            "LLGL_BUILD_RENDERER_VULKAN" 
        }
        
        files { 
            "sources/Platform/Linux/**.h",
            "sources/Platform/Linux/**.cpp",

            "sources/Renderer/OpenGL/**.h", 
            "sources/Renderer/OpenGL/**.cpp", 

            "sources/Renderer/Vulkan/**.h", 
            "sources/Renderer/Vulkan/**.cpp", 
        }

        removefiles {
            "include/LLGL/Platform/Android/**.h",
            "include/LLGL/Platform/IOS/**.h",
            "include/LLGL/Platform/Win32/**.h",
            "include/LLGL/Platform/MacOS/**.h",
            "include/LLGL/Platform/UWP/**.h",
            "include/LLGL/Platform/Wasm/**.h",

            "include/LLGL/Backend/Metal/**.h",
            "include/LLGL/Backend/Direct3D11/**.h",
            "include/LLGL/Backend/Direct3D12/**.h",
        }

        links { 
            "X11", "Xrandr", "dl", "pthread", 
            "GL", "vulkan" 
        }
    end

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

