require "ecc"

workspace "VulkanGuide"
configurations { "Debug", "Release", "Distribution" }
platforms { "Windows", "Unix", "Mac" }
architecture "x64"
toolset "gcc"

project "VulkanGuide"
kind "ConsoleApp"
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

includedirs {
    "include",
    "vendor/imgui",
    "vendor/imgui/backends",
    "vendor/imgui/misc",
    "vendor/sdl3/include",
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

filter "platforms:Windows"
system "windows"
defines { "PLATFORM_WINDOWS" }

filter "platforms:Unix"
system "linux"
defines { "PLATFORM_LINUX" }
libdirs {
    "vendor/sdl3/build",
    "vendor/glm/build/glm",
    "vendor/tinyobjloader/build",
    "vendor/vk-bootstrap/build",
}
linkoptions "`pkg-config --libs sdl3 vulkan` -lglm -ltinyobjloader -lvk-bootstrap"
prebuildcommands {
    "cp vendor/sdl3/build/libSDL3.so bin/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/libSDL3.so",
}

filter "platforms:Mac"
system "macosx"
defines { "PLATFORM_MACOSX" }
