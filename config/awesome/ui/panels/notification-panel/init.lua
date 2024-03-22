local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

--- Notification Panel
--- ~~~~~~~~~~~~~~~~~~

return function(s)
	s.notification_panel = awful.popup({
		type = "dock",
		screen = s,
		minimum_height = s.geometry.height - (beautiful.wibar_height),
		maximum_height = s.geometry.height - (beautiful.wibar_height),
		minimum_width = dpi(350),
		maximum_width = dpi(350),
		bg = beautiful.transparent,
		ontop = true,
		visible = false,
		placement = function(w)
			awful.placement.top_right(w, {
				margins = { top = beautiful.wibar_height },
			})
		end,
		widget = {
			{
				{
					layout = wibox.layout.flex.vertical,
					spacing = dpi(17.5),
					nil,
					require("ui.panels.notification-panel.notif-center")(s),
					nil,
				},
				margins = dpi(15),
				widget = wibox.container.margin,
			},
			id = "notification_panel",
			bg = beautiful.wibar_bg,
			widget = wibox.container.background,
		},
	})

	--- Toggle container visibility
	awesome.connect_signal("notification_panel::toggle", function(scr)
		if scr == s then
			s.notification_panel.visible = not s.notification_panel.visible
		end
	end)
end
