local just = require("just")
local just_print = require("just.print")
local sounds = require("sounds")

return function(text, w, h)
	local changed, active, hovered = just.button_behavior(text, just.is_over(w, h))
	if hovered then
		local alpha = active and 0.2 or 0.1
		love.graphics.setColor(1, 1, 1, alpha)
		love.graphics.rectangle("fill", 0, 0, w, h)
	end
	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.rectangle("line", 0, 0, w, h)
	just_print(text, 0, 0, w, h, "center", "center")

	just.next(w, h)

	if just.entered_id == text then
		sounds.blipSelect:stop()
		sounds.blipSelect:play()
	end

	if changed then
		sounds.click:stop()
		sounds.click:play()
	end

	return changed
end
