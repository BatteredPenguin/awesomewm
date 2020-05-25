
---- Autorun programs
local autorun={}

local awful = require("awful")

function autorun.run()

  -- Background apps
  awful.spawn.with_shell("xscreensaver -nosplash")
  awful.spawn.with_shell("compton")
  awful.spawn.with_shell("nm-applet")

  -- Main tag apps
  awful.spawn({"cherrytree", "/home/richard/Documents/cherry.ctb"}, {  tag = "Main" })
  awful.spawn("kitty", { tag = "Main", focus = true }, function (c)
    c:swap(awful.client.getmaster())
  end)
  
  -- Firefox
  awful.spawn("firefox", {  tag = "Firefox" })


end

return autorun

