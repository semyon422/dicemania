local just = require("just")
local Game = require("views.Game")
local engine = require("engine")
local sounds = require("sounds")

function love.mousemoved(x, y)
	if just.mousemoved(x, y) then
		return
	end
end

function love.mousepressed(x, y, button)
	if just.mousepressed(x, y, button) then
		return
	end
end

function love.mousereleased(x, y, button)
	if just.mousereleased(x, y, button) then
		return
	end
end

function love.wheelmoved(x, y)
	if just.wheelmoved(x, y) then
		return
	end
end

function love.keypressed(_, key)
	if key == "f11" then
		return love.window.setFullscreen(not love.window.getFullscreen())
	end
	engine:keypressed(key)
end

function love.load()
	engine:load()
	sounds.bgm:setLooping(true)
	sounds.bgm:play()
end

function love.update(dt)
	engine:update(dt)
end

function love.draw()
	Game()
	just._end()
end
