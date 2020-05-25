------ Set the wallpaper
local wallpaper = {}

local gears=require("gears")
local beautiful=require("beautiful")

function wallpaper.set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
function wallpaper.connect()
  screen.connect_signal("property::geometry", wallpaper.set_wallpaper)
end

return wallpaper
