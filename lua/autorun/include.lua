if CLIENT then
    include("cl_menu.lua")
end

if SERVER then 
    include("sv_menu.lua")
    AddCSLuaFile("cl_menu.lua")
    AddCSLuaFile("sh_menuconfig.lua")
    include("sh_menuconfig.lua")
end