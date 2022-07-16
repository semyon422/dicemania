local Dice = require("views.Dice")

local r = love.math.random

local dices
local state
return function(newState)
	if state ~= newState then
		dices = {}
		for i = 1, 10 do
			table.insert(dices, {
				r(1, 6), r(128, 512), r(1, 2) == 1,
				x = r(),
				y = r(),
				r = r(),
			})
		end
		state = newState
	end

	love.graphics.origin()
	local w, h = love.graphics.getDimensions()

	for i = 1, #dices do
		local dice = dices[i]
		local size = dice[2]
		love.graphics.origin()
		love.graphics.translate(dice.x * w, dice.y * h)
		love.graphics.rotate(dice.r * math.pi * 2)
		love.graphics.translate(-size / 2, -size / 2)
		Dice(unpack(dice))
	end

	love.graphics.origin()
	love.graphics.setColor(0, 0, 0, 0.8)
	love.graphics.rectangle("fill", 0, 0, w, h)
end
