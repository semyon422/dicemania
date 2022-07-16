local MainMenu = require("views.MainMenu")
local Gameplay = require("views.Gameplay")
local Background = require("views.Background")
local engine = require("engine")

local screen = "main menu"
local bgState = 1
return function()
	Background(bgState)
	if screen == "main menu" then
		screen = MainMenu()
		if screen == "gameplay" then
			engine:load()
			engine:play()
			bgState = bgState + 1
		end
	elseif screen == "gameplay" then
		Gameplay()
		if engine:needQuit() then
			engine:saveScore()
			screen = "main menu"
			bgState = bgState + 1
		end
	end
end
