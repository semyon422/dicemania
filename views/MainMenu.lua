local just = require("just")
local just_print = require("just.print")
local fonts = require("fonts")
local Button = require("views.Button")
local engine = require("engine")

return function()
	local width, height = love.graphics.getDimensions()
	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.setFont(fonts.NotoSans72)
	just_print("DICEMANIA", 0, 40, width, 200, "center", "bottom")
	love.graphics.setFont(fonts.NotoSans24)
	just_print("Best score: " .. engine.bestScore, 0, 240, width, 40, "center", "top")

	love.graphics.setColor(1, 1, 1, 0.5)
	love.graphics.setFont(fonts.NotoSans16)
	love.graphics.origin()
	love.graphics.translate(width - 200, 50)
	just.text("F11 - fullscreen", 200)
	just.text("~ - quick restart", 200)

	local buttonWidth = 200
	love.graphics.origin()
	love.graphics.translate(width / 2 - buttonWidth / 2, height / 2)
	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.setFont(fonts.NotoSans24)
	local screen = "main menu"
	if Button("Play", buttonWidth, buttonWidth / 3) then
		screen = "gameplay"
	end
	if Button("Exit", buttonWidth, buttonWidth / 3) then
		love.event.quit()
	end
	return screen
end
