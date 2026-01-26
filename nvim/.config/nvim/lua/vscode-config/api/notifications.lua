-- Notification Commands

function NotificationsToggle()
	VSCodeNotify("notifications.toggleList")
end

function NotificationsDoNotDisturb()
	VSCodeNotify("notifications.toggleDoNotDisturbMode")
end

function NotificationsClear()
	VSCodeNotify("notifications.clearAll")
end

function NotificationsDismiss()
	VSCodeNotify("notifications.hideToasts")
end
