-- local icons = require("icon_list")
-- local colors = require("colors")
-- local settings = require("settings")

-- local vpn = sbar.add("item", "widgets.vpn", {
-- 	position = "right",
-- 	icon = {
-- 		string = icons.vpn.Off,
-- 		font = {
-- 			style = settings.font.style_map["Bold"],
-- 			size = 20.0,
-- 		},
-- 		color = colors.red,
-- 	},
-- 	label = {
-- 		string = "VPN",
-- 		font = {
-- 			family = settings.font.numbers,
-- 			style = settings.font.style_map["Bold"],
-- 			size = 12.0,
-- 		},
-- 		color = colors.red,
-- 	},
-- 	update_freq = 10,
-- })

-- local function update_vpn_status()
-- 	sbar.exec(
-- 		[[
--         if ifconfig | grep -q "utun"; then
--             echo "connected"
--         elif pgrep -x "openvpn" >/dev/null; then
--             echo "connected"
--         else
--             echo "disconnected"
--         fi
--     ]],
-- 		function(status)
-- 			local connected = status:match("connected")
-- 			vpn:set({
-- 				icon = {
-- 					color = connected and colors.green or colors.red,
-- 					string = connected and icons.vpn.On or icons.vpn.Off,
-- 				},
-- 				label = {
-- 					string = connected and "VPN" or "No VPN",
-- 					color = connected and colors.green or colors.red,
-- 				},
-- 			})
-- 		end
-- 	)
-- end

-- vpn:subscribe({ "routine", "system_woke" }, update_vpn_status)

-- vpn:subscribe("mouse.clicked", function()
-- 	sbar.exec("open -a Tunnelblick")
-- end)

-- sbar.add("bracket", "widgets.vpn.bracket", { vpn.name }, {
-- 	background = {
-- 		color = colors.bg1,
-- 		border_color = colors.rainbow[#colors.rainbow - 3],
-- 		border_width = 1,
-- 	},
-- })

-- sbar.add("item", "widgets.vpn.padding", {
-- 	position = "right",
-- 	width = settings.group_paddings,
-- })

local icons = require("icon_list")
local colors = require("colors")
local settings = require("settings")

local popup_width = 250

local vpn = sbar.add("item", "widgets.vpn", {
    position = "right",
    icon = {
        string = icons.vpn.Off,
        font = {
            style = settings.font.style_map["Bold"],
            size = 20.0,
        },
        color = colors.red,
    },
    label = {
        string = "VPN",
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Bold"],
            size = 12.0,
        },
        color = colors.red,
    },
    update_freq = 10,
})

-- Padding for alignment
sbar.add("item", "widgets.vpn.padding", {
    position = "right",
    width = settings.group_paddings,
})

-- Bracket for background and popup
local vpn_bracket = sbar.add("bracket", "widgets.vpn.bracket", { vpn.name }, {
    background = {
        color = colors.bg1,
        border_color = colors.rainbow[#colors.rainbow - 3],
        border_width = 1,
    },
    popup = {
        align = "center",
        height = 30,
    },
})

-- Popup items
local vpn_interface = sbar.add("item", {
    position = "popup." .. vpn_bracket.name,
    icon = {
        string = "Interface:",
        width = popup_width / 2,
        align = "left",
    },
    label = {
        string = "???",
        width = popup_width / 2,
        align = "right",
    },
})

local vpn_ip = sbar.add("item", {
    position = "popup." .. vpn_bracket.name,
    icon = {
        string = "VPN IP:",
        width = popup_width / 2,
        align = "left",
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right",
    },
})

local vpn_config = sbar.add("item", {
    position = "popup." .. vpn_bracket.name,
    icon = {
        string = "Config:",
        width = popup_width / 2,
        align = "left",
    },
    label = {
        string = "???",
        width = popup_width / 2,
        align = "right",
    },
})

local vpn_server = sbar.add("item", {
    position = "popup." .. vpn_bracket.name,
    icon = {
        string = "Server:",
        width = popup_width / 2,
        align = "left",
    },
    label = {
        string = "???",
        width = popup_width / 2,
        align = "right",
    },
})

-- Hide popup
local function hide_details()
    vpn_bracket:set({
        popup = {
            drawing = false,
        },
    })
end

-- Show popup and update info
local function toggle_details()
    local should_draw = vpn_bracket:query().popup.drawing == "off"
    if should_draw then
        vpn_bracket:set({
            popup = {
                drawing = true,
            },
        })
        -- Find VPN interface (utun/tun)
        sbar.exec([[ifconfig | grep -Eo 'utun[0-9]+' | head -n1]], function(interface)
            interface = interface:gsub("%s+", "")
            vpn_interface:set({ label = interface ~= "" and interface or "???" })
            -- Get VPN IP
            if interface ~= "" then
                sbar.exec("ipconfig getifaddr " .. interface, function(ip)
                    vpn_ip:set({ label = ip ~= "" and ip or "???.???.???.???" })
                end)
            else
                vpn_ip:set({ label = "???.???.???.???" })
            end
        end)
        -- Get OpenVPN config file in use
        sbar.exec([[ps aux | grep '[o]penvpn' | awk '{for(i=1;i<=NF;i++) if ($i ~ /\.conf$/) print $i}' | head -n1]], function(config)
            config = config:gsub("%s+", "")
            vpn_config:set({ label = config ~= "" and config or "???" })
            -- Try to extract server from config file if possible
            if config ~= "" then
                sbar.exec("grep '^remote ' " .. config .. " | awk '{print $2}' | head -n1", function(server)
                    vpn_server:set({ label = server ~= "" and server or "???" })
                end)
            else
                vpn_server:set({ label = "???" })
            end
        end)
    else
        hide_details()
    end
end

-- Main status updater
local function update_vpn_status()
    sbar.exec([[
        if ifconfig | grep -q "utun"; then
            echo "connected"
        elif pgrep -x "openvpn" >/dev/null; then
            echo "connected"
        else
            echo "disconnected"
        fi
    ]], function(status)
        local connected = status:match("connected")
        vpn:set({
            icon = {
                color = connected and colors.green or colors.red,
                string = connected and icons.vpn.On or icons.vpn.Off,
            },
            label = {
                string = connected and "VPN" or "No VPN",
                color = connected and colors.green or colors.red,
            },
        })
    end)
end

vpn:subscribe({ "routine", "system_woke", "vpn_change" }, update_vpn_status)
vpn:subscribe("mouse.clicked", toggle_details)
vpn:subscribe("mouse.exited.global", hide_details)

-- Copy label to clipboard on popup item click
local function copy_label_to_clipboard(env)
    local label = sbar.query(env.NAME).label.value
    sbar.exec('echo "' .. label .. '" | pbcopy')
    sbar.set(env.NAME, {
        label = {
            string = icons.kind and icons.kind.Clipboard or "󰅍",
            align = "center",
        },
    })
    sbar.delay(1, function()
        sbar.set(env.NAME, {
            label = {
                string = label,
                align = "right",
            },
        })
    end)
end

vpn_interface:subscribe("mouse.clicked", copy_label_to_clipboard)
vpn_ip:subscribe("mouse.clicked", copy_label_to_clipboard)
vpn_config:subscribe("mouse.clicked", copy_label_to_clipboard)
vpn_server:subscribe("mouse.clicked", copy_label_to_clipboard)
