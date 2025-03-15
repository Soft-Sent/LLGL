project "LLGL_Direct3D12"
  kind "StaticLib"
  language "C++"
  cppdialect "C++11"
  staticruntime "on"

  targetdir ("bin/" .. outputdir .. "/%{prj.name}")
  objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- Options
  newoption {
      trigger = "d3d12-featurelevel",
      description = "Enable maximum Direct3D 12 feature level",
      allowed = {
          { "Direct3D 12.0", "Direct3D 12.0" },
          { "Direct3D 12.1", "Direct3D 12.1" },
          { "Direct3D 12.2", "Direct3D 12.2" }
      }
  }
  local featureLevel12 = "0"
  if _OPTIONS["d3d12-featurelevel"] == "Direct3D 12.2" then
      featureLevel12 = "2"
  elseif _OPTIONS["d3d12-featurelevel"] == "Direct3D 12.1" then
      featureLevel12 = "1"
  end
  defines { "LLGL_D3D12_ENABLE_FEATURELEVEL=" .. featureLevel12, "NOMINMAX" }

  -- Source files
  includedirs { 
    "../../../include"
  } 
  files {
      "**.h", "**.cpp",
      "Buffer/**.h", "Buffer/**.cpp",
      "Command/**.h", "Command/**.cpp",
      "RenderState/**.h", "RenderState/**.cpp",
      "Shader/**.h", "Shader/**.cpp",
      "Shader/Builtin/D3D12Builtin.h",
      "Texture/**.h", "Texture/**.cpp",
  }
  
  -- Source group filters
  vpaths {
      ["Direct3D12/"] = { "**.cpp", "**.h" },
      ["Direct3D12/Buffer/"] = { "Buffer/**.cpp", "Buffer/**.h" },
      ["Direct3D12/Command/"] = { "Command/**.cpp", "Command/**.h" },
      ["Direct3D12/RenderState/"] = { "RenderState/**.cpp", "RenderState/**.h" },
      ["Direct3D12/Shader/"] = { "Shader/**.cpp", "Shader/**.h" },
      ["Direct3D12/Shader/Builtin/"] = { "Shader/Builtin/D3D12Builtin.h" },
      ["Direct3D12/Texture/"] = { "Texture/**.cpp", "Texture/**.h" },
      ["../../Platform/"] = { "../Renderer/Direct3D12/**.h" }
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
  links { "d3d12", "dxgi", "D3DCompiler" }
  includedirs { "../DXCommon" }