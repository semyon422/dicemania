return function(num, size, current)
	love.graphics.setColor(1, 1, 1, 1)
	if current then
		love.graphics.setColor(1, 0.2, 0.2, 1)
	end
	love.graphics.rectangle("fill", 0, 0, size, size, size / 6, size / 6)

	local pos = {0.2, 0.5, 0.8}

	love.graphics.setColor(0, 0, 0, 1)
	if current then
		love.graphics.setColor(1, 1, 1, 1)
	end

	local rad = size / 9
	if num == 1 then
		love.graphics.circle("fill", size * pos[2], size * pos[2], rad)
	elseif num == 2 then
		love.graphics.circle("fill", size * pos[1], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[3], rad)
	elseif num == 3 then
		love.graphics.circle("fill", size * pos[1], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[2], size * pos[2], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[3], rad)
	elseif num == 4 then
		love.graphics.circle("fill", size * pos[1], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[1], size * pos[3], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[3], rad)
	elseif num == 5 then
		love.graphics.circle("fill", size * pos[1], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[1], size * pos[3], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[3], rad)
		love.graphics.circle("fill", size * pos[2], size * pos[2], rad)
	elseif num == 6 then
		love.graphics.circle("fill", size * pos[1], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[1], size * pos[3], rad)
		love.graphics.circle("fill", size * pos[1], size * pos[2], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[2], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[1], rad)
		love.graphics.circle("fill", size * pos[3], size * pos[3], rad)
	end
end
