require "ecc"

workspace "VulkanGuide"
configurations { "Debug", "Release", "Distribution" }
architecture "x64"

project "VulkanGuide"
kind "ConsoleApp"
platforms { "Windows", "Linux", "Mac" }
language "C++"
cppdialect "C++20"

targetname "VulkanGuide"

files {
    "vendor/imgui/*.cpp",
    "vendor/imgui/backends/imgui_impl_vulkan.cpp",
    "vendor/imgui/backends/imgui_impl_sdl3.cpp",
    "source/**.cpp",
    "source/*.cpp",
    "include/**.h",
    "include/*.h"
}

pchheader "include/pch.h"

includedirs {
    "include",
    "vendor/imgui",
    "vendor/imgui/backends",
    "vendor/imgui/misc",
    "vendor/sdl3/include",
    "vendor/sdl3/include/SDL",
    "vendor/stb",
    "vendor/glm",
    "vendor/imgui",
    "vendor/tinyobjloader",
    "vendor/vk-bootstrap/src",
    "vendor/vma/include",
}

objdir "obj/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/"
targetdir "bin/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/"

filter "configurations:Debug"
defines { "CONFIGURATION_DEBUG" }
symbols "On"

filter "configurations:Release"
defines { "CONFIGURATION_RELEASE" }
optimize "On"

filter "configurations:Distribution"
defines { "CONFIGURATION_DISTRIBUTION" }
optimize "On"

filter "system:Windows"
defines { "PLATFORM_WINDOWS" }

filter "system:Linux"
defines { "PLATFORM_LINUX" }
libdirs {
    "vendor/sdl3/build",
    "vendor/glm/build/glm",
    "vendor/tinyobjloader/build",
    "vendor/vk-bootstrap/build",
}
linkoptions "-lSDL3 -lglm -ltinyobjloader -lvk-bootstrap -lvulkan"
prebuildcommands {
    "echo prebuildcommands\n",
    "cp vendor/sdl3/build/libSDL3.so bin/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/libSDL3.so"
}

filter "system:Mac"
defines { "PLATFORM_MAC" }
