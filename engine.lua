local just = require("just")
local tween = require("tween")
local Timer = require("Timer")
local transform = require("transform")
local Dice = require("views.Dice")
local sounds = require("sounds")
local tf = {0, 0, 0, {0, 1 / 480}, {0, 1 / 480}, 0, 0, 0, 0}

local r = love.math.random

local engine = {}

function engine:load()
	self.timer = Timer:new()
	self.speed = 1
	self.targetSpeed = 1

	self.hitpos = 64
	self.distance = 96
	self.size = 48
	self.missWindow = 2

	self.noteInterval = 1
	self.noteIntervalMul = 1.01

	self.lastNoteTime = 2
	self:createNotes()

	self.score = 0
	self.bestScore = 0
	self.hp = 10

	if not love.filesystem.getInfo("score") then
		self.bestScore = 0
	else
		self.bestScore = tonumber((love.filesystem.read("score")))
	end
end

function engine:saveScore()
	love.filesystem.write("score", self.bestScore)
end

function engine:needQuit()
	return self.hp == 0
end

function engine:createNote()
	local dices = {r(1, 6), r(1, 6)}
	local rotations = {r(), r()}
	local rspeed = {r(), r()}
	local offsets = {{r(), r()}, {r(), r()}}

	table.insert(self.notes, {
		time = self.lastNoteTime,
		dices = dices,
		rotations = rotations,
		rspeed = rspeed,
		offsets = offsets,
		value = (dices[1] + dices[2] + 1) % 2 + 1,
	})
	self.lastNoteTime = self.lastNoteTime + self.noteInterval
end

function engine:createNotes()
	self.notes = {}

	for i = 1, 50 do
		engine:createNote()
	end
end

function engine:getCurrentNote()
	local eventTime = self.timer:getTime()

	local nearestIndex
	local nearestTime = math.huge
	for i = 1, #self.notes do
		local note = self.notes[i]
		local time = math.abs(note.time - eventTime)
		if time < nearestTime then
			nearestTime = time
			nearestIndex = i
		end
	end

	return self.notes[nearestIndex], nearestIndex
end

function engine:drawNote(note, time)
	local w, h = love.graphics.getDimensions()

	local pd = 48
	local x = 480 * w / h / 2 - self.distance / 2
	local oy = self.hitpos + pd

	local y = (note.time - time) * 100 * self.speed
	local current = self:getCurrentNote() == note

	local size = self.size

	love.graphics.replaceTransform(transform(tf))
	love.graphics.translate(x, oy + y)

	love.graphics.rotate(note.rotations[1] * math.pi * 2)
	love.graphics.translate(-size / 2, -size / 2)
	love.graphics.translate(note.offsets[1][1] * size / 3, note.offsets[1][2] * size / 3)
	Dice(note.dices[1], size, current)

	love.graphics.replaceTransform(transform(tf))
	love.graphics.translate(x + self.distance, oy + y)

	love.graphics.rotate(note.rotations[2] * math.pi * 2)
	love.graphics.translate(-size / 2, -size / 2)
	love.graphics.translate(note.offsets[2][1] * size / 3, note.offsets[2][2] * size / 3)
	Dice(note.dices[2], size, current)

	note.rotations[1] = note.rotations[1] + note.rspeed[1] * 0.001
	note.rotations[2] = note.rotations[2] + note.rspeed[2] * 0.001
end

function engine:draw()
	love.graphics.replaceTransform(transform(tf))

	local w, h = love.graphics.getDimensions()

	local pd = 48
	local x = 480 * w / h / 2 - self.distance / 2
	local oy = self.hitpos + pd

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle("line", x - pd * 2, oy - pd, self.distance + pd * 4, pd * 2, pd, pd)

	local time = self.timer:getTime()
	for _, note in ipairs(self.notes) do
		self:drawNote(note, time)
	end
end

function engine:play()
	self.timer:play()
end

function engine:pause()
	self.timer:pause()
end

function engine:update(dt)
	self.timer:update(dt)
	local time = self.timer:getTime()
	for i, note in ipairs(self.notes) do
		if note.time < time - self.missWindow then
			table.remove(self.notes, i)
			self:createNote()
			break
		end
	end
	if self.tween then
		self.tween:update(dt)
	end
end

local bindings = {
	left = 1,
	right = 2,
}
function engine:keypressed(key)
	if key == "escape" then
		self.hp = 0
	end
	if key == "`" then
		self:load()
		self:play()
		return
	end
	if self.hp == 0 then
		return
	end
	local note, index = self:getCurrentNote()
	if bindings[key] == note.value then
		self.noteInterval = self.noteInterval / self.noteIntervalMul
		self.timer:setRate(self.timer.rate * self.noteIntervalMul)
		self.targetSpeed = self.targetSpeed * self.noteIntervalMul
		self.tween = tween.new(0.5, self, {speed = self.targetSpeed}, "outQuad")

		self.score = self.score + 1
		self.bestScore = math.max(self.bestScore, self.score)

		sounds.pickupCoin:stop()
		sounds.pickupCoin:play()
	else
		sounds.hitHurt:play()
		self.hp = self.hp - 1
		if self.hp == 0 then
			self:pause()
		end
	end
	table.remove(self.notes, index)
	engine:createNote()
end

return engine
