project "LLGL"
    kind "StaticLib"
    language "C++"
    cppdialect "C++11"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "include/**.h",
        "sources/Core/**.h",
        "sources/Core/**.cpp",

        "sources/Renderer/DebugLayer/**.h",
        "sources/Renderer/DebugLayer/**.cpp",
        "sources/Renderer/SPIRV/**.h",
        "sources/Renderer/SPIRV/**.hpp",
        "sources/Renderer/SPIRV/**.cpp",

        "sources/Renderer/BindingIterator.cpp",
        "sources/Renderer/BindingIterator.h",
        "sources/Renderer/Buffer.cpp",
        "sources/Renderer/BufferArray.cpp",
        "sources/Renderer/BufferFlags.cpp",
        "sources/Renderer/BufferUtils.h",
        "sources/Renderer/BufferUtils.cpp",
        "sources/Renderer/BuildID.h",
        "sources/Renderer/CheckedCast.h",
        "sources/Renderer/ContainerTypes.h",
        "sources/Renderer/DynamicModuleInterface.h",
        "sources/Renderer/Format.cpp",
        "sources/Renderer/ModuleInterface.h",
        "sources/Renderer/PipelineStateFlags.cpp",
        "sources/Renderer/PipelineStateUtils.h",
        "sources/Renderer/PipelineStateUtils.cpp",
        "sources/Renderer/ProxyPipelineCache.h",
        "sources/Renderer/ProxyPipelineCache.cpp",
        "sources/Renderer/QueryHeap.cpp",
        "sources/Renderer/RenderingDebugger.cpp",
        "sources/Renderer/RenderPassUtils.h",
        "sources/Renderer/RenderPassUtils.cpp",
        "sources/Renderer/RenderSystem.cpp",
        "sources/Renderer/RenderSystemFlags.cpp",
        "sources/Renderer/RenderSystemModule.h",
        "sources/Renderer/RenderSystemModule.cpp",
        "sources/Renderer/RenderSystemRegistry.h",
        "sources/Renderer/RenderSystemRegistry.cpp",
        "sources/Renderer/RenderSystemUtils.h",
        "sources/Renderer/RenderTarget.cpp",
        "sources/Renderer/RenderTargetUtils.h",
        "sources/Renderer/RenderTargetUtils.cpp",
        "sources/Renderer/ResourceUtils.h",
        "sources/Renderer/ResourceUtils.cpp",
        "sources/Renderer/Sampler.cpp",
        "sources/Renderer/SegmentedBuffer.h",
        "sources/Renderer/Shader.cpp",
        "sources/Renderer/ShaderFlags.cpp",

        "sources/Renderer/StaticAssertions.h",
        "sources/Renderer/StaticAssertions.cpp",
        "sources/Renderer/StaticModuleInterface.h",
        "sources/Renderer/StaticModuleInterface.cpp",
        "sources/Renderer/SwapChain.cpp",
        "sources/Renderer/Texture.cpp",
        "sources/Renderer/TextureFlags.cpp",
        "sources/Renderer/TextureUtils.h",
        "sources/Renderer/TextureUtils.cpp",
        "sources/Renderer/VertexAttribute.cpp",
        "sources/Renderer/VideoAdapter.h",
        "sources/Renderer/VirtualCommandBuffer.h",
    }

    includedirs {
        "include",
        "sources/Renderer/SPIRV",
    }

    filter "system:windows"
        systemversion "latest"
        defines { "LLGL_PLATFORM_WINDOWS" }

    filter "system:linux"
        pic "On"
        systemversion "latest"
        defines { "LLGL_PLATFORM_LINUX" }

    filter "system:macosx"
        pic "On"
        systemversion "latest"
        defines { "LLGL_PLATFORM_MACOS" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"
        defines { "LLGL_DEBUG" }

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
        defines { "LLGL_RELEASE", "NDEBUG" }

    filter "configurations:Distribution"
        optimize "Full"
        runtime "Release"
        symbols "Off"
        defines { "LLGL_DISTRIBUTION", "NDEBUG" }
    filter()

    if os.istarget("windows") then
        include "sources/Renderer/Direct3D11/"
        include "sources/Renderer/Direct3D12/"
        include "sources/Renderer/DXCommon/"
        --include "sources/Renderer/Null/"
        --include "sources/Renderer/OpenGL/"
        --include "sources/Renderer/Vulkan/"
    end
    if os.istarget("macosx") then
        include "sources/Renderer/Metal"
    end