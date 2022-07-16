local just = require("just")
local just_print = require("just.print")
local fonts = require("fonts")
local Button = require("views.Button")
local engine = require("engine")

return function()
	engine:draw()

	local width, height = love.graphics.getDimensions()
	love.graphics.origin()
	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.setFont(fonts.NotoSansMono24)

	local padding = 50

	love.graphics.translate(padding, padding)
	just.text("Score:      " .. engine.score)
	just.text("Best score: " .. engine.bestScore)
	just.text("HP: " .. engine.hp)

	love.graphics.setFont(fonts.NotoSans24)
	if engine.score == 0 then
		love.graphics.origin()
		love.graphics.translate(width - padding - 200, padding)
		just.text("Press the right arrow button if the sum on the red dice is even,", 200)
		just.text("the left arrow button if it is odd.", 200)
	end

	love.graphics.setFont(fonts.NotoSans24)
	love.graphics.origin()
	love.graphics.translate(padding, height - padding - 400 / 3)
	if Button("Restart", 200, 200 / 3) then
		engine:load()
		engine:play()
	end
	if Button("Quit", 200, 200 / 3) then
		engine.hp = 0
	end
end
