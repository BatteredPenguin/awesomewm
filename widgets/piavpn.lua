-------------------------------------------------
-- PIA VPN Widget for Awesome Window Manager
-- Shows the state of the PIA VPN connection

-- @author Richard Hyde
-- @copyright 2020 Richard Hyde
-------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local CONNECTED_ICON = "/usr/share/icons/mate/scalable/status/network-vpn-symbolic.svg"
local DISCONNECTED_ICON = "/usr/share/icons/mate/scalable/status/network-error-symbolic.svg"
local STATUS_CMD = "sudo /usr/local/sbin/piavpn -s"
local widget = {}

local function worker(args)

    local args = args or {}
    local icon = {
        id = "icon",
        image = DISCONNECTED_ICON,
        resize = true,
        widget = wibox.widget.imagebox,
    }

    widget = wibox.widget {
        icon,
        widget = wibox.container.place
    }

    local update_graphic = function(widget, stdout, _, _, _)
        if stdout == "No PIA VPN status file or PIA VPN not active\n" then
            widget.icon.image = DISCONNECTED_ICON
        else
            widget.icon.image = CONNECTED_ICON
        end
    end
    -- Popup with battery info
    -- One way of creating a pop-up notification - naughty.notify
    local notification
    function show_status()
        awful.spawn.easy_async_with_shell(STATUS_CMD,
                function(stdout)
                    naughty.destroy(notification)
                    notification = naughty.notify {
                        text = stdout,
                        title = "PIA VPN",
                        timeout = 5,
                        hover_timeout = 0.5,
                        width = 200,
                    }
                end)
    end

    widget:connect_signal("mouse::enter", function()
        show_status()
    end)
    widget:connect_signal("mouse::leave", function()
        naughty.destroy(notification)
    end)

    watch(STATUS_CMD, 15, update_graphic, widget)

    return widget
end

return setmetatable(widget, { __call = function(_, ...) return worker(...) end })

