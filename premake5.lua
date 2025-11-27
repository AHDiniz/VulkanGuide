workspace "VulkanGuide"
configurations { "Debug", "Release", "Distribution" }
architecture "x64"

project "VulkanGuide"
kind "ConsoleApp"
language "C++"
cppdialect "C++20"

targetname "VulkanGuide"

files { "source/**.cpp", "source/*.cpp", "include/**.h" }

includedirs {
    "../vendor/sdl3/include",
    "include",
}

objdir "obj/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/"
targetdir "bin/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/"

filter "configurations:Debug"
defines { "CONFIGURATION_DEBUG" }
symbols "On"

filter "configurations:Release"
defines { "CONFIGURATION_RELEASE" }
optimize "On"

filter "system:windows"
defines { "PLATFORM_WINDOWS" }
libdirs { "../vendor/sdl3/bin/windows/x64" }
linkoptions { "-lutilities -lSDL3 -mwindows" }
postbuildcommands {
    "cp %[../vendor/sdl3/bin/windows/x64/SDL3.dll] %[bin/%{cfg.buildcfg}/%{cfg.system}/%{cfg.architecture}/SDL3.dll]"
}

filter "system:unix"
defines { "PLATFORM_UNIX" }

filter "system:mac"
defines { "PLATFORM_MAC" }
